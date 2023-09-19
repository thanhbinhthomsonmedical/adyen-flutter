// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

enum Environment: Int {
  case test = 0
  case europe = 1
  case unitedStates = 2
  case australia = 3
  case india = 4
  case apse = 5
}

enum AddressMode: Int {
  case full = 0
  case postalCode = 1
  case none = 2
}

enum CardAuthMethod: Int {
  case panOnly = 0
  case cryptogram3DS = 1
}

enum TotalPriceStatus: Int {
  case notCurrentlyKnown = 0
  case estimated = 1
  case finalPrice = 2
}

enum GooglePayEnvironment: Int {
  case test = 0
  case production = 1
}

enum PaymentResultEnum: Int {
  case cancelledByUser = 0
  case error = 1
  case finished = 2
}

enum PlatformCommunicationType: Int {
  case paymentComponent = 0
  case additionalDetails = 1
  case result = 2
}

enum DropInResultType: Int {
  case finished = 0
  case action = 1
  case error = 2
}

enum CashAppPayEnvironment: Int {
  case sandbox = 0
  case production = 1
}

/// Generated class from Pigeon that represents data sent in messages.
struct Session {
  var id: String
  var sessionData: String

  static func fromList(_ list: [Any?]) -> Session? {
    let id = list[0] as! String
    let sessionData = list[1] as! String

    return Session(
      id: id,
      sessionData: sessionData
    )
  }
  func toList() -> [Any?] {
    return [
      id,
      sessionData,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct Amount {
  var currency: String? = nil
  var value: Int64

  static func fromList(_ list: [Any?]) -> Amount? {
    let currency: String? = nilOrValue(list[0])
    let value = list[1] is Int64 ? list[1] as! Int64 : Int64(list[1] as! Int32)

    return Amount(
      currency: currency,
      value: value
    )
  }
  func toList() -> [Any?] {
    return [
      currency,
      value,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct AnalyticsOptionsDTO {
  var enabled: Bool? = nil
  var payload: String? = nil

  static func fromList(_ list: [Any?]) -> AnalyticsOptionsDTO? {
    let enabled: Bool? = nilOrValue(list[0])
    let payload: String? = nilOrValue(list[1])

    return AnalyticsOptionsDTO(
      enabled: enabled,
      payload: payload
    )
  }
  func toList() -> [Any?] {
    return [
      enabled,
      payload,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct DropInConfigurationDTO {
  var environment: Environment
  var clientKey: String
  var countryCode: String
  var amount: Amount
  var shopperLocale: String
  var analyticsOptionsDTO: AnalyticsOptionsDTO? = nil
  var showPreselectedStoredPaymentMethod: Bool? = nil
  var skipListWhenSinglePaymentMethod: Bool? = nil
  var cardsConfigurationDTO: CardsConfigurationDTO? = nil
  var applePayConfigurationDTO: ApplePayConfigurationDTO? = nil
  var googlePayConfigurationDTO: GooglePayConfigurationDTO? = nil
  var cashAppPayConfigurationDTO: CashAppPayConfigurationDTO? = nil

  static func fromList(_ list: [Any?]) -> DropInConfigurationDTO? {
    let environment = Environment(rawValue: list[0] as! Int)!
    let clientKey = list[1] as! String
    let countryCode = list[2] as! String
    let amount = Amount.fromList(list[3] as! [Any?])!
    let shopperLocale = list[4] as! String
    var analyticsOptionsDTO: AnalyticsOptionsDTO? = nil
    if let analyticsOptionsDTOList: [Any?] = nilOrValue(list[5]) {
      analyticsOptionsDTO = AnalyticsOptionsDTO.fromList(analyticsOptionsDTOList)
    }
    let showPreselectedStoredPaymentMethod: Bool? = nilOrValue(list[6])
    let skipListWhenSinglePaymentMethod: Bool? = nilOrValue(list[7])
    var cardsConfigurationDTO: CardsConfigurationDTO? = nil
    if let cardsConfigurationDTOList: [Any?] = nilOrValue(list[8]) {
      cardsConfigurationDTO = CardsConfigurationDTO.fromList(cardsConfigurationDTOList)
    }
    var applePayConfigurationDTO: ApplePayConfigurationDTO? = nil
    if let applePayConfigurationDTOList: [Any?] = nilOrValue(list[9]) {
      applePayConfigurationDTO = ApplePayConfigurationDTO.fromList(applePayConfigurationDTOList)
    }
    var googlePayConfigurationDTO: GooglePayConfigurationDTO? = nil
    if let googlePayConfigurationDTOList: [Any?] = nilOrValue(list[10]) {
      googlePayConfigurationDTO = GooglePayConfigurationDTO.fromList(googlePayConfigurationDTOList)
    }
    var cashAppPayConfigurationDTO: CashAppPayConfigurationDTO? = nil
    if let cashAppPayConfigurationDTOList: [Any?] = nilOrValue(list[11]) {
      cashAppPayConfigurationDTO = CashAppPayConfigurationDTO.fromList(cashAppPayConfigurationDTOList)
    }

    return DropInConfigurationDTO(
      environment: environment,
      clientKey: clientKey,
      countryCode: countryCode,
      amount: amount,
      shopperLocale: shopperLocale,
      analyticsOptionsDTO: analyticsOptionsDTO,
      showPreselectedStoredPaymentMethod: showPreselectedStoredPaymentMethod,
      skipListWhenSinglePaymentMethod: skipListWhenSinglePaymentMethod,
      cardsConfigurationDTO: cardsConfigurationDTO,
      applePayConfigurationDTO: applePayConfigurationDTO,
      googlePayConfigurationDTO: googlePayConfigurationDTO,
      cashAppPayConfigurationDTO: cashAppPayConfigurationDTO
    )
  }
  func toList() -> [Any?] {
    return [
      environment.rawValue,
      clientKey,
      countryCode,
      amount.toList(),
      shopperLocale,
      analyticsOptionsDTO?.toList(),
      showPreselectedStoredPaymentMethod,
      skipListWhenSinglePaymentMethod,
      cardsConfigurationDTO?.toList(),
      applePayConfigurationDTO?.toList(),
      googlePayConfigurationDTO?.toList(),
      cashAppPayConfigurationDTO?.toList(),
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct CardsConfigurationDTO {
  var holderNameRequired: Bool
  var addressMode: AddressMode
  var showStorePaymentField: Bool
  var showCvcForStoredCard: Bool
  var showCvc: Bool
  var showKcpField: Bool
  var showSocialSecurityNumberField: Bool
  var supportedCardTypes: [String?]

  static func fromList(_ list: [Any?]) -> CardsConfigurationDTO? {
    let holderNameRequired = list[0] as! Bool
    let addressMode = AddressMode(rawValue: list[1] as! Int)!
    let showStorePaymentField = list[2] as! Bool
    let showCvcForStoredCard = list[3] as! Bool
    let showCvc = list[4] as! Bool
    let showKcpField = list[5] as! Bool
    let showSocialSecurityNumberField = list[6] as! Bool
    let supportedCardTypes = list[7] as! [String?]

    return CardsConfigurationDTO(
      holderNameRequired: holderNameRequired,
      addressMode: addressMode,
      showStorePaymentField: showStorePaymentField,
      showCvcForStoredCard: showCvcForStoredCard,
      showCvc: showCvc,
      showKcpField: showKcpField,
      showSocialSecurityNumberField: showSocialSecurityNumberField,
      supportedCardTypes: supportedCardTypes
    )
  }
  func toList() -> [Any?] {
    return [
      holderNameRequired,
      addressMode.rawValue,
      showStorePaymentField,
      showCvcForStoredCard,
      showCvc,
      showKcpField,
      showSocialSecurityNumberField,
      supportedCardTypes,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct ApplePayConfigurationDTO {
  var merchantId: String
  var merchantName: String
  var allowOnboarding: Bool

  static func fromList(_ list: [Any?]) -> ApplePayConfigurationDTO? {
    let merchantId = list[0] as! String
    let merchantName = list[1] as! String
    let allowOnboarding = list[2] as! Bool

    return ApplePayConfigurationDTO(
      merchantId: merchantId,
      merchantName: merchantName,
      allowOnboarding: allowOnboarding
    )
  }
  func toList() -> [Any?] {
    return [
      merchantId,
      merchantName,
      allowOnboarding,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct GooglePayConfigurationDTO {
  var merchantAccount: String
  var allowedCardNetworks: [String?]
  var allowedAuthMethods: [String?]
  var totalPriceStatus: TotalPriceStatus
  var allowPrepaidCards: Bool
  var billingAddressRequired: Bool
  var emailRequired: Bool
  var shippingAddressRequired: Bool
  var existingPaymentMethodRequired: Bool
  var googlePayEnvironment: GooglePayEnvironment

  static func fromList(_ list: [Any?]) -> GooglePayConfigurationDTO? {
    let merchantAccount = list[0] as! String
    let allowedCardNetworks = list[1] as! [String?]
    let allowedAuthMethods = list[2] as! [String?]
    let totalPriceStatus = TotalPriceStatus(rawValue: list[3] as! Int)!
    let allowPrepaidCards = list[4] as! Bool
    let billingAddressRequired = list[5] as! Bool
    let emailRequired = list[6] as! Bool
    let shippingAddressRequired = list[7] as! Bool
    let existingPaymentMethodRequired = list[8] as! Bool
    let googlePayEnvironment = GooglePayEnvironment(rawValue: list[9] as! Int)!

    return GooglePayConfigurationDTO(
      merchantAccount: merchantAccount,
      allowedCardNetworks: allowedCardNetworks,
      allowedAuthMethods: allowedAuthMethods,
      totalPriceStatus: totalPriceStatus,
      allowPrepaidCards: allowPrepaidCards,
      billingAddressRequired: billingAddressRequired,
      emailRequired: emailRequired,
      shippingAddressRequired: shippingAddressRequired,
      existingPaymentMethodRequired: existingPaymentMethodRequired,
      googlePayEnvironment: googlePayEnvironment
    )
  }
  func toList() -> [Any?] {
    return [
      merchantAccount,
      allowedCardNetworks,
      allowedAuthMethods,
      totalPriceStatus.rawValue,
      allowPrepaidCards,
      billingAddressRequired,
      emailRequired,
      shippingAddressRequired,
      existingPaymentMethodRequired,
      googlePayEnvironment.rawValue,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct CashAppPayConfigurationDTO {
  var cashAppPayEnvironment: CashAppPayEnvironment

  static func fromList(_ list: [Any?]) -> CashAppPayConfigurationDTO? {
    let cashAppPayEnvironment = CashAppPayEnvironment(rawValue: list[0] as! Int)!

    return CashAppPayConfigurationDTO(
      cashAppPayEnvironment: cashAppPayEnvironment
    )
  }
  func toList() -> [Any?] {
    return [
      cashAppPayEnvironment.rawValue,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct PaymentResult {
  var type: PaymentResultEnum
  var reason: String? = nil
  var result: PaymentResultModel? = nil

  static func fromList(_ list: [Any?]) -> PaymentResult? {
    let type = PaymentResultEnum(rawValue: list[0] as! Int)!
    let reason: String? = nilOrValue(list[1])
    var result: PaymentResultModel? = nil
    if let resultList: [Any?] = nilOrValue(list[2]) {
      result = PaymentResultModel.fromList(resultList)
    }

    return PaymentResult(
      type: type,
      reason: reason,
      result: result
    )
  }
  func toList() -> [Any?] {
    return [
      type.rawValue,
      reason,
      result?.toList(),
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct PaymentResultModel {
  var sessionId: String? = nil
  var sessionData: String? = nil
  var resultCode: String? = nil
  var order: OrderResponseModel? = nil

  static func fromList(_ list: [Any?]) -> PaymentResultModel? {
    let sessionId: String? = nilOrValue(list[0])
    let sessionData: String? = nilOrValue(list[1])
    let resultCode: String? = nilOrValue(list[2])
    var order: OrderResponseModel? = nil
    if let orderList: [Any?] = nilOrValue(list[3]) {
      order = OrderResponseModel.fromList(orderList)
    }

    return PaymentResultModel(
      sessionId: sessionId,
      sessionData: sessionData,
      resultCode: resultCode,
      order: order
    )
  }
  func toList() -> [Any?] {
    return [
      sessionId,
      sessionData,
      resultCode,
      order?.toList(),
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct OrderResponseModel {
  var pspReference: String
  var orderData: String
  var amount: Amount? = nil
  var remainingAmount: Amount? = nil

  static func fromList(_ list: [Any?]) -> OrderResponseModel? {
    let pspReference = list[0] as! String
    let orderData = list[1] as! String
    var amount: Amount? = nil
    if let amountList: [Any?] = nilOrValue(list[2]) {
      amount = Amount.fromList(amountList)
    }
    var remainingAmount: Amount? = nil
    if let remainingAmountList: [Any?] = nilOrValue(list[3]) {
      remainingAmount = Amount.fromList(remainingAmountList)
    }

    return OrderResponseModel(
      pspReference: pspReference,
      orderData: orderData,
      amount: amount,
      remainingAmount: remainingAmount
    )
  }
  func toList() -> [Any?] {
    return [
      pspReference,
      orderData,
      amount?.toList(),
      remainingAmount?.toList(),
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct PlatformCommunicationModel {
  var type: PlatformCommunicationType
  var data: String? = nil
  var paymentResult: PaymentResult? = nil

  static func fromList(_ list: [Any?]) -> PlatformCommunicationModel? {
    let type = PlatformCommunicationType(rawValue: list[0] as! Int)!
    let data: String? = nilOrValue(list[1])
    var paymentResult: PaymentResult? = nil
    if let paymentResultList: [Any?] = nilOrValue(list[2]) {
      paymentResult = PaymentResult.fromList(paymentResultList)
    }

    return PlatformCommunicationModel(
      type: type,
      data: data,
      paymentResult: paymentResult
    )
  }
  func toList() -> [Any?] {
    return [
      type.rawValue,
      data,
      paymentResult?.toList(),
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct DropInResult {
  var dropInResultType: DropInResultType
  var result: String? = nil
  var actionResponse: [String?: Any?]? = nil
  var error: DropInError? = nil

  static func fromList(_ list: [Any?]) -> DropInResult? {
    let dropInResultType = DropInResultType(rawValue: list[0] as! Int)!
    let result: String? = nilOrValue(list[1])
    let actionResponse: [String?: Any?]? = nilOrValue(list[2])
    var error: DropInError? = nil
    if let errorList: [Any?] = nilOrValue(list[3]) {
      error = DropInError.fromList(errorList)
    }

    return DropInResult(
      dropInResultType: dropInResultType,
      result: result,
      actionResponse: actionResponse,
      error: error
    )
  }
  func toList() -> [Any?] {
    return [
      dropInResultType.rawValue,
      result,
      actionResponse,
      error?.toList(),
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct DropInError {
  var errorMessage: String? = nil
  var reason: String? = nil
  var dismissDropIn: Bool? = nil

  static func fromList(_ list: [Any?]) -> DropInError? {
    let errorMessage: String? = nilOrValue(list[0])
    let reason: String? = nilOrValue(list[1])
    let dismissDropIn: Bool? = nilOrValue(list[2])

    return DropInError(
      errorMessage: errorMessage,
      reason: reason,
      dismissDropIn: dismissDropIn
    )
  }
  func toList() -> [Any?] {
    return [
      errorMessage,
      reason,
      dismissDropIn,
    ]
  }
}

private class CheckoutPlatformInterfaceCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return Amount.fromList(self.readValue() as! [Any?])
      case 129:
        return AnalyticsOptionsDTO.fromList(self.readValue() as! [Any?])
      case 130:
        return ApplePayConfigurationDTO.fromList(self.readValue() as! [Any?])
      case 131:
        return CardsConfigurationDTO.fromList(self.readValue() as! [Any?])
      case 132:
        return CashAppPayConfigurationDTO.fromList(self.readValue() as! [Any?])
      case 133:
        return DropInConfigurationDTO.fromList(self.readValue() as! [Any?])
      case 134:
        return DropInError.fromList(self.readValue() as! [Any?])
      case 135:
        return DropInResult.fromList(self.readValue() as! [Any?])
      case 136:
        return GooglePayConfigurationDTO.fromList(self.readValue() as! [Any?])
      case 137:
        return Session.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class CheckoutPlatformInterfaceCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? Amount {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? AnalyticsOptionsDTO {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? ApplePayConfigurationDTO {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? CardsConfigurationDTO {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? CashAppPayConfigurationDTO {
      super.writeByte(132)
      super.writeValue(value.toList())
    } else if let value = value as? DropInConfigurationDTO {
      super.writeByte(133)
      super.writeValue(value.toList())
    } else if let value = value as? DropInError {
      super.writeByte(134)
      super.writeValue(value.toList())
    } else if let value = value as? DropInResult {
      super.writeByte(135)
      super.writeValue(value.toList())
    } else if let value = value as? GooglePayConfigurationDTO {
      super.writeByte(136)
      super.writeValue(value.toList())
    } else if let value = value as? Session {
      super.writeByte(137)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class CheckoutPlatformInterfaceCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return CheckoutPlatformInterfaceCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return CheckoutPlatformInterfaceCodecWriter(data: data)
  }
}

class CheckoutPlatformInterfaceCodec: FlutterStandardMessageCodec {
  static let shared = CheckoutPlatformInterfaceCodec(readerWriter: CheckoutPlatformInterfaceCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol CheckoutPlatformInterface {
  func getPlatformVersion(completion: @escaping (Result<String, Error>) -> Void)
  func getReturnUrl(completion: @escaping (Result<String, Error>) -> Void)
  func startDropInSessionPayment(dropInConfigurationDTO: DropInConfigurationDTO, session: Session) throws
  func startDropInAdvancedFlowPayment(dropInConfigurationDTO: DropInConfigurationDTO, paymentMethodsResponse: String) throws
  func onPaymentsResult(paymentsResult: DropInResult) throws
  func onPaymentsDetailsResult(paymentsDetailsResult: DropInResult) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class CheckoutPlatformInterfaceSetup {
  /// The codec used by CheckoutPlatformInterface.
  static var codec: FlutterStandardMessageCodec { CheckoutPlatformInterfaceCodec.shared }
  /// Sets up an instance of `CheckoutPlatformInterface` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: CheckoutPlatformInterface?) {
    let getPlatformVersionChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.getPlatformVersion", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getPlatformVersionChannel.setMessageHandler { _, reply in
        api.getPlatformVersion() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      getPlatformVersionChannel.setMessageHandler(nil)
    }
    let getReturnUrlChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.getReturnUrl", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getReturnUrlChannel.setMessageHandler { _, reply in
        api.getReturnUrl() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      getReturnUrlChannel.setMessageHandler(nil)
    }
    let startDropInSessionPaymentChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startDropInSessionPayment", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      startDropInSessionPaymentChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let dropInConfigurationDTOArg = args[0] as! DropInConfigurationDTO
        let sessionArg = args[1] as! Session
        do {
          try api.startDropInSessionPayment(dropInConfigurationDTO: dropInConfigurationDTOArg, session: sessionArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      startDropInSessionPaymentChannel.setMessageHandler(nil)
    }
    let startDropInAdvancedFlowPaymentChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startDropInAdvancedFlowPayment", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      startDropInAdvancedFlowPaymentChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let dropInConfigurationDTOArg = args[0] as! DropInConfigurationDTO
        let paymentMethodsResponseArg = args[1] as! String
        do {
          try api.startDropInAdvancedFlowPayment(dropInConfigurationDTO: dropInConfigurationDTOArg, paymentMethodsResponse: paymentMethodsResponseArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      startDropInAdvancedFlowPaymentChannel.setMessageHandler(nil)
    }
    let onPaymentsResultChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.onPaymentsResult", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      onPaymentsResultChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let paymentsResultArg = args[0] as! DropInResult
        do {
          try api.onPaymentsResult(paymentsResult: paymentsResultArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      onPaymentsResultChannel.setMessageHandler(nil)
    }
    let onPaymentsDetailsResultChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.onPaymentsDetailsResult", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      onPaymentsDetailsResultChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let paymentsDetailsResultArg = args[0] as! DropInResult
        do {
          try api.onPaymentsDetailsResult(paymentsDetailsResult: paymentsDetailsResultArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      onPaymentsDetailsResultChannel.setMessageHandler(nil)
    }
  }
}
private class CheckoutFlutterApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return Amount.fromList(self.readValue() as! [Any?])
      case 129:
        return OrderResponseModel.fromList(self.readValue() as! [Any?])
      case 130:
        return PaymentResult.fromList(self.readValue() as! [Any?])
      case 131:
        return PaymentResultModel.fromList(self.readValue() as! [Any?])
      case 132:
        return PlatformCommunicationModel.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class CheckoutFlutterApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? Amount {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? OrderResponseModel {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? PaymentResult {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? PaymentResultModel {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? PlatformCommunicationModel {
      super.writeByte(132)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class CheckoutFlutterApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return CheckoutFlutterApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return CheckoutFlutterApiCodecWriter(data: data)
  }
}

class CheckoutFlutterApiCodec: FlutterStandardMessageCodec {
  static let shared = CheckoutFlutterApiCodec(readerWriter: CheckoutFlutterApiCodecReaderWriter())
}

/// Generated class from Pigeon that represents Flutter messages that can be called from Swift.
class CheckoutFlutterApi {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger){
    self.binaryMessenger = binaryMessenger
  }
  var codec: FlutterStandardMessageCodec {
    return CheckoutFlutterApiCodec.shared
  }
  func onDropInSessionResult(sessionPaymentResult sessionPaymentResultArg: PaymentResult, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInSessionResult", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([sessionPaymentResultArg] as [Any?]) { _ in
      completion()
    }
  }
  func onDropInAdvancedFlowPlatformCommunication(platformCommunicationModel platformCommunicationModelArg: PlatformCommunicationModel, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInAdvancedFlowPlatformCommunication", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([platformCommunicationModelArg] as [Any?]) { _ in
      completion()
    }
  }
}
