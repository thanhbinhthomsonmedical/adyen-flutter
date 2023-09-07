package com.adyen.adyen_checkout.dropInAdvancedFlow

import DropInResult
import androidx.lifecycle.LiveData
import com.adyen.adyen_checkout.utils.Event
import org.json.JSONObject

class DropInServiceResultMessenger : LiveData<Event<JSONObject>>() {
    companion object {
        private val dropInServiceResultMessenger = DropInServiceResultMessenger()
        fun instance() = dropInServiceResultMessenger
        fun sendResult(value: JSONObject) {
            dropInServiceResultMessenger.postValue(Event(value))
        }
    }
}

class DropInPaymentResultMessenger : LiveData<Event<DropInResult>>() {
    companion object {
        private val dropInPaymentResultMessenger = DropInPaymentResultMessenger()

        fun instance() = dropInPaymentResultMessenger
        fun sendResult(value: DropInResult) {
            dropInPaymentResultMessenger.postValue(Event(value))
        }
    }
}

class DropInAdditionalDetailsPlatformMessenger : LiveData<Event<JSONObject>>() {
    companion object {
        private val dropInAdditionalDetailsPlatformMessenger =
            DropInAdditionalDetailsPlatformMessenger()

        fun instance() = dropInAdditionalDetailsPlatformMessenger
        fun sendResult(value: JSONObject) {
            dropInAdditionalDetailsPlatformMessenger.postValue(Event(value))
        }
    }
}

class DropInAdditionalDetailsResultMessenger : LiveData<Event<DropInResult>>() {
    companion object {
        private val dropInAdditionalDetailsResultMessenger =
            DropInAdditionalDetailsResultMessenger()

        fun instance() = dropInAdditionalDetailsResultMessenger
        fun sendResult(value: DropInResult) {
            dropInAdditionalDetailsResultMessenger.postValue(Event(value))
        }
    }
}