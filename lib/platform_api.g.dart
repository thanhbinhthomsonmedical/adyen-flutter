// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

enum Environment {
  test,
  europe,
  unitedStates,
  australia,
  india,
  apse,
}

enum Locale {
  canada,
  canadaFrench,
  china,
  chinese,
  english,
  france,
  french,
  german,
  germany,
  italian,
  italy,
  japan,
  japanese,
  korea,
  korean,
  prc,
  root,
  simplifiedChinese,
  taiwan,
  traditionalChinese,
  uk,
  us,
}

enum SessionDropInResultEnum {
  cancelledByUser,
  error,
  finished,
}

class SessionModel {
  SessionModel({
    required this.id,
    required this.sessionData,
  });

  String id;

  String sessionData;

  Object encode() {
    return <Object?>[
      id,
      sessionData,
    ];
  }

  static SessionModel decode(Object result) {
    result as List<Object?>;
    return SessionModel(
      id: result[0]! as String,
      sessionData: result[1]! as String,
    );
  }
}

class Amount {
  Amount({
    this.currency,
    required this.value,
  });

  String? currency;

  int value;

  Object encode() {
    return <Object?>[
      currency,
      value,
    ];
  }

  static Amount decode(Object result) {
    result as List<Object?>;
    return Amount(
      currency: result[0] as String?,
      value: result[1]! as int,
    );
  }
}

class DropInConfigurationModel {
  DropInConfigurationModel({
    required this.environment,
    required this.clientKey,
    required this.amount,
    this.shopperLocale,
    this.isAnalyticsEnabled,
    this.showPreselectedStoredPaymentMethod,
    this.skipListWhenSinglePaymentMethod,
    this.isRemovingStoredPaymentMethodsEnabled,
    this.additionalDataForDropInService,
  });

  Environment environment;

  String clientKey;

  Amount amount;

  String? shopperLocale;

  bool? isAnalyticsEnabled;

  bool? showPreselectedStoredPaymentMethod;

  bool? skipListWhenSinglePaymentMethod;

  bool? isRemovingStoredPaymentMethodsEnabled;

  String? additionalDataForDropInService;

  Object encode() {
    return <Object?>[
      environment.index,
      clientKey,
      amount.encode(),
      shopperLocale,
      isAnalyticsEnabled,
      showPreselectedStoredPaymentMethod,
      skipListWhenSinglePaymentMethod,
      isRemovingStoredPaymentMethodsEnabled,
      additionalDataForDropInService,
    ];
  }

  static DropInConfigurationModel decode(Object result) {
    result as List<Object?>;
    return DropInConfigurationModel(
      environment: Environment.values[result[0]! as int],
      clientKey: result[1]! as String,
      amount: Amount.decode(result[2]! as List<Object?>),
      shopperLocale: result[3] as String?,
      isAnalyticsEnabled: result[4] as bool?,
      showPreselectedStoredPaymentMethod: result[5] as bool?,
      skipListWhenSinglePaymentMethod: result[6] as bool?,
      isRemovingStoredPaymentMethodsEnabled: result[7] as bool?,
      additionalDataForDropInService: result[8] as String?,
    );
  }
}

class SessionPaymentResultModel {
  SessionPaymentResultModel({
    this.sessionId,
    this.sessionData,
    this.resultCode,
    this.order,
  });

  String? sessionId;

  String? sessionData;

  String? resultCode;

  OrderResponseModel? order;

  Object encode() {
    return <Object?>[
      sessionId,
      sessionData,
      resultCode,
      order?.encode(),
    ];
  }

  static SessionPaymentResultModel decode(Object result) {
    result as List<Object?>;
    return SessionPaymentResultModel(
      sessionId: result[0] as String?,
      sessionData: result[1] as String?,
      resultCode: result[2] as String?,
      order: result[3] != null
          ? OrderResponseModel.decode(result[3]! as List<Object?>)
          : null,
    );
  }
}

