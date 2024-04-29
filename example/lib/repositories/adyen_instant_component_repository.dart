import 'package:adyen_checkout/adyen_checkout.dart';
import 'package:adyen_checkout_example/config.dart';
import 'package:adyen_checkout_example/network/models/amount_network_model.dart';
import 'package:adyen_checkout_example/network/models/line_item.dart';
import 'package:adyen_checkout_example/network/models/payment_methods_request_network_model.dart';
import 'package:adyen_checkout_example/network/models/payment_request_network_model.dart';
import 'package:adyen_checkout_example/network/models/session_request_network_model.dart';
import 'package:adyen_checkout_example/network/models/session_response_network_model.dart';
import 'package:adyen_checkout_example/repositories/adyen_base_repository.dart';

class AdyenInstantComponentRepository extends AdyenBaseRepository {
  AdyenInstantComponentRepository({
    required super.service,
  });

  Future<SessionCheckout> createSessionCheckout(
      InstantComponentConfiguration instantComponentConfiguration) async {
    final sessionResponse = await fetchSession();
    return await AdyenCheckout.session.create(
      sessionId: sessionResponse.id,
      sessionData: sessionResponse.sessionData,
      configuration: instantComponentConfiguration,
    );
  }

  Future<SessionResponseNetworkModel> fetchSession() async {
    String returnUrl = await determineBaseReturnUrl();
    returnUrl += "/adyenPayment";
    SessionRequestNetworkModel sessionRequestNetworkModel =
        SessionRequestNetworkModel(
      merchantAccount: Config.merchantAccount,
      amount: AmountNetworkModel(
        currency: Config.amount.currency,
        value: Config.amount.value,
      ),
      returnUrl: returnUrl,
      reference:
          "flutter-session-test_${DateTime.now().millisecondsSinceEpoch}",
      countryCode: Config.countryCode,
      shopperLocale: Config.shopperLocale,
      shopperReference: Config.shopperReference,
      channel: determineChannel(),
      authenticationData: {
        "attemptAuthentication": "always",
        "threeDSRequestData": {
          "nativeThreeDS": "preferred",
        },
      },
      lineItems: [
        LineItem(
          quantity: 1,
          amountExcludingTax: 331,
          taxPercentage: 2100,
          description: "Shoes",
          id: "Item #1",
          taxAmount: 69,
          amountIncludingTax: 400,
          productUrl: "URL_TO_PURCHASED_ITEM",
          imageUrl: "URL_TO_PICTURE_OF_PURCHASED_ITEM",
        ),
      ],
    );

    return await service.createSession(
      sessionRequestNetworkModel,
      Config.environment,
    );
  }

  Future<String> fetchPaymentMethods() async {
    return await service.fetchPaymentMethods(PaymentMethodsRequestNetworkModel(
      merchantAccount: Config.merchantAccount,
      countryCode: Config.countryCode,
      channel: determineChannel(),
      shopperReference: Config.shopperReference,
    ));
  }

  Future<PaymentEvent> onSubmit(
    Map<String, dynamic> data, [
    Map<String, dynamic>? extra,
  ]) async {
    String returnUrl = await determineBaseReturnUrl();
    returnUrl += "/adyenPayment";
    PaymentsRequestData paymentsRequestData = PaymentsRequestData(
        merchantAccount: Config.merchantAccount,
        shopperReference: Config.shopperReference,
        reference: "flutter-test_${DateTime.now().millisecondsSinceEpoch}",
        returnUrl: returnUrl,
        amount: AmountNetworkModel(
          value: Config.amount.value,
          currency: Config.amount.currency,
        ),
        countryCode: Config.countryCode,
        channel: determineChannel(),
        recurringProcessingModel: RecurringProcessingModel.cardOnFile,
        shopperInteraction:
            ShopperInteractionModel.ecommerce.shopperInteractionModelString,
        authenticationData: {
          "attemptAuthentication": "always",
          "threeDSRequestData": {
            "nativeThreeDS": "preferred",
          },
        },
        lineItems: [
          LineItem(
            quantity: 1,
            amountExcludingTax: 331,
            taxPercentage: 2100,
            description: "Shoes",
            id: "Item #1",
            taxAmount: 69,
            amountIncludingTax: 400,
            productUrl: "URL_TO_PURCHASED_ITEM",
            imageUrl: "URL_TO_PICTURE_OF_PURCHASED_ITEM",
          ),
        ]);

    Map<String, dynamic> mergedJson = <String, dynamic>{};
    mergedJson.addAll(data);
    mergedJson.addAll(paymentsRequestData.toJson());
    final response = await service.postPayments(mergedJson);
    return paymentEventHandler.handleResponse(response);
  }

  Future<PaymentEvent> onAdditionalDetails(
      Map<String, dynamic> additionalDetails) async {
    final response = await service.postPaymentsDetails(additionalDetails);
    return paymentEventHandler.handleResponse(response);
  }
}
