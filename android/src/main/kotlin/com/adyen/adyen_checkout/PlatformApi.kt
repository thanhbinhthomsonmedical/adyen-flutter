// Autogenerated from Pigeon (v12.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

enum class Environment(val raw: Int) {
  TEST(0),
  EUROPE(1),
  UNITEDSTATES(2),
  AUSTRALIA(3),
  INDIA(4),
  APSE(5);

  companion object {
    fun ofRaw(raw: Int): Environment? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class AddressMode(val raw: Int) {
  FULL(0),
  POSTALCODE(1),
  NONE(2);

  companion object {
    fun ofRaw(raw: Int): AddressMode? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class CardAuthMethod(val raw: Int) {
  PANONLY(0),
  CRYPTOGRAM3DS(1);

  companion object {
    fun ofRaw(raw: Int): CardAuthMethod? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class TotalPriceStatus(val raw: Int) {
  NOTCURRENTLYKNOWN(0),
  ESTIMATED(1),
  FINALPRICE(2);

  companion object {
    fun ofRaw(raw: Int): TotalPriceStatus? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class GooglePayEnvironment(val raw: Int) {
  TEST(0),
  PRODUCTION(1);

  companion object {
    fun ofRaw(raw: Int): GooglePayEnvironment? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class CashAppPayEnvironment(val raw: Int) {
  SANDBOX(0),
  PRODUCTION(1);

  companion object {
    fun ofRaw(raw: Int): CashAppPayEnvironment? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class PaymentResultEnum(val raw: Int) {
  CANCELLEDBYUSER(0),
  ERROR(1),
  FINISHED(2);

  companion object {
    fun ofRaw(raw: Int): PaymentResultEnum? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class PlatformCommunicationType(val raw: Int) {
  PAYMENTCOMPONENT(0),
  ADDITIONALDETAILS(1),
  RESULT(2),
  DELETESTOREDPAYMENTMETHOD(3);

  companion object {
    fun ofRaw(raw: Int): PlatformCommunicationType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class DropInResultType(val raw: Int) {
  FINISHED(0),
  ACTION(1),
  ERROR(2);

  companion object {
    fun ofRaw(raw: Int): DropInResultType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class FieldVisibility(val raw: Int) {
  SHOW(0),
  HIDE(1);

  companion object {
    fun ofRaw(raw: Int): FieldVisibility? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class SessionDTO (
  val id: String,
  val sessionData: String

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): SessionDTO {
      val id = list[0] as String
      val sessionData = list[1] as String
      return SessionDTO(id, sessionData)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      id,
      sessionData,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class AmountDTO (
  val currency: String,
  val value: Long

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): AmountDTO {
      val currency = list[0] as String
      val value = list[1].let { if (it is Int) it.toLong() else it as Long }
      return AmountDTO(currency, value)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      currency,
      value,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class AnalyticsOptionsDTO (
  val enabled: Boolean? = null,
  val payload: String? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): AnalyticsOptionsDTO {
      val enabled = list[0] as Boolean?
      val payload = list[1] as String?
      return AnalyticsOptionsDTO(enabled, payload)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      enabled,
      payload,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class DropInConfigurationDTO (
  val environment: Environment,
  val clientKey: String,
  val countryCode: String,
  val amount: AmountDTO,
  val shopperLocale: String,
  val cardsConfigurationDTO: CardsConfigurationDTO? = null,
  val applePayConfigurationDTO: ApplePayConfigurationDTO? = null,
  val googlePayConfigurationDTO: GooglePayConfigurationDTO? = null,
  val cashAppPayConfigurationDTO: CashAppPayConfigurationDTO? = null,
  val analyticsOptionsDTO: AnalyticsOptionsDTO? = null,
  val showPreselectedStoredPaymentMethod: Boolean,
  val skipListWhenSinglePaymentMethod: Boolean,
  val isRemoveStoredPaymentMethodEnabled: Boolean

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): DropInConfigurationDTO {
      val environment = Environment.ofRaw(list[0] as Int)!!
      val clientKey = list[1] as String
      val countryCode = list[2] as String
      val amount = AmountDTO.fromList(list[3] as List<Any?>)
      val shopperLocale = list[4] as String
      val cardsConfigurationDTO: CardsConfigurationDTO? = (list[5] as List<Any?>?)?.let {
        CardsConfigurationDTO.fromList(it)
      }
      val applePayConfigurationDTO: ApplePayConfigurationDTO? = (list[6] as List<Any?>?)?.let {
        ApplePayConfigurationDTO.fromList(it)
      }
      val googlePayConfigurationDTO: GooglePayConfigurationDTO? = (list[7] as List<Any?>?)?.let {
        GooglePayConfigurationDTO.fromList(it)
      }
      val cashAppPayConfigurationDTO: CashAppPayConfigurationDTO? = (list[8] as List<Any?>?)?.let {
        CashAppPayConfigurationDTO.fromList(it)
      }
      val analyticsOptionsDTO: AnalyticsOptionsDTO? = (list[9] as List<Any?>?)?.let {
        AnalyticsOptionsDTO.fromList(it)
      }
      val showPreselectedStoredPaymentMethod = list[10] as Boolean
      val skipListWhenSinglePaymentMethod = list[11] as Boolean
      val isRemoveStoredPaymentMethodEnabled = list[12] as Boolean
      return DropInConfigurationDTO(environment, clientKey, countryCode, amount, shopperLocale, cardsConfigurationDTO, applePayConfigurationDTO, googlePayConfigurationDTO, cashAppPayConfigurationDTO, analyticsOptionsDTO, showPreselectedStoredPaymentMethod, skipListWhenSinglePaymentMethod, isRemoveStoredPaymentMethodEnabled)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      environment.raw,
      clientKey,
      countryCode,
      amount.toList(),
      shopperLocale,
      cardsConfigurationDTO?.toList(),
      applePayConfigurationDTO?.toList(),
      googlePayConfigurationDTO?.toList(),
      cashAppPayConfigurationDTO?.toList(),
      analyticsOptionsDTO?.toList(),
      showPreselectedStoredPaymentMethod,
      skipListWhenSinglePaymentMethod,
      isRemoveStoredPaymentMethodEnabled,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class CardsConfigurationDTO (
  val holderNameRequired: Boolean,
  val addressMode: AddressMode,
  val showStorePaymentField: Boolean,
  val showCvcForStoredCard: Boolean,
  val showCvc: Boolean,
  val kcpFieldVisibility: FieldVisibility,
  val socialSecurityNumberFieldVisibility: FieldVisibility,
  val supportedCardTypes: List<String?>

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): CardsConfigurationDTO {
      val holderNameRequired = list[0] as Boolean
      val addressMode = AddressMode.ofRaw(list[1] as Int)!!
      val showStorePaymentField = list[2] as Boolean
      val showCvcForStoredCard = list[3] as Boolean
      val showCvc = list[4] as Boolean
      val kcpFieldVisibility = FieldVisibility.ofRaw(list[5] as Int)!!
      val socialSecurityNumberFieldVisibility = FieldVisibility.ofRaw(list[6] as Int)!!
      val supportedCardTypes = list[7] as List<String?>
      return CardsConfigurationDTO(holderNameRequired, addressMode, showStorePaymentField, showCvcForStoredCard, showCvc, kcpFieldVisibility, socialSecurityNumberFieldVisibility, supportedCardTypes)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      holderNameRequired,
      addressMode.raw,
      showStorePaymentField,
      showCvcForStoredCard,
      showCvc,
      kcpFieldVisibility.raw,
      socialSecurityNumberFieldVisibility.raw,
      supportedCardTypes,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class ApplePayConfigurationDTO (
  val merchantId: String,
  val merchantName: String,
  val allowOnboarding: Boolean

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): ApplePayConfigurationDTO {
      val merchantId = list[0] as String
      val merchantName = list[1] as String
      val allowOnboarding = list[2] as Boolean
      return ApplePayConfigurationDTO(merchantId, merchantName, allowOnboarding)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      merchantId,
      merchantName,
      allowOnboarding,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class GooglePayConfigurationDTO (
  val googlePayEnvironment: GooglePayEnvironment,
  val merchantAccount: String? = null,
  val allowedCardNetworks: List<String?>,
  val allowedAuthMethods: List<String?>,
  val totalPriceStatus: TotalPriceStatus? = null,
  val allowPrepaidCards: Boolean,
  val billingAddressRequired: Boolean,
  val emailRequired: Boolean,
  val shippingAddressRequired: Boolean,
  val existingPaymentMethodRequired: Boolean

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): GooglePayConfigurationDTO {
      val googlePayEnvironment = GooglePayEnvironment.ofRaw(list[0] as Int)!!
      val merchantAccount = list[1] as String?
      val allowedCardNetworks = list[2] as List<String?>
      val allowedAuthMethods = list[3] as List<String?>
      val totalPriceStatus: TotalPriceStatus? = (list[4] as Int?)?.let {
        TotalPriceStatus.ofRaw(it)
      }
      val allowPrepaidCards = list[5] as Boolean
      val billingAddressRequired = list[6] as Boolean
      val emailRequired = list[7] as Boolean
      val shippingAddressRequired = list[8] as Boolean
      val existingPaymentMethodRequired = list[9] as Boolean
      return GooglePayConfigurationDTO(googlePayEnvironment, merchantAccount, allowedCardNetworks, allowedAuthMethods, totalPriceStatus, allowPrepaidCards, billingAddressRequired, emailRequired, shippingAddressRequired, existingPaymentMethodRequired)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      googlePayEnvironment.raw,
      merchantAccount,
      allowedCardNetworks,
      allowedAuthMethods,
      totalPriceStatus?.raw,
      allowPrepaidCards,
      billingAddressRequired,
      emailRequired,
      shippingAddressRequired,
      existingPaymentMethodRequired,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class CashAppPayConfigurationDTO (
  val cashAppPayEnvironment: CashAppPayEnvironment,
  val returnUrl: String

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): CashAppPayConfigurationDTO {
      val cashAppPayEnvironment = CashAppPayEnvironment.ofRaw(list[0] as Int)!!
      val returnUrl = list[1] as String
      return CashAppPayConfigurationDTO(cashAppPayEnvironment, returnUrl)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      cashAppPayEnvironment.raw,
      returnUrl,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class PaymentResultDTO (
  val type: PaymentResultEnum,
  val reason: String? = null,
  val result: PaymentResultModelDTO? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): PaymentResultDTO {
      val type = PaymentResultEnum.ofRaw(list[0] as Int)!!
      val reason = list[1] as String?
      val result: PaymentResultModelDTO? = (list[2] as List<Any?>?)?.let {
        PaymentResultModelDTO.fromList(it)
      }
      return PaymentResultDTO(type, reason, result)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      type.raw,
      reason,
      result?.toList(),
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class PaymentResultModelDTO (
  val sessionId: String? = null,
  val sessionData: String? = null,
  val resultCode: String? = null,
  val order: OrderResponseDTO? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): PaymentResultModelDTO {
      val sessionId = list[0] as String?
      val sessionData = list[1] as String?
      val resultCode = list[2] as String?
      val order: OrderResponseDTO? = (list[3] as List<Any?>?)?.let {
        OrderResponseDTO.fromList(it)
      }
      return PaymentResultModelDTO(sessionId, sessionData, resultCode, order)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      sessionId,
      sessionData,
      resultCode,
      order?.toList(),
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class OrderResponseDTO (
  val pspReference: String,
  val orderData: String,
  val amount: AmountDTO? = null,
  val remainingAmount: AmountDTO? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): OrderResponseDTO {
      val pspReference = list[0] as String
      val orderData = list[1] as String
      val amount: AmountDTO? = (list[2] as List<Any?>?)?.let {
        AmountDTO.fromList(it)
      }
      val remainingAmount: AmountDTO? = (list[3] as List<Any?>?)?.let {
        AmountDTO.fromList(it)
      }
      return OrderResponseDTO(pspReference, orderData, amount, remainingAmount)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      pspReference,
      orderData,
      amount?.toList(),
      remainingAmount?.toList(),
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class PlatformCommunicationModel (
  val type: PlatformCommunicationType,
  val data: String? = null,
  val paymentResult: PaymentResultDTO? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): PlatformCommunicationModel {
      val type = PlatformCommunicationType.ofRaw(list[0] as Int)!!
      val data = list[1] as String?
      val paymentResult: PaymentResultDTO? = (list[2] as List<Any?>?)?.let {
        PaymentResultDTO.fromList(it)
      }
      return PlatformCommunicationModel(type, data, paymentResult)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      type.raw,
      data,
      paymentResult?.toList(),
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class DropInResultDTO (
  val dropInResultType: DropInResultType,
  val result: String? = null,
  val actionResponse: Map<String?, Any?>? = null,
  val error: DropInErrorDTO? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): DropInResultDTO {
      val dropInResultType = DropInResultType.ofRaw(list[0] as Int)!!
      val result = list[1] as String?
      val actionResponse = list[2] as Map<String?, Any?>?
      val error: DropInErrorDTO? = (list[3] as List<Any?>?)?.let {
        DropInErrorDTO.fromList(it)
      }
      return DropInResultDTO(dropInResultType, result, actionResponse, error)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      dropInResultType.raw,
      result,
      actionResponse,
      error?.toList(),
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class DropInErrorDTO (
  val errorMessage: String? = null,
  val reason: String? = null,
  val dismissDropIn: Boolean? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): DropInErrorDTO {
      val errorMessage = list[0] as String?
      val reason = list[1] as String?
      val dismissDropIn = list[2] as Boolean?
      return DropInErrorDTO(errorMessage, reason, dismissDropIn)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      errorMessage,
      reason,
      dismissDropIn,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class DeletedStoredPaymentMethodResultDTO (
  val storedPaymentMethodId: String,
  val isSuccessfullyRemoved: Boolean

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): DeletedStoredPaymentMethodResultDTO {
      val storedPaymentMethodId = list[0] as String
      val isSuccessfullyRemoved = list[1] as Boolean
      return DeletedStoredPaymentMethodResultDTO(storedPaymentMethodId, isSuccessfullyRemoved)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      storedPaymentMethodId,
      isSuccessfullyRemoved,
    )
  }
}

@Suppress("UNCHECKED_CAST")
private object CheckoutPlatformInterfaceCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AmountDTO.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AnalyticsOptionsDTO.fromList(it)
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          ApplePayConfigurationDTO.fromList(it)
        }
      }
      131.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          CardsConfigurationDTO.fromList(it)
        }
      }
      132.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          CashAppPayConfigurationDTO.fromList(it)
        }
      }
      133.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          DeletedStoredPaymentMethodResultDTO.fromList(it)
        }
      }
      134.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          DropInConfigurationDTO.fromList(it)
        }
      }
      135.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          DropInErrorDTO.fromList(it)
        }
      }
      136.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          DropInResultDTO.fromList(it)
        }
      }
      137.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          GooglePayConfigurationDTO.fromList(it)
        }
      }
      138.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          SessionDTO.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is AmountDTO -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is AnalyticsOptionsDTO -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      is ApplePayConfigurationDTO -> {
        stream.write(130)
        writeValue(stream, value.toList())
      }
      is CardsConfigurationDTO -> {
        stream.write(131)
        writeValue(stream, value.toList())
      }
      is CashAppPayConfigurationDTO -> {
        stream.write(132)
        writeValue(stream, value.toList())
      }
      is DeletedStoredPaymentMethodResultDTO -> {
        stream.write(133)
        writeValue(stream, value.toList())
      }
      is DropInConfigurationDTO -> {
        stream.write(134)
        writeValue(stream, value.toList())
      }
      is DropInErrorDTO -> {
        stream.write(135)
        writeValue(stream, value.toList())
      }
      is DropInResultDTO -> {
        stream.write(136)
        writeValue(stream, value.toList())
      }
      is GooglePayConfigurationDTO -> {
        stream.write(137)
        writeValue(stream, value.toList())
      }
      is SessionDTO -> {
        stream.write(138)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface CheckoutPlatformInterface {
  fun getPlatformVersion(callback: (Result<String>) -> Unit)
  fun getReturnUrl(callback: (Result<String>) -> Unit)
  fun startDropInSessionPayment(dropInConfigurationDTO: DropInConfigurationDTO, session: SessionDTO)
  fun startDropInAdvancedFlowPayment(dropInConfigurationDTO: DropInConfigurationDTO, paymentMethodsResponse: String)
  fun onPaymentsResult(paymentsResult: DropInResultDTO)
  fun onPaymentsDetailsResult(paymentsDetailsResult: DropInResultDTO)
  fun onDeleteStoredPaymentMethodResult(deleteStoredPaymentMethodResultDTO: DeletedStoredPaymentMethodResultDTO)
  fun enableLogging(loggingEnabled: Boolean)
  fun cleanUpDropIn()

  companion object {
    /** The codec used by CheckoutPlatformInterface. */
    val codec: MessageCodec<Any?> by lazy {
      CheckoutPlatformInterfaceCodec
    }
    /** Sets up an instance of `CheckoutPlatformInterface` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: CheckoutPlatformInterface?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.getPlatformVersion", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.getPlatformVersion() { result: Result<String> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.getReturnUrl", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.getReturnUrl() { result: Result<String> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startDropInSessionPayment", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val dropInConfigurationDTOArg = args[0] as DropInConfigurationDTO
            val sessionArg = args[1] as SessionDTO
            var wrapped: List<Any?>
            try {
              api.startDropInSessionPayment(dropInConfigurationDTOArg, sessionArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startDropInAdvancedFlowPayment", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val dropInConfigurationDTOArg = args[0] as DropInConfigurationDTO
            val paymentMethodsResponseArg = args[1] as String
            var wrapped: List<Any?>
            try {
              api.startDropInAdvancedFlowPayment(dropInConfigurationDTOArg, paymentMethodsResponseArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.onPaymentsResult", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val paymentsResultArg = args[0] as DropInResultDTO
            var wrapped: List<Any?>
            try {
              api.onPaymentsResult(paymentsResultArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.onPaymentsDetailsResult", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val paymentsDetailsResultArg = args[0] as DropInResultDTO
            var wrapped: List<Any?>
            try {
              api.onPaymentsDetailsResult(paymentsDetailsResultArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.onDeleteStoredPaymentMethodResult", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deleteStoredPaymentMethodResultDTOArg = args[0] as DeletedStoredPaymentMethodResultDTO
            var wrapped: List<Any?>
            try {
              api.onDeleteStoredPaymentMethodResult(deleteStoredPaymentMethodResultDTOArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.enableLogging", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val loggingEnabledArg = args[0] as Boolean
            var wrapped: List<Any?>
            try {
              api.enableLogging(loggingEnabledArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.cleanUpDropIn", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.cleanUpDropIn()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
@Suppress("UNCHECKED_CAST")
private object CheckoutFlutterApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AmountDTO.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          OrderResponseDTO.fromList(it)
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          PaymentResultDTO.fromList(it)
        }
      }
      131.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          PaymentResultModelDTO.fromList(it)
        }
      }
      132.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          PlatformCommunicationModel.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is AmountDTO -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is OrderResponseDTO -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      is PaymentResultDTO -> {
        stream.write(130)
        writeValue(stream, value.toList())
      }
      is PaymentResultModelDTO -> {
        stream.write(131)
        writeValue(stream, value.toList())
      }
      is PlatformCommunicationModel -> {
        stream.write(132)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class CheckoutFlutterApi(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by CheckoutFlutterApi. */
    val codec: MessageCodec<Any?> by lazy {
      CheckoutFlutterApiCodec
    }
  }
  fun onDropInSessionPlatformCommunication(platformCommunicationModelArg: PlatformCommunicationModel, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInSessionPlatformCommunication", codec)
    channel.send(listOf(platformCommunicationModelArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
  fun onDropInAdvancedFlowPlatformCommunication(platformCommunicationModelArg: PlatformCommunicationModel, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInAdvancedFlowPlatformCommunication", codec)
    channel.send(listOf(platformCommunicationModelArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
}