class OrderResponseModel {
  OrderResponseModel({
    required this.pspReference,
    required this.orderData,
    this.amount,
    this.remainingAmount,
  });

  String pspReference;

  String orderData;

  Amount? amount;

  Amount? remainingAmount;

  Object encode() {
    return <Object?>[
      pspReference,
      orderData,
      amount?.encode(),
      remainingAmount?.encode(),
    ];
  }

  static OrderResponseModel decode(Object result) {
    result as List<Object?>;
    return OrderResponseModel(
      pspReference: result[0]! as String,
      orderData: result[1]! as String,
      amount: result[2] != null
          ? Amount.decode(result[2]! as List<Object?>)
          : null,
      remainingAmount: result[3] != null
          ? Amount.decode(result[3]! as List<Object?>)
          : null,
    );
  }
}

class SessionDropInResultModel {
  SessionDropInResultModel({
    required this.sessionDropInResult,
    this.reason,
    this.result,
  });

  SessionDropInResultEnum sessionDropInResult;

  String? reason;

  SessionPaymentResultModel? result;

  Object encode() {
    return <Object?>[
      sessionDropInResult.index,
      reason,
      result?.encode(),
    ];
  }

  static SessionDropInResultModel decode(Object result) {
    result as List<Object?>;
    return SessionDropInResultModel(
      sessionDropInResult: SessionDropInResultEnum.values[result[0]! as int],
      reason: result[1] as String?,
      result: result[2] != null
          ? SessionPaymentResultModel.decode(result[2]! as List<Object?>)
          : null,
    );
  }
}

class _CheckoutPlatformInterfaceCodec extends StandardMessageCodec {
  const _CheckoutPlatformInterfaceCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is Amount) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is DropInConfigurationModel) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is SessionModel) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return Amount.decode(readValue(buffer)!);
      case 129: 
        return DropInConfigurationModel.decode(readValue(buffer)!);
      case 130: 
        return SessionModel.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class CheckoutPlatformInterface {
  /// Constructor for [CheckoutPlatformInterface].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  CheckoutPlatformInterface({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _CheckoutPlatformInterfaceCodec();

  Future<String> getPlatformVersion() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.getPlatformVersion', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }

  Future<void> startPayment(SessionModel arg_sessionModel, DropInConfigurationModel arg_dropInConfiguration) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startPayment', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_sessionModel, arg_dropInConfiguration]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<String> getReturnUrl() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.getReturnUrl', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }
}

class _CheckoutResultFlutterInterfaceCodec extends StandardMessageCodec {
  const _CheckoutResultFlutterInterfaceCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is Amount) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is OrderResponseModel) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is SessionDropInResultModel) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is SessionPaymentResultModel) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return Amount.decode(readValue(buffer)!);
      case 129: 
        return OrderResponseModel.decode(readValue(buffer)!);
      case 130: 
        return SessionDropInResultModel.decode(readValue(buffer)!);
      case 131: 
        return SessionPaymentResultModel.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class CheckoutResultFlutterInterface {
  static const MessageCodec<Object?> codec = _CheckoutResultFlutterInterfaceCodec();

  void onSessionDropInResult(SessionDropInResultModel sessionDropInResult);

  static void setup(CheckoutResultFlutterInterface? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.adyen_checkout.CheckoutResultFlutterInterface.onSessionDropInResult', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.adyen_checkout.CheckoutResultFlutterInterface.onSessionDropInResult was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final SessionDropInResultModel? arg_sessionDropInResult = (args[0] as SessionDropInResultModel?);
          assert(arg_sessionDropInResult != null,
              'Argument for dev.flutter.pigeon.adyen_checkout.CheckoutResultFlutterInterface.onSessionDropInResult was null, expected non-null SessionDropInResultModel.');
          api.onSessionDropInResult(arg_sessionDropInResult!);
          return;
        });
      }
    }
  }
}
