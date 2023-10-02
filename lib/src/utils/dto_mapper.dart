import 'package:adyen_checkout/adyen_checkout.dart';
import 'package:adyen_checkout/src/generated/platform_api.g.dart';
import 'package:adyen_checkout/src/models/analytics_options.dart';

extension AnalyticsOptionsMapper on AnalyticsOptions {
  AnalyticsOptionsDTO toDTO() => AnalyticsOptionsDTO(
        enabled: enabled,
        payload: payload,
      );
}

extension CardsConfigurationMapper on CardsConfiguration {
  CardsConfigurationDTO toDTO() => CardsConfigurationDTO(
        holderNameRequired: holderNameRequired,
        addressMode: addressMode,
        showStorePaymentField: showStorePaymentField,
        showCvcForStoredCard: showCvcForStoredCard,
        showCvc: showCvc,
        kcpFieldVisibility: kcpFieldVisibility,
        socialSecurityNumberFieldVisibility:
            socialSecurityNumberFieldVisibility,
        supportedCardTypes: supportedCardTypes,
      );
}

extension GooglePayConfigurationMapper on GooglePayConfiguration {
  GooglePayConfigurationDTO toDTO() => GooglePayConfigurationDTO(
        merchantAccount: merchantAccount,
        allowedCardNetworks: allowedCardNetworks,
        allowedAuthMethods: allowedAuthMethods
            .map((allowedAuthMethod) => allowedAuthMethod.name)
            .toList(),
        totalPriceStatus: totalPriceStatus,
        allowPrepaidCards: allowPrepaidCards,
        billingAddressRequired: billingAddressRequired,
        emailRequired: emailRequired,
        shippingAddressRequired: shippingAddressRequired,
        existingPaymentMethodRequired: existingPaymentMethodRequired,
        googlePayEnvironment: googlePayEnvironment,
      );
}

extension ApplePayConfigurationMapper on ApplePayConfiguration {
  ApplePayConfigurationDTO toDTO() => ApplePayConfigurationDTO(
        merchantId: merchantId,
        merchantName: merchantName,
        allowOnboarding: allowOnboarding,
      );
}

extension CashAppPayConfigurationMapper on CashAppPayConfiguration {
  CashAppPayConfigurationDTO toDTO() => CashAppPayConfigurationDTO(
        cashAppPayEnvironment: cashAppPayEnvironment,
        returnUrl: returnUrl,
      );
}

extension SessionMapper on Session {
  SessionDTO toDTO() => SessionDTO(
        id: id,
        sessionData: sessionData,
      );
}

extension AmountMapper on Amount {
  AmountDTO toDTO() => AmountDTO(
        value: value,
        currency: currency,
      );
}

extension PaymentResultMapper on PaymentResultDTO {
  PaymentResult fromDTO() => PaymentResult(
        type,
        reason,
        result?.fromDTO(),
      );
}

extension PaymentResulModelMapper on PaymentResultModelDTO {
  PaymentResultModel fromDTO() => PaymentResultModel(
        sessionId,
        sessionData,
        resultCode,
        order?.fromDTO(),
      );
}

extension OrderResponseMapper on OrderResponseDTO {
  OrderResponse fromDTO() => OrderResponse(
        pspReference: pspReference,
        orderData: orderData,
      );
}

extension CardsConfigurationDTOCopy on CardsConfigurationDTO {
  CardsConfigurationDTO copyWith({
    bool? holderNameRequired,
    AddressMode? addressMode,
    bool? showStorePaymentField,
    bool? showCvcForStoredCard,
    bool? showCvc,
    FieldVisibility? kcpFieldVisibility,
    FieldVisibility? socialSecurityNumberFieldVisibility,
    List<String?>? supportedCardTypes,
  }) =>
      CardsConfigurationDTO(
        holderNameRequired: holderNameRequired ?? this.holderNameRequired,
        addressMode: addressMode ?? this.addressMode,
        showStorePaymentField:
            showStorePaymentField ?? this.showStorePaymentField,
        showCvcForStoredCard: showCvcForStoredCard ?? this.showCvcForStoredCard,
        showCvc: showCvc ?? this.showCvc,
        kcpFieldVisibility: kcpFieldVisibility ?? this.kcpFieldVisibility,
        socialSecurityNumberFieldVisibility:
            socialSecurityNumberFieldVisibility ??
                this.socialSecurityNumberFieldVisibility,
        supportedCardTypes: supportedCardTypes ?? this.supportedCardTypes,
      );
}