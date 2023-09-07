// Autogenerated from Pigeon (v11.0.0), do not edit directly.
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
struct DropInConfiguration {
  var environment: Environment
  var clientKey: String
  var amount: Amount
  var countryCode: String
  var isAnalyticsEnabled: Bool? = nil
  var showPreselectedStoredPaymentMethod: Bool? = nil
  var skipListWhenSinglePaymentMethod: Bool? = nil
  var isRemovingStoredPaymentMethodsEnabled: Bool? = nil
  var additionalDataForDropInService: String? = nil

  static func fromList(_ list: [Any?]) -> DropInConfiguration? {
    let environment = Environment(rawValue: list[0] as! Int)!
    let clientKey = list[1] as! String
    let amount = Amount.fromList(list[2] as! [Any?])!
    let countryCode = list[3] as! String
    let isAnalyticsEnabled: Bool? = nilOrValue(list[4])
    let showPreselectedStoredPaymentMethod: Bool? = nilOrValue(list[5])
    let skipListWhenSinglePaymentMethod: Bool? = nilOrValue(list[6])
    let isRemovingStoredPaymentMethodsEnabled: Bool? = nilOrValue(list[7])
    let additionalDataForDropInService: String? = nilOrValue(list[8])

    return DropInConfiguration(
      environment: environment,
      clientKey: clientKey,
      amount: amount,
      countryCode: countryCode,
      isAnalyticsEnabled: isAnalyticsEnabled,
      showPreselectedStoredPaymentMethod: showPreselectedStoredPaymentMethod,
      skipListWhenSinglePaymentMethod: skipListWhenSinglePaymentMethod,
      isRemovingStoredPaymentMethodsEnabled: isRemovingStoredPaymentMethodsEnabled,
      additionalDataForDropInService: additionalDataForDropInService
    )
  }
  func toList() -> [Any?] {
    return [
      environment.rawValue,
      clientKey,
      amount.toList(),
      countryCode,
      isAnalyticsEnabled,
      showPreselectedStoredPaymentMethod,
      skipListWhenSinglePaymentMethod,
      isRemovingStoredPaymentMethodsEnabled,
      additionalDataForDropInService,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct PaymentResult {
  var type: PaymentResultEnum
  var reason: String? = nil
  var result: SessionPaymentResultModel? = nil

  static func fromList(_ list: [Any?]) -> PaymentResult? {
    let type = PaymentResultEnum(rawValue: list[0] as! Int)!
    let reason: String? = nilOrValue(list[1])
    var result: SessionPaymentResultModel? = nil
    if let resultList: [Any?] = nilOrValue(list[2]) {
      result = SessionPaymentResultModel.fromList(resultList)
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
struct SessionPaymentResultModel {
  var sessionId: String? = nil
  var sessionData: String? = nil
  var resultCode: String? = nil
  var order: OrderResponseModel? = nil

  static func fromList(_ list: [Any?]) -> SessionPaymentResultModel? {
    let sessionId: String? = nilOrValue(list[0])
    let sessionData: String? = nilOrValue(list[1])
    let resultCode: String? = nilOrValue(list[2])
    var order: OrderResponseModel? = nil
    if let orderList: [Any?] = nilOrValue(list[3]) {
      order = OrderResponseModel.fromList(orderList)
    }

    return SessionPaymentResultModel(
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
        return DropInConfiguration.fromList(self.readValue() as! [Any?])
      case 130:
        return DropInError.fromList(self.readValue() as! [Any?])
      case 131:
        return DropInResult.fromList(self.readValue() as! [Any?])
      case 132:
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
    } else if let value = value as? DropInConfiguration {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? DropInError {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? DropInResult {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? Session {
      super.writeByte(132)
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
  func startDropInSessionPayment(dropInConfiguration: DropInConfiguration, session: Session) throws
  func startDropInAdvancedFlowPayment(dropInConfiguration: DropInConfiguration, paymentMethodsResponse: String) throws
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
        let dropInConfigurationArg = args[0] as! DropInConfiguration
        let sessionArg = args[1] as! Session
        do {
          try api.startDropInSessionPayment(dropInConfiguration: dropInConfigurationArg, session: sessionArg)
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
        let dropInConfigurationArg = args[0] as! DropInConfiguration
        let paymentMethodsResponseArg = args[1] as! String
        do {
          try api.startDropInAdvancedFlowPayment(dropInConfiguration: dropInConfigurationArg, paymentMethodsResponse: paymentMethodsResponseArg)
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
        return PlatformCommunicationModel.fromList(self.readValue() as! [Any?])
      case 132:
        return SessionPaymentResultModel.fromList(self.readValue() as! [Any?])
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
    } else if let value = value as? PlatformCommunicationModel {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? SessionPaymentResultModel {
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
