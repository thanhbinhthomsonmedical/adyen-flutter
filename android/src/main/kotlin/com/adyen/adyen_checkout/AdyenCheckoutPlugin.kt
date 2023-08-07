package com.adyen.adyen_checkout

import CheckoutApi
import DropInConfigurationModel
import SessionModel
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AdyenCheckoutPlugin */
class AdyenCheckoutPlugin: FlutterPlugin, MethodCallHandler, CheckoutApi {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    CheckoutApi.setUp(flutterPluginBinding.binaryMessenger, this)

    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "adyen_checkout")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun getPlatformVersion(callback: (kotlin.Result<String>) -> Unit) {
    callback.invoke(kotlin.Result.success("Android ${android.os.Build.VERSION.RELEASE}"))
  }

  override fun startPayment(
    sessionModel: SessionModel,
    dropInConfiguration: DropInConfigurationModel,
    callback: (kotlin.Result<Unit>) -> Unit
  ) {
    TODO("Not yet implemented")
  }
}
