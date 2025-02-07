package com.adyen.checkout.flutter.dropIn

import androidx.activity.result.ActivityResultLauncher
import androidx.fragment.app.FragmentActivity
import androidx.lifecycle.lifecycleScope
import com.adyen.checkout.components.core.Order
import com.adyen.checkout.components.core.PaymentMethodsApiResponse
import com.adyen.checkout.dropin.DropIn
import com.adyen.checkout.dropin.DropInCallback
import com.adyen.checkout.dropin.DropInResult
import com.adyen.checkout.dropin.SessionDropInCallback
import com.adyen.checkout.dropin.SessionDropInResult
import com.adyen.checkout.dropin.internal.ui.model.DropInResultContractParams
import com.adyen.checkout.dropin.internal.ui.model.SessionDropInResultContractParams
import com.adyen.checkout.flutter.dropIn.advanced.AdvancedDropInService
import com.adyen.checkout.flutter.dropIn.advanced.DropInAdditionalDetailsPlatformMessenger
import com.adyen.checkout.flutter.dropIn.advanced.DropInAdditionalDetailsResultMessenger
import com.adyen.checkout.flutter.dropIn.advanced.DropInBalanceCheckPlatformMessenger
import com.adyen.checkout.flutter.dropIn.advanced.DropInBalanceCheckResultMessenger
import com.adyen.checkout.flutter.dropIn.advanced.DropInOrderCancelPlatformMessenger
import com.adyen.checkout.flutter.dropIn.advanced.DropInOrderCancelResultMessenger
import com.adyen.checkout.flutter.dropIn.advanced.DropInOrderRequestPlatformMessenger
import com.adyen.checkout.flutter.dropIn.advanced.DropInOrderRequestResultMessenger
import com.adyen.checkout.flutter.dropIn.advanced.DropInPaymentMethodDeletionPlatformMessenger
import com.adyen.checkout.flutter.dropIn.advanced.DropInPaymentMethodDeletionResultMessenger
import com.adyen.checkout.flutter.dropIn.advanced.DropInPaymentResultMessenger
import com.adyen.checkout.flutter.dropIn.advanced.DropInServiceResultMessenger
import com.adyen.checkout.flutter.dropIn.model.DropInType
import com.adyen.checkout.flutter.dropIn.session.SessionDropInService
import com.adyen.checkout.flutter.generated.DeletedStoredPaymentMethodResultDTO
import com.adyen.checkout.flutter.generated.DropInConfigurationDTO
import com.adyen.checkout.flutter.generated.DropInFlutterInterface
import com.adyen.checkout.flutter.generated.DropInPlatformInterface
import com.adyen.checkout.flutter.generated.OrderCancelResultDTO
import com.adyen.checkout.flutter.generated.PaymentEventDTO
import com.adyen.checkout.flutter.generated.PaymentEventType
import com.adyen.checkout.flutter.generated.PaymentResultDTO
import com.adyen.checkout.flutter.generated.PaymentResultEnum
import com.adyen.checkout.flutter.generated.PaymentResultModelDTO
import com.adyen.checkout.flutter.generated.PlatformCommunicationModel
import com.adyen.checkout.flutter.generated.PlatformCommunicationType
import com.adyen.checkout.flutter.session.SessionHolder
import com.adyen.checkout.flutter.utils.ConfigurationMapper.mapToDropInConfiguration
import com.adyen.checkout.flutter.utils.ConfigurationMapper.mapToEnvironment
import com.adyen.checkout.flutter.utils.ConfigurationMapper.mapToOrderResponseModel
import com.adyen.checkout.sessions.core.CheckoutSession
import com.adyen.checkout.sessions.core.SessionSetupResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONObject

