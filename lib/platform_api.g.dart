// Autogenerated from Pigeon (v10.1.4), do not edit directly.
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
    required this.currency,
    required this.value,
  });

  String currency;

  double value;

  Object encode() {
    return <Object?>[
      currency,
      value,
    ];
  }

  static Amount decode(Object result) {
    result as List<Object?>;
    return Amount(
      currency: result[0]! as String,
      value: result[1]! as double,
    );
  }
}

class DropInConfigurationModel {
  DropInConfigurationModel({
    this.shopperLocale,
    required this.environment,
    required this.clientKey,
    required this.amount,
    this.isAnalyticsEnabled,
    this.showPreselectedStoredPaymentMethod,
    this.skipListWhenSinglePaymentMethod,
    this.isRemovingStoredPaymentMethodsEnabled,
    this.additionalDataForDropInService,
  });

  Locale? shopperLocale;

  Environment environment;

  String clientKey;

  Amount amount;

  bool? isAnalyticsEnabled;

  bool? showPreselectedStoredPaymentMethod;

  bool? skipListWhenSinglePaymentMethod;

  bool? isRemovingStoredPaymentMethodsEnabled;

  String? additionalDataForDropInService;

  Object encode() {
    return <Object?>[
      shopperLocale?.index,
      environment.index,
      clientKey,
      amount.encode(),
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
      shopperLocale: result[0] != null
          ? Locale.values[result[0]! as int]
          : null,
      environment: Environment.values[result[1]! as int],
      clientKey: result[2]! as String,
      amount: Amount.decode(result[3]! as List<Object?>),
      isAnalyticsEnabled: result[4] as bool?,
      showPreselectedStoredPaymentMethod: result[5] as bool?,
      skipListWhenSinglePaymentMethod: result[6] as bool?,
      isRemovingStoredPaymentMethodsEnabled: result[7] as bool?,
      additionalDataForDropInService: result[8] as String?,
    );
  }
}

class _CheckoutPlatformApiCodec extends StandardMessageCodec {
  const _CheckoutPlatformApiCodec();
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

class CheckoutPlatformApi {
  /// Constructor for [CheckoutPlatformApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  CheckoutPlatformApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _CheckoutPlatformApiCodec();

  Future<String> getPlatformVersion() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformApi.getPlatformVersion', codec,
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
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformApi.startPayment', codec,
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
}