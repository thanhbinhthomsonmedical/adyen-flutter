import 'package:pigeon/pigeon.dart';

//dart run pigeon --input pigeons/platform_api.dart
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/generated/platform_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/com/adyen/adyen_checkout/PlatformApi.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Classes/PlatformApi.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'adyen_checkout',
))
enum Environment {
  test,
  europe,
  unitedStates,
  australia,
  india,
  apse;
}

enum AddressMode {
  full,
  postalCode,
  none,
}

enum CardAuthMethod {
  panOnly,
  cryptogram3DS,
}

enum TotalPriceStatus {
  notCurrentlyKnown,
  estimated,
  finalPrice,
}

enum GooglePayEnvironment {
  test,
  production,
}

enum CashAppPayEnvironment {
  sandbox,
  production,
}

enum PaymentResultEnum {
  cancelledByUser,
  error,
  finished,
}

enum PlatformCommunicationType {
  paymentComponent,
  additionalDetails,
  result,
  deleteStoredPaymentMethod,
}

enum ComponentCommunicationType {
  onSubmit,
  additionalDetails,
  result,
  error,
  resize,
}

enum PaymentResultType {
  finished,
  action,
  error,
}

enum FieldVisibility {
  show,
  hide,
}

class SessionDTO {
  final String id;
  final String sessionData;
  final String paymentMethodsJson;

  SessionDTO(
    this.id,
    this.sessionData,
    this.paymentMethodsJson,
  );
}

class AmountDTO {
  final String currency;
  final int value;

  AmountDTO(
    this.currency,
    this.value,
  );
}

class AnalyticsOptionsDTO {
  final bool enabled;
  final String version;

  AnalyticsOptionsDTO(
    this.enabled,
    this.version,
  );
}

class DropInConfigurationDTO {
  final Environment environment;
  final String clientKey;
  final String countryCode;
  final AmountDTO amount;
  final String shopperLocale;
  final CardConfigurationDTO? cardConfigurationDTO;
  final ApplePayConfigurationDTO? applePayConfigurationDTO;
  final GooglePayConfigurationDTO? googlePayConfigurationDTO;
  final CashAppPayConfigurationDTO? cashAppPayConfigurationDTO;
  final AnalyticsOptionsDTO analyticsOptionsDTO;
  final bool showPreselectedStoredPaymentMethod;
  final bool skipListWhenSinglePaymentMethod;
  final bool isRemoveStoredPaymentMethodEnabled;

  DropInConfigurationDTO(
    this.environment,
    this.clientKey,
    this.countryCode,
    this.amount,
    this.shopperLocale,
    this.cardConfigurationDTO,
    this.applePayConfigurationDTO,
    this.googlePayConfigurationDTO,
    this.cashAppPayConfigurationDTO,
    this.analyticsOptionsDTO,
    this.showPreselectedStoredPaymentMethod,
    this.skipListWhenSinglePaymentMethod,
    this.isRemoveStoredPaymentMethodEnabled,
  );
}

class CardConfigurationDTO {
  final bool holderNameRequired;
  final AddressMode addressMode;
  final bool showStorePaymentField;
  final bool showCvcForStoredCard;
  final bool showCvc;
  final FieldVisibility kcpFieldVisibility;
  final FieldVisibility socialSecurityNumberFieldVisibility;
  final List<String?> supportedCardTypes;

  CardConfigurationDTO(
    this.holderNameRequired,
    this.addressMode,
    this.showStorePaymentField,
    this.showCvcForStoredCard,
    this.showCvc,
    this.kcpFieldVisibility,
    this.socialSecurityNumberFieldVisibility,
    this.supportedCardTypes,
  );
}

class ApplePayConfigurationDTO {
  final String merchantId;
  final String merchantName;
  final bool allowOnboarding;

  ApplePayConfigurationDTO(
    this.merchantId,
    this.merchantName,
    this.allowOnboarding,
  );
}

class GooglePayConfigurationDTO {
  final GooglePayEnvironment googlePayEnvironment;
  final String? merchantAccount;
  final List<String?> allowedCardNetworks;
  final List<String?> allowedAuthMethods;
  final TotalPriceStatus? totalPriceStatus;
  final bool allowPrepaidCards;
  final bool billingAddressRequired;
  final bool emailRequired;
  final bool shippingAddressRequired;
  final bool existingPaymentMethodRequired;

  GooglePayConfigurationDTO(
    this.googlePayEnvironment,
    this.merchantAccount,
    this.totalPriceStatus,
    this.allowedCardNetworks,
    this.allowedAuthMethods,
    this.allowPrepaidCards,
    this.billingAddressRequired,
    this.emailRequired,
    this.shippingAddressRequired,
    this.existingPaymentMethodRequired,
  );
}

class CashAppPayConfigurationDTO {
  final CashAppPayEnvironment cashAppPayEnvironment;
  final String returnUrl;