class DropInPlatformApi(
    private val dropInFlutterApi: DropInFlutterInterface,
    private val activity: FragmentActivity,
    private val sessionHolder: SessionHolder,
) : DropInPlatformInterface {
    lateinit var dropInSessionLauncher: ActivityResultLauncher<SessionDropInResultContractParams>
    lateinit var dropInAdvancedFlowLauncher: ActivityResultLauncher<DropInResultContractParams>

    override fun showDropInSession(dropInConfigurationDTO: DropInConfigurationDTO) {
        setStoredPaymentMethodDeletionObserver()
        val dropInConfiguration = dropInConfigurationDTO.mapToDropInConfiguration(activity.applicationContext)
        val checkoutSession =
            createCheckoutSession(
                sessionHolder,
                dropInConfigurationDTO.environment.mapToEnvironment(),
                dropInConfigurationDTO.clientKey
            )
        DropIn.startPayment(
            activity.applicationContext,
            dropInSessionLauncher,
            checkoutSession,
            dropInConfiguration,
            SessionDropInService::class.java
        )
    }

    override fun showDropInAdvanced(
        dropInConfigurationDTO: DropInConfigurationDTO,
        paymentMethodsResponse: String,
    ) {
        setAdvancedFlowDropInServiceObserver()
        setStoredPaymentMethodDeletionObserver()
        setBalanceCheckPlatformMessengerObserver()
        setOrderRequestPlatformMessengerObserver()
        setOrderCancelPlatformMessengerObserver()
        activity.lifecycleScope.launch(Dispatchers.IO) {
            val paymentMethodsApiResponse =
                PaymentMethodsApiResponse.SERIALIZER.deserialize(
                    JSONObject(paymentMethodsResponse),
                )
            val paymentMethodsWithoutGiftCards =
                removeGiftCardPaymentMethods(
                    paymentMethodsApiResponse,
                    dropInConfigurationDTO.isPartialPaymentSupported
                )
            val dropInConfiguration = dropInConfigurationDTO.mapToDropInConfiguration(activity.applicationContext)
            withContext(Dispatchers.Main) {
                DropIn.startPayment(
                    activity.applicationContext,
                    dropInAdvancedFlowLauncher,
                    paymentMethodsWithoutGiftCards,
                    dropInConfiguration,
                    AdvancedDropInService::class.java,
                )
            }
        }
    }

    override fun onPaymentsResult(paymentsResult: PaymentEventDTO) {
        if (paymentsResult.paymentEventType == PaymentEventType.ACTION) {
            setAdvanceFlowDropInAdditionalDetailsMessengerObserver()
        }

        DropInPaymentResultMessenger.sendResult(paymentsResult)
    }

    override fun onPaymentsDetailsResult(paymentsDetailsResult: PaymentEventDTO) {
        DropInAdditionalDetailsResultMessenger.sendResult(paymentsDetailsResult)
    }

    override fun onDeleteStoredPaymentMethodResult(
        deleteStoredPaymentMethodResultDTO: DeletedStoredPaymentMethodResultDTO
    ) {
        DropInPaymentMethodDeletionResultMessenger.sendResult(deleteStoredPaymentMethodResultDTO)
    }

    override fun onBalanceCheckResult(balanceCheckResponse: String) {
        DropInBalanceCheckResultMessenger.sendResult(balanceCheckResponse)
    }

    override fun onOrderRequestResult(orderRequestResponse: String) {
        DropInOrderRequestResultMessenger.sendResult(orderRequestResponse)
    }

    override fun onOrderCancelResult(orderCancelResult: OrderCancelResultDTO) {
        DropInOrderCancelResultMessenger.sendResult(orderCancelResult)
    }

    override fun cleanUpDropIn() {
        DropInServiceResultMessenger.instance().removeObservers(activity)
        DropInAdditionalDetailsPlatformMessenger.instance().removeObservers(activity)
        DropInPaymentMethodDeletionPlatformMessenger.instance().removeObservers(activity)
        DropInBalanceCheckResultMessenger.instance().removeObservers(activity)
        DropInOrderRequestResultMessenger.instance().removeObservers(activity)
        DropInOrderCancelPlatformMessenger.instance().removeObservers(activity)
    }

    private fun setAdvancedFlowDropInServiceObserver() {
        DropInServiceResultMessenger.instance().removeObservers(activity)
        DropInServiceResultMessenger.instance().observe(activity) { message ->
            if (message.hasBeenHandled()) {
                return@observe
            }

            val model =
                PlatformCommunicationModel(
                    PlatformCommunicationType.PAYMENT_COMPONENT,
                    data = message.contentIfNotHandled.toString(),
                )
            dropInFlutterApi.onDropInPlatformCommunication(model) {}
        }
    }

    private fun setStoredPaymentMethodDeletionObserver() {
        DropInPaymentMethodDeletionPlatformMessenger.instance().removeObservers(activity)
        DropInPaymentMethodDeletionPlatformMessenger.instance().observe(activity) { message ->
            if (message.hasBeenHandled()) {
                return@observe
            }

            val dropInStoredPaymentMethodDeletionModel = message.contentIfNotHandled
            val platformCommunicationModel =
                PlatformCommunicationModel(
                    PlatformCommunicationType.DELETE_STORED_PAYMENT_METHOD,
                    data = dropInStoredPaymentMethodDeletionModel?.storedPaymentMethodId,
                )

            dropInFlutterApi.onDropInPlatformCommunication(platformCommunicationModel) {}
        }
    }

    private fun setAdvanceFlowDropInAdditionalDetailsMessengerObserver() {
        DropInAdditionalDetailsPlatformMessenger.instance().removeObservers(activity)
        DropInAdditionalDetailsPlatformMessenger.instance().observe(activity) { message ->
            if (message.hasBeenHandled()) {
                return@observe
            }

            val platformCommunicationModel =
                PlatformCommunicationModel(
                    PlatformCommunicationType.ADDITIONAL_DETAILS,
                    data = message.contentIfNotHandled.toString(),
                )

            dropInFlutterApi.onDropInPlatformCommunication(platformCommunicationModel) {}
        }
    }

    private fun setBalanceCheckPlatformMessengerObserver() {
        DropInBalanceCheckPlatformMessenger.instance().removeObservers(activity)
        DropInBalanceCheckPlatformMessenger.instance().observe(activity) { message ->
            if (message.hasBeenHandled()) {
                return@observe
            }

            val platformCommunicationModel =
                PlatformCommunicationModel(
                    PlatformCommunicationType.BALANCE_CHECK,
                    data = message.contentIfNotHandled.toString()
                )
            dropInFlutterApi.onDropInPlatformCommunication(platformCommunicationModel) {}
        }
    }

    private fun setOrderRequestPlatformMessengerObserver() {
        DropInOrderRequestPlatformMessenger.instance().removeObservers(activity)
        DropInOrderRequestPlatformMessenger.instance().observe(activity) { message ->
            if (message.hasBeenHandled()) {
                return@observe
            }

            val platformCommunicationModel =
                PlatformCommunicationModel(
                    PlatformCommunicationType.REQUEST_ORDER,
                    data = message.contentIfNotHandled.toString()
                )
            dropInFlutterApi.onDropInPlatformCommunication(platformCommunicationModel) {}
        }
    }

    private fun setOrderCancelPlatformMessengerObserver() {
        DropInOrderCancelPlatformMessenger.instance().removeObservers(activity)
        DropInOrderCancelPlatformMessenger.instance().observe(activity) { message ->
            if (message.hasBeenHandled()) {
                return@observe
            }

            val platformCommunicationModel =
                PlatformCommunicationModel(
                    PlatformCommunicationType.CANCEL_ORDER,
                    data = message.contentIfNotHandled.toString()
                )
            dropInFlutterApi.onDropInPlatformCommunication(platformCommunicationModel) {}
        }
    }

    private fun createCheckoutSession(
        sessionHolder: SessionHolder,
        environment: com.adyen.checkout.core.Environment,
        clientKey: String,
    ): CheckoutSession {
        val sessionSetupResponse = SessionSetupResponse.SERIALIZER.deserialize(sessionHolder.sessionSetupResponse)
        val order = sessionHolder.orderResponse?.let { Order.SERIALIZER.deserialize(it) }
        return CheckoutSession(
            sessionSetupResponse = sessionSetupResponse,
            order = order,
            environment = environment,
            clientKey = clientKey
        )
    }

    private fun removeGiftCardPaymentMethods(
        paymentMethodsResponse: PaymentMethodsApiResponse,
        isPartialPaymentSupported: Boolean
    ): PaymentMethodsApiResponse {
        if (isPartialPaymentSupported) {
            return paymentMethodsResponse
        }

        val giftCardTypeIdentifier = "giftcard"
        val storedPaymentMethods =
            paymentMethodsResponse.storedPaymentMethods?.filterNot { it.type == giftCardTypeIdentifier }
        val paymentMethods = paymentMethodsResponse.paymentMethods?.filterNot { it.type == giftCardTypeIdentifier }

        return PaymentMethodsApiResponse(
            storedPaymentMethods = storedPaymentMethods,
            paymentMethods = paymentMethods
        )
    }

    val sessionDropInCallback =
        SessionDropInCallback { sessionDropInResult ->
            if (sessionDropInResult == null) {
                return@SessionDropInCallback
            }

            val mappedResult =
                when (sessionDropInResult) {
                    is SessionDropInResult.CancelledByUser ->
                        PaymentResultDTO(
                            PaymentResultEnum.CANCELLED_BY_USER
                        )

                    is SessionDropInResult.Error ->
                        PaymentResultDTO(
                            PaymentResultEnum.ERROR,
                            reason = sessionDropInResult.reason
                        )

                    is SessionDropInResult.Finished ->
                        PaymentResultDTO(
                            PaymentResultEnum.FINISHED,
                            result =
                                with(sessionDropInResult.result) {
                                    PaymentResultModelDTO(
                                        sessionId,
                                        sessionData,
                                        sessionResult,
                                        resultCode,
                                        order?.mapToOrderResponseModel()
                                    )
                                }
                        )
                }

            val platformCommunicationModel =
                PlatformCommunicationModel(
                    PlatformCommunicationType.RESULT,
                    data = "",
                    paymentResult = mappedResult
                )

            dropInFlutterApi.onDropInPlatformCommunication(platformCommunicationModel) {}
        }

    val dropInAdvancedFlowCallback =
        DropInCallback { dropInAdvancedFlowResult ->
            if (dropInAdvancedFlowResult == null) {
                return@DropInCallback
            }

            val mappedResult =
                when (dropInAdvancedFlowResult) {
                    is DropInResult.CancelledByUser ->
                        PaymentResultDTO(
                            PaymentResultEnum.CANCELLED_BY_USER
                        )

                    is DropInResult.Error ->
                        PaymentResultDTO(
                            PaymentResultEnum.ERROR,
                            reason = dropInAdvancedFlowResult.reason
                        )

                    is DropInResult.Finished ->
                        PaymentResultDTO(
                            PaymentResultEnum.FINISHED,
                            result =
                                PaymentResultModelDTO(
                                    resultCode = dropInAdvancedFlowResult.result
                                )
                        )
                }

            val platformCommunicationModel =
                PlatformCommunicationModel(
                    PlatformCommunicationType.RESULT,
                    data = "",
                    paymentResult = mappedResult
                )
            dropInFlutterApi.onDropInPlatformCommunication(platformCommunicationModel) {}
        }
}
