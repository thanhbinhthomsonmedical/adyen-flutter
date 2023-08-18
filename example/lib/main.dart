import 'dart:async';

import 'package:adyen_checkout/adyen_checkout.dart';
import 'package:adyen_checkout/platform_api.g.dart';
import 'package:adyen_checkout_example/config.dart';
import 'package:adyen_checkout_example/network/service.dart';
import 'package:adyen_checkout_example/repositories/adyen_sessions_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _adyenCheckout = AdyenCheckout();
  late AdyenSessionsRepository _adyenSessionRepository;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    _adyenSessionRepository = AdyenSessionsRepository(
      adyenCheckout: _adyenCheckout,
      service: Service(),
    );

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _adyenCheckout.getPlatformVersion();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Running on: $_platformVersion\n'),
            TextButton(
                onPressed: () {
                  startDropInSessions(context);
                },
                child: const Text("DropIn sessions")),
            TextButton(
                onPressed: () {
                  startDropInAdvancedFlow(context);
                },
                child: const Text("DropIn advanced flow"))
          ],
        ),
      ),
    );
  }

  Future<void> startDropInSessions(BuildContext context) async {
    SessionModel sessionModel = await _adyenSessionRepository.createSession(
        Config.amount, Config.environment);
    DropInConfigurationModel dropInConfiguration = DropInConfigurationModel(
      environment: Environment.test,
      clientKey: Config.clientKey,
      amount: Config.amount,
      shopperLocale: Config.countryCode,
    );

    final sessionDropInResultModel = await _adyenCheckout
        .startDropInSessionsPayment(sessionModel, dropInConfiguration);

    _dialogBuilder(context, sessionDropInResultModel);
  }

  Future<void> startDropInAdvancedFlow(BuildContext context) async {
    final paymentMethodsResponse =
        await _adyenSessionRepository.fetchPaymentMethods();
    DropInConfigurationModel dropInConfiguration = DropInConfigurationModel(
      environment: Environment.test,
      clientKey: Config.clientKey,
      amount: Config.amount,
    );

    final paymentComponentJson =
        await _adyenCheckout.startDropInAdvancedFlowPayment(
      paymentMethodsResponse,
      dropInConfiguration,
    );

    Map<String, dynamic> paymentsResponse =
        await _adyenSessionRepository.postPayments(paymentComponentJson);
    final additionalDetails =
        await _adyenCheckout.onPaymentsResult(paymentsResponse);
    Map<String, dynamic> paymentsDetailsResponse =
        await _adyenSessionRepository.postPaymentsDetails(additionalDetails);
    var finalResult = await _adyenCheckout.onPaymentsDetailsResult(paymentsDetailsResponse);

    print("YAY");
  }

  _dialogBuilder(
      BuildContext context, SessionDropInResultModel sessionDropInResultModel) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(sessionDropInResultModel.sessionDropInResult.name),
          content: Text(
              "Result code: ${sessionDropInResultModel.result?.resultCode}"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
