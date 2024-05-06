package com.adyen.checkout.flutter.components.instant

import ComponentFlutterInterface
import InstantPaymentConfigurationDTO
import androidx.fragment.app.FragmentActivity
import com.adyen.checkout.components.core.CheckoutConfiguration
import com.adyen.checkout.components.core.Order
import com.adyen.checkout.components.core.PaymentMethod
import com.adyen.checkout.components.core.action.Action
import com.adyen.checkout.flutter.components.instant.advanced.InstantComponentAdvancedCallback
import com.adyen.checkout.flutter.components.instant.session.InstantComponentSessionCallback
import com.adyen.checkout.flutter.components.view.ComponentLoadingBottomSheet
import com.adyen.checkout.flutter.session.SessionHolder
import com.adyen.checkout.flutter.utils.ConfigurationMapper.mapToCheckoutConfiguration
import com.adyen.checkout.flutter.utils.Constants
import com.adyen.checkout.instant.InstantPaymentComponent
import com.adyen.checkout.sessions.core.CheckoutSession
import com.adyen.checkout.sessions.core.SessionSetupResponse
import org.json.JSONObject

class InstantComponentManager(
    private val activity: FragmentActivity,
    private val componentFlutterInterface: ComponentFlutterInterface,
    private val sessionHolder: SessionHolder,
) {
    private var instantPaymentComponent: InstantPaymentComponent? = null
    private var componentId: String? = null

    fun startInstantComponent(
        instantPaymentConfigurationDTO: InstantPaymentConfigurationDTO,
        encodedPaymentMethod: String,
        componentId: String
    ): InstantPaymentComponent {
        val paymentMethod = PaymentMethod.SERIALIZER.deserialize(JSONObject(encodedPaymentMethod))
        val configuration = instantPaymentConfigurationDTO.mapToCheckoutConfiguration()
        val instantPaymentComponent =
            when {
                componentId.contains(Constants.INSTANT_ADVANCED_COMPONENT_KEY) ->
                    createInstantAdvancedComponent(
                        configuration,
                        paymentMethod,
                        componentId
                    )

                componentId.contains(Constants.INSTANT_SESSION_COMPONENT_KEY) ->
                    createInstantSessionComponent(
                        configuration,
                        paymentMethod,
                        componentId
                    )

                else -> throw IllegalStateException("Instant component not available for payment flow.")
            }

        this.instantPaymentComponent = instantPaymentComponent
        this.componentId = componentId
        showLoadingBottomSheet(instantPaymentComponent)
        return instantPaymentComponent
    }

    fun onDispose(componentId: String) {
        if (componentId == this.componentId) {
            instantPaymentComponent = null
        }
    }

    private fun createInstantAdvancedComponent(
        configuration: CheckoutConfiguration,
        paymentMethod: PaymentMethod,
        componentId: String,
    ): InstantPaymentComponent {
        return InstantPaymentComponent.PROVIDER.get(
            activity = activity,
            paymentMethod = paymentMethod,
            checkoutConfiguration = configuration,
            callback =
                InstantComponentAdvancedCallback(
                    componentFlutterInterface,
                    componentId,
                    ::hideLoadingBottomSheet
                ),
            key = componentId
        )
    }

    private fun createInstantSessionComponent(
        configuration: CheckoutConfiguration,
        paymentMethod: PaymentMethod,
        componentId: String,
    ): InstantPaymentComponent {
        val sessionSetupResponse = SessionSetupResponse.SERIALIZER.deserialize(sessionHolder.sessionSetupResponse)
        val order = sessionHolder.orderResponse?.let { Order.SERIALIZER.deserialize(it) }
        val checkoutSession =
            CheckoutSession(
                sessionSetupResponse = sessionSetupResponse,
                order = order,
                environment = configuration.environment,
                clientKey = configuration.clientKey
            )
        return InstantPaymentComponent.PROVIDER.get(
            activity = activity,
            checkoutSession = checkoutSession,
            paymentMethod = paymentMethod,
            checkoutConfiguration = configuration,
            componentCallback =
                InstantComponentSessionCallback(
                    componentFlutterInterface,
                    componentId,
                    ::handleAction,
                    ::hideLoadingBottomSheet
                ),
            key = componentId
        )
    }

    private fun showLoadingBottomSheet(instantPaymentComponent: InstantPaymentComponent) =
        ComponentLoadingBottomSheet.show(activity.supportFragmentManager, instantPaymentComponent)

    private fun handleAction(action: Action) = instantPaymentComponent?.handleAction(action, activity)

    private fun hideLoadingBottomSheet() = ComponentLoadingBottomSheet.hide(activity.supportFragmentManager)
}
