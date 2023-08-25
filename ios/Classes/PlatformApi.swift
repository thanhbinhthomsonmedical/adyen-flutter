// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

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

enum Locale: Int {
  case canada = 0
  case canadaFrench = 1
  case china = 2
  case chinese = 3
  case english = 4
  case france = 5
  case french = 6
  case german = 7
  case germany = 8
  case italian = 9
  case italy = 10
  case japan = 11
  case japanese = 12
  case korea = 13
  case korean = 14
  case prc = 15
  case root = 16
  case simplifiedChinese = 17
  case taiwan = 18
  case traditionalChinese = 19
  case uk = 20
  case us = 21
}

enum DropInResultEnum: Int {
  case cancelledByUser = 0
  case error = 1
  case finished = 2
}

enum PlatformCommunicationType: Int {
  case paymentComponent = 0
  case additionalDetails = 1
  case result = 2
}

/// Generated class from Pigeon that represents data sent in messages.
struct SessionModel {
  var id: String
  var sessionData: String

  static func fromList(_ list: [Any?]) -> SessionModel? {
    let id = list[0] as! String
    let sessionData = list[1] as! String

    return SessionModel(
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
struct DropInConfigurationModel {
  var environment: Environment
  var clientKey: String
  var amount: Amount
  var shopperLocale: String
  var isAnalyticsEnabled: Bool? = nil
  var showPreselectedStoredPaymentMethod: Bool? = nil
  var skipListWhenSinglePaymentMethod: Bool? = nil
  var isRemovingStoredPaymentMethodsEnabled: Bool? = nil
  var additionalDataForDropInService: String? = nil

  static func fromList(_ list: [Any?]) -> DropInConfigurationModel? {
    let environment = Environment(rawValue: list[0] as! Int)!
    let clientKey = list[1] as! String
    let amount = Amount.fromList(list[2] as! [Any?])!
    let shopperLocale = list[3] as! String
    let isAnalyticsEnabled: Bool? = nilOrValue(list[4])
    let showPreselectedStoredPaymentMethod: Bool? = nilOrValue(list[5])
    let skipListWhenSinglePaymentMethod: Bool? = nilOrValue(list[6])
    let isRemovingStoredPaymentMethodsEnabled: Bool? = nilOrValue(list[7])
    let additionalDataForDropInService: String? = nilOrValue(list[8])

    return DropInConfigurationModel(
      environment: environment,
      clientKey: clientKey,
      amount: amount,
      shopperLocale: shopperLocale,
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
      shopperLocale,
      isAnalyticsEnabled,
      showPreselectedStoredPaymentMethod,
      skipListWhenSinglePaymentMethod,
      isRemovingStoredPaymentMethodsEnabled,
      additionalDataForDropInService,
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
struct DropInResultModel {
  var sessionDropInResult: DropInResultEnum
  var reason: String? = nil
  var result: SessionPaymentResultModel? = nil

  static func fromList(_ list: [Any?]) -> DropInResultModel? {
    let sessionDropInResult = DropInResultEnum(rawValue: list[0] as! Int)!
    let reason: String? = nilOrValue(list[1])
    var result: SessionPaymentResultModel? = nil
    if let resultList: [Any?] = nilOrValue(list[2]) {
      result = SessionPaymentResultModel.fromList(resultList)
    }

    return DropInResultModel(
      sessionDropInResult: sessionDropInResult,
      reason: reason,
      result: result
    )
  }
  func toList() -> [Any?] {
    return [
      sessionDropInResult.rawValue,
      reason,
      result?.toList(),
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct PlatformCommunicationModel {
  var type: PlatformCommunicationType
  var data: String? = nil
  var result: DropInResultModel? = nil

  static func fromList(_ list: [Any?]) -> PlatformCommunicationModel? {
    let type = PlatformCommunicationType(rawValue: list[0] as! Int)!
    let data: String? = nilOrValue(list[1])
    var result: DropInResultModel? = nil
    if let resultList: [Any?] = nilOrValue(list[2]) {
      result = DropInResultModel.fromList(resultList)
    }

    return PlatformCommunicationModel(
      type: type,
      data: data,
      result: result
    )
  }
  func toList() -> [Any?] {
    return [
      type.rawValue,
      data,
      result?.toList(),
    ]
  }
}

private class CheckoutPlatformInterfaceCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return Amount.fromList(self.readValue() as! [Any?])
      case 129:
        return DropInConfigurationModel.fromList(self.readValue() as! [Any?])
      case 130:
        return DropInResultModel.fromList(self.readValue() as! [Any?])
      case 131:
        return OrderResponseModel.fromList(self.readValue() as! [Any?])
      case 132:
        return PlatformCommunicationModel.fromList(self.readValue() as! [Any?])
      case 133:
        return SessionModel.fromList(self.readValue() as! [Any?])
      case 134:
        return SessionPaymentResultModel.fromList(self.readValue() as! [Any?])
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
    } else if let value = value as? DropInConfigurationModel {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? DropInResultModel {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? OrderResponseModel {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? PlatformCommunicationModel {
      super.writeByte(132)
      super.writeValue(value.toList())
    } else if let value = value as? SessionModel {
      super.writeByte(133)
      super.writeValue(value.toList())
    } else if let value = value as? SessionPaymentResultModel {
      super.writeByte(134)
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

class CheckoutPlatformInterfaceCodec : FlutterStandardMessageCodec {
    static let shared = CheckoutPlatformInterfaceCodec(readerWriter
    :

    CheckoutPlatformInterfaceCodecReaderWriter()

    )
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol

CheckoutPlatformInterface {
func getPlatformVersion(completion
: @
escaping (Result<String, Error>)
-> Void)
func getReturnUrl(completion
: @
escaping (Result<String, Error>)
-> Void)
func startPayment(dropInConfiguration
: DropInConfigurationModel, sessionModel: SessionModel)
throws
        func
startPaymentDropInAdvancedFlow(dropInConfiguration
: DropInConfigurationModel, paymentMethodsResponse: String)
throws
        func
onPaymentsResult(paymentsResult
: [String: Any?])
throws
        func
onPaymentsDetailsResult(paymentsDetailsResult
: [String: Any?]) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class CheckoutPlatformInterfaceSetup {
    /// The codec used by CheckoutPlatformInterface.
    static var codec: FlutterStandardMessageCodec{CheckoutPlatformInterfaceCodec.shared}

    /// Sets up an instance of `CheckoutPlatformInterface` to handle messages through the `binaryMessenger`.
    static func setUp(binaryMessenger

    : FlutterBinaryMessenger,
    api: CheckoutPlatformInterface ?
    ) {
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
    let startPaymentChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startPayment", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      startPaymentChannel.setMessageHandler {
                    message, reply
                    in
                    let
                    args = message
                    as
                    ! [Any ?]
                    let
                    dropInConfigurationArg = args[0]
                    as
                    !DropInConfigurationModel
                    let
                    sessionModelArg = args[1]
                    as
                    !SessionModel
                    do {
                        try
                        api.startPayment(
                                dropInConfiguration: dropInConfigurationArg, sessionModel: sessionModelArg)
                        reply(wrapResult(nil))
                    } catch {
                        reply(wrapError(error))
                    }
                }
    } else {
      startPaymentChannel.setMessageHandler(nil)
    }
    let startPaymentDropInAdvancedFlowChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startPaymentDropInAdvancedFlow", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      startPaymentDropInAdvancedFlowChannel.setMessageHandler {
                    message, reply
                    in
                    let
                    args = message
                    as
                    ! [Any ?]
                    let
                    dropInConfigurationArg = args[0]
                    as
                    !DropInConfigurationModel
                    let
                    paymentMethodsResponseArg = args[1]
                    as
                    !String
                    do {
                        try
                        api.startPaymentDropInAdvancedFlow(
                                dropInConfiguration: dropInConfigurationArg, paymentMethodsResponse: paymentMethodsResponseArg)
                        reply(wrapResult(nil))
                    } catch {
                        reply(wrapError(error))
                    }
                }
    } else {
      startPaymentDropInAdvancedFlowChannel.setMessageHandler(nil)
    }
    let onPaymentsResultChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.onPaymentsResult", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      onPaymentsResultChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let paymentsResultArg = args[0] as! [String: Any?]
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
        let paymentsDetailsResultArg = args[0] as! [String: Any?]
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

private

class CheckoutFlutterApiCodecReader : FlutterStandardReader {
    override func
    readValue(ofType
    type: UInt8
    ) -> Any? {
        switch type{
                    case 128:
                    return Amount.fromList(self.readValue() as![Any?])
                    case 129:
                    return DropInResultModel.fromList(self.readValue() as![Any?])
                    case 130:
                    return OrderResponseModel.fromList(self.readValue() as![Any?])
                    case 131:
                    return PlatformCommunicationModel.fromList(self.readValue() as![Any?])
                    case 132:
                    return SessionPaymentResultModel.fromList(self.readValue() as![Any?])
                    default:
                    return super.readValue(ofType: type)
            }
    }
}

private

class CheckoutFlutterApiCodecWriter : FlutterStandardWriter {
    override func
    writeValue(_
    value: Any
    ) {
        if let
        value = value
        as ? Amount{
                super.writeByte(128)
                super.writeValue(value.toList())
        } else if let
        value = value
        as ? DropInResultModel{
                super.writeByte(129)
                super.writeValue(value.toList())
        } else if let
        value = value
        as ? OrderResponseModel{
                super.writeByte(130)
                super.writeValue(value.toList())
    } else if let value = value as? PlatformCommunicationModel {
      super.writeByte(131)
                super.writeValue(value.toList())
        } else if let
        value = value
        as ? SessionPaymentResultModel{
                super.writeByte(132)
                super.writeValue(value.toList())
        } else {
            super.writeValue(value)
        }
    }
}

private

class CheckoutFlutterApiCodecReaderWriter : FlutterStandardReaderWriter {
    override func
    reader(with
    data: Data
    ) -> FlutterStandardReader {
        return CheckoutFlutterApiCodecReader(data: data)
    }

    override func
    writer(with
    data: NSMutableData
    ) -> FlutterStandardWriter {
        return CheckoutFlutterApiCodecWriter(data: data)
    }
}

class CheckoutFlutterApiCodec : FlutterStandardMessageCodec {
    static let shared = CheckoutFlutterApiCodec(readerWriter
    :

    CheckoutFlutterApiCodecReaderWriter()

    )
}

/// Generated class from Pigeon that represents Flutter messages that can be called from Swift.
class CheckoutFlutterApi {
private
    let binaryMessenger: FlutterBinaryMessenger
            init(binaryMessenger
    : FlutterBinaryMessenger){
        self.binaryMessenger = binaryMessenger
    }
    var codec: FlutterStandardMessageCodec{
            return CheckoutFlutterApiCodec.shared
    }
            func
    onDropInSessionResult(sessionDropInResult
    sessionDropInResultArg: DropInResultModel, completion:
    @escaping() -> Void) {
        let
        channel = FlutterBasicMessageChannel(
                name: "dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInSessionResult", binaryMessenger: binaryMessenger, codec: codec)
        channel.sendMessage([sessionDropInResultArg]
        as[Any ?]) {
            _ in
            completion()
        }
    }

    func onDropInAdvancedFlowPlatformCommunication(
            platformCommunicationModel platformCommunicationModelArg

    : PlatformCommunicationModel,
    completion:
    @escaping() -> Void) {
        let
        channel = FlutterBasicMessageChannel(
                name: "dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInAdvancedFlowPlatformCommunication", binaryMessenger: binaryMessenger, codec: codec)
        channel.sendMessage([platformCommunicationModelArg]
        as[Any ?]) {
            _ in
            completion()
        }
    }
}