  CashAppPayConfigurationDTO(
    this.cashAppPayEnvironment,
    this.returnUrl,
  );
}

class PaymentResultDTO {
  final PaymentResultEnum type;
  final String? reason;
  final PaymentResultModelDTO? result;

  PaymentResultDTO(
    this.type,
    this.reason,
    this.result,
  );
}

class PaymentResultModelDTO {
  final String? sessionId;
  final String? sessionData;
  final String? sessionResult;
  final String? resultCode;
  final OrderResponseDTO? order;

  PaymentResultModelDTO(
    this.sessionId,
    this.sessionData,
    this.sessionResult,
    this.resultCode,
    this.order,
  );
}

class OrderResponseDTO {
  final String pspReference;
  final String orderData;
  final AmountDTO? amount;
  final AmountDTO? remainingAmount;

  OrderResponseDTO({
    required this.pspReference,
    required this.orderData,
    this.amount,
    this.remainingAmount,
  });
}

class PlatformCommunicationModel {
  final PlatformCommunicationType type;
  final String? data;
  final PaymentResultDTO? paymentResult;

  PlatformCommunicationModel({
    required this.type,
    this.data,
    this.paymentResult,
  });
}

class ComponentCommunicationModel {
  final ComponentCommunicationType type;
  final Object? data;
  final PaymentResultModelDTO? paymentResult;

  ComponentCommunicationModel({
    required this.type,
    this.data,
    this.paymentResult,
  });
}

//Use PaymentOutcome class when sealed classes are supported by pigeon
class PaymentOutcomeDTO {
  final PaymentResultType paymentResultType;
  final String? result;
  final Map<String?, Object?>? actionResponse;
  final ErrorDTO? error;

  PaymentOutcomeDTO({
    required this.paymentResultType,
    this.result,
    this.actionResponse,
    this.error,
  });
}

class ErrorDTO {
  final String? errorMessage;
  final String? reason;
  final bool? dismissDropIn;

  ErrorDTO({
    this.errorMessage,
    this.reason,
    this.dismissDropIn = false,
  });
}

class DeletedStoredPaymentMethodResultDTO {
  final String storedPaymentMethodId;
  final bool isSuccessfullyRemoved;

  DeletedStoredPaymentMethodResultDTO(
    this.storedPaymentMethodId,
    this.isSuccessfullyRemoved,
  );
}

class CardComponentConfigurationDTO {
  final Environment environment;
  final String clientKey;
  final String countryCode;
  final AmountDTO amount;
  final String? shopperLocale;
  final CardConfigurationDTO cardConfiguration;
  final AnalyticsOptionsDTO analyticsOptionsDTO;

  CardComponentConfigurationDTO(
    this.environment,
    this.clientKey,
    this.countryCode,
    this.amount,
    this.shopperLocale,
    this.cardConfiguration,
    this.analyticsOptionsDTO,
  );
}

@HostApi()
abstract class CheckoutPlatformInterface {
  @async
  String getReturnUrl();

  @async
  SessionDTO createSession(
    String sessionId,
    String sessionData,
    Object? configuration,
  );

  void enableConsoleLogging(bool loggingEnabled);
}

@HostApi()
abstract class DropInPlatformInterface {
  // TODO: Merge show dropIn methods into one.
  void showDropInSession(DropInConfigurationDTO dropInConfigurationDTO);

  void showDropInAdvanced(
    DropInConfigurationDTO dropInConfigurationDTO,
    String paymentMethodsResponse,
  );

  void onPaymentsResult(PaymentOutcomeDTO paymentsResult);

  void onPaymentsDetailsResult(PaymentOutcomeDTO paymentsDetailsResult);

  void onDeleteStoredPaymentMethodResult(
      DeletedStoredPaymentMethodResultDTO deleteStoredPaymentMethodResultDTO);

  void cleanUpDropIn();
}

@FlutterApi()
abstract class DropInFlutterInterface {
  void onDropInSessionPlatformCommunication(
      PlatformCommunicationModel platformCommunicationModel);

  void onDropInAdvancedPlatformCommunication(
      PlatformCommunicationModel platformCommunicationModel);
}

@HostApi()
abstract class ComponentPlatformInterface {
  void updateViewHeight(int viewId);

  void onPaymentsResult(PaymentOutcomeDTO paymentsResult);

  void onPaymentsDetailsResult(PaymentOutcomeDTO paymentsDetailsResult);
}

@FlutterApi()
abstract class ComponentFlutterInterface {
  // ignore: unused_element
  void _generateCodecForDTOs(
    CardComponentConfigurationDTO cardComponentConfigurationDTO,
    SessionDTO sessionDTO,
  );

  void onComponentCommunication(
      ComponentCommunicationModel componentCommunicationModel);
}
