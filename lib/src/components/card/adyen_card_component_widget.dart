import 'dart:convert';

import 'package:adyen_checkout/adyen_checkout.dart';
import 'package:adyen_checkout/src/components/card/card_advanced_flow_widget.dart';
import 'package:adyen_checkout/src/components/card/card_session_flow_widget.dart';
import 'package:adyen_checkout/src/utils/dto_mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class AdyenCardComponentWidget extends StatelessWidget {
  final ComponentPaymentFlow componentPaymentFlow;
  final Future<void> Function(PaymentResult) onPaymentResult;
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;
  final isStoredPaymentMethodIndicator = "id";

  const AdyenCardComponentWidget({
    super.key,
    required this.componentPaymentFlow,
    required this.onPaymentResult,
    this.gestureRecognizers,
  });

  @override
  Widget build(BuildContext context) {
    return switch (componentPaymentFlow) {
      CardComponentSessionFlow() => _buildCardSessionFlowWidget(),
      CardComponentAdvancedFlow() => _buildCardAdvancedFlowWidget()
    };
  }

  CardSessionFlowWidget _buildCardSessionFlowWidget() {
    final CardComponentSessionFlow cardComponentSessionFlow =
        componentPaymentFlow as CardComponentSessionFlow;
    final double initialHeight = _determineInitialHeight(
        cardComponentSessionFlow.cardComponentConfiguration.cardConfiguration);
    final encodedPaymentMethod =
        json.encode(cardComponentSessionFlow.paymentMethod);
    final isStoredPaymentMethod = cardComponentSessionFlow.paymentMethod
            .containsKey(isStoredPaymentMethodIndicator);

    return CardSessionFlowWidget(
      cardComponentConfiguration:
          cardComponentSessionFlow.cardComponentConfiguration.toDTO(),
      paymentMethod: encodedPaymentMethod,
      session: cardComponentSessionFlow.session.toDTO(),
      onPaymentResult: onPaymentResult,
      initialViewHeight: initialHeight,
      isStoredPaymentMethod: isStoredPaymentMethod,
    );
  }

  CardAdvancedFlowWidget _buildCardAdvancedFlowWidget() {
    final CardComponentAdvancedFlow cardComponentAdvancedFlow =
        componentPaymentFlow as CardComponentAdvancedFlow;
    final initialHeight = _determineInitialHeight(
        cardComponentAdvancedFlow.cardComponentConfiguration.cardConfiguration);
    final encodedPaymentMethod =
        json.encode(cardComponentAdvancedFlow.paymentMethod);
    final isStoredPaymentMethod = cardComponentAdvancedFlow.paymentMethod
            ?.containsKey(isStoredPaymentMethodIndicator) ??
        false;

    return CardAdvancedFlowWidget(
      cardComponentConfiguration:
          cardComponentAdvancedFlow.cardComponentConfiguration.toDTO(),
      paymentMethod: encodedPaymentMethod,
      onPayments: cardComponentAdvancedFlow.onPayments,
      onPaymentsDetails: cardComponentAdvancedFlow.onPaymentsDetails,
      onPaymentResult: onPaymentResult,
      initialViewHeight: initialHeight,
      isStoredPaymentMethod: isStoredPaymentMethod,
      gestureRecognizers: gestureRecognizers,
    );
  }

  double _determineInitialHeight(CardConfiguration cardConfiguration) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _determineInitialAndroidViewHeight(cardConfiguration);
      case TargetPlatform.iOS:
        return _determineInitialIosViewHeight(cardConfiguration);
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }

  double _determineInitialAndroidViewHeight(
      CardConfiguration cardConfiguration) {
    double androidViewHeight = 294;

    if (cardConfiguration.holderNameRequired) {
      androidViewHeight += 61;
    }

    if (cardConfiguration.showStorePaymentField) {
      androidViewHeight += 43;
    }

    if (cardConfiguration.addressMode == AddressMode.full) {
      androidViewHeight += 422;
    }

    if (cardConfiguration.addressMode == AddressMode.postalCode) {
      androidViewHeight += 61;
    }

    if (cardConfiguration.socialSecurityNumberFieldVisibility ==
        FieldVisibility.show) {
      androidViewHeight += 61;
    }

    if (cardConfiguration.kcpFieldVisibility == FieldVisibility.show) {
      androidViewHeight += 164;
    }

    return androidViewHeight;
  }

  double _determineInitialIosViewHeight(CardConfiguration cardConfiguration) {
    double iosViewHeight = 272;

    if (cardConfiguration.holderNameRequired) {
      iosViewHeight += 63;
    }

    if (cardConfiguration.showStorePaymentField) {
      iosViewHeight += 55;
    }

    if (cardConfiguration.addressMode != AddressMode.none) {
      iosViewHeight += 63;
    }

    if (cardConfiguration.socialSecurityNumberFieldVisibility ==
        FieldVisibility.show) {
      iosViewHeight += 63;
    }

    if (cardConfiguration.kcpFieldVisibility == FieldVisibility.show) {
      iosViewHeight += 63;
    }

    return iosViewHeight;
  }
}
