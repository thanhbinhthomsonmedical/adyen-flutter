import Foundation
@_spi(AdyenInternal) import Adyen
import AdyenNetworking

class DropInPlatformApi: DropInPlatformInterface {
    private let jsonDecoder = JSONDecoder()
    private let dropInFlutterApi: DropInFlutterInterface
    private let sessionHolder: SessionHolder
    private var hostViewController: UIViewController?
    private var dropInViewController: DropInViewController?
    private var dropInSessionStoredPaymentMethodsDelegate: DropInSessionsStoredPaymentMethodsDelegate?
    private var dropInAdvancedFlowDelegate: DropInAdvancedFlowDelegate?
    private var dropInAdvancedFlowStoredPaymentMethodsDelegate: DropInAdvancedFlowStoredPaymentMethodsDelegate?
    private var checkBalanceHandler: ((Result<Balance, any Error>) -> Void)?
    private var requestOrderHandler: ((Result<PartialPaymentOrder, any Error>) -> Void)?

    init(
        dropInFlutterApi: DropInFlutterInterface,
        sessionHolder: SessionHolder
    ) {
        self.dropInFlutterApi = dropInFlutterApi
        self.sessionHolder = sessionHolder
    }

    func showDropInSession(dropInConfigurationDTO: DropInConfigurationDTO) {
        do {
            guard let viewController = getViewController() else {
                return
            }
            
            guard let session = sessionHolder.session else {
                sendSessionError(error: PlatformError(errorDescription: "Session is not available."))
                return
            }

            hostViewController = viewController
            let adyenContext = try dropInConfigurationDTO.createAdyenContext()
            dropInSessionStoredPaymentMethodsDelegate = DropInSessionsStoredPaymentMethodsDelegate(
                viewController: viewController,
                dropInFlutterApi: dropInFlutterApi
            )
            let payment = session.sessionContext.payment ?? adyenContext.payment
            let dropInConfiguration = try dropInConfigurationDTO.createDropInConfiguration(payment: payment)
            var paymentMethods = session.sessionContext.paymentMethods
            if let paymentMethodNames = dropInConfigurationDTO.paymentMethodNames {
                paymentMethods = overridePaymentMethodNames(
                    paymentMethods: paymentMethods,
                    paymentMethodNames: paymentMethodNames
                )
            }
            
            let dropInComponent = DropInComponent(
                paymentMethods: paymentMethods,
                context: adyenContext,
                configuration: dropInConfiguration,
                title: dropInConfigurationDTO.preselectedPaymentMethodTitle
            )
            dropInComponent.delegate = sessionHolder.session
            dropInComponent.partialPaymentDelegate = sessionHolder.session
            if dropInConfigurationDTO.isRemoveStoredPaymentMethodEnabled {
                dropInComponent.storedPaymentMethodsDelegate = dropInSessionStoredPaymentMethodsDelegate
            }
            
            let dropInViewController = DropInViewController(dropInComponent: dropInComponent)
            dropInViewController.modalPresentationStyle = .overCurrentContext
            self.dropInViewController = dropInViewController
            self.hostViewController?.present(dropInViewController, animated: false)
        } catch {
            sendSessionError(error: error)
        }
    }

    func showDropInAdvanced(dropInConfigurationDTO: DropInConfigurationDTO, paymentMethodsResponse: String) {
        do {
            guard let viewController = getViewController() else {
                return
            }
            
            hostViewController = viewController
            let adyenContext = try dropInConfigurationDTO.createAdyenContext()
            var paymentMethods = try jsonDecoder.decode(PaymentMethods.self, from: Data(paymentMethodsResponse.utf8))
            if let paymentMethodNames = dropInConfigurationDTO.paymentMethodNames {
                paymentMethods = overridePaymentMethodNames(
                    paymentMethods: paymentMethods,
                    paymentMethodNames: paymentMethodNames
                )
            }
            
            let paymentMethodsWithoutGiftCards = removeGiftCardPaymentMethods(paymentMethods: paymentMethods, isPartialPaymentSupported: dropInConfigurationDTO.isPartialPaymentSupported)
            let configuration = try dropInConfigurationDTO.createDropInConfiguration(payment: adyenContext.payment)
            let dropInComponent = DropInComponent(
                paymentMethods: paymentMethodsWithoutGiftCards,
                context: adyenContext,
                configuration: configuration,
                title: dropInConfigurationDTO.preselectedPaymentMethodTitle
            )
            dropInAdvancedFlowDelegate = DropInAdvancedFlowDelegate(dropInFlutterApi: dropInFlutterApi)
            dropInAdvancedFlowDelegate?.dropInInteractorDelegate = self
            dropInComponent.delegate = dropInAdvancedFlowDelegate
            if dropInConfigurationDTO.isPartialPaymentSupported {
                dropInComponent.partialPaymentDelegate = self
            }
            if dropInConfigurationDTO.isRemoveStoredPaymentMethodEnabled == true {
                dropInAdvancedFlowStoredPaymentMethodsDelegate = DropInAdvancedFlowStoredPaymentMethodsDelegate(
                    viewController: viewController,
                    dropInFlutterApi: dropInFlutterApi
                )
                dropInComponent.storedPaymentMethodsDelegate = dropInAdvancedFlowStoredPaymentMethodsDelegate
            }
            let dropInViewController = DropInViewController(dropInComponent: dropInComponent)
            dropInViewController.modalPresentationStyle = .overCurrentContext
            self.dropInViewController = dropInViewController
            self.hostViewController?.present(dropInViewController, animated: false)
        } catch {
            let platformCommunicationModel = PlatformCommunicationModel(
                type: PlatformCommunicationType.result,
                paymentResult: PaymentResultDTO(type: PaymentResultEnum.error, reason: error.localizedDescription)
            )
            dropInFlutterApi.onDropInAdvancedPlatformCommunication(
                platformCommunicationModel: platformCommunicationModel,
                completion: { _ in }
            )
        }
    }

    func onPaymentsResult(paymentsResult: PaymentEventDTO) {
        handlePaymentEvent(paymentEventDTO: paymentsResult)
    }

    func onPaymentsDetailsResult(paymentsDetailsResult: PaymentEventDTO) {
        handlePaymentEvent(paymentEventDTO: paymentsDetailsResult)
    }

    func onDeleteStoredPaymentMethodResult(deleteStoredPaymentMethodResultDTO: DeletedStoredPaymentMethodResultDTO) {
        dropInSessionStoredPaymentMethodsDelegate?.handleDisableResult(
            isSuccessfullyRemoved: deleteStoredPaymentMethodResultDTO.isSuccessfullyRemoved)
        dropInAdvancedFlowStoredPaymentMethodsDelegate?.handleDisableResult(
            isSuccessfullyRemoved: deleteStoredPaymentMethodResultDTO.isSuccessfullyRemoved)
    }
    
    func onBalanceCheckResult(balanceCheckResponse: String) throws {
        guard let checkBalanceHandler else { return }
        
        do {
            guard let balanceCheckData = balanceCheckResponse.data(using: .utf8) else { throw PlatformError(errorDescription: "Failure parsing balance check response.") }
            let balance = try jsonDecoder.decode(Balance.self, from: balanceCheckData)
            checkBalanceHandler(.success(balance))
        } catch {
            checkBalanceHandler(.failure(error))
        }
    }
    
    func onOrderRequestResult(orderRequestResponse: String) throws {
        guard let requestOrderHandler else { return }
        
        do {
            guard let orderRequestData = orderRequestResponse.data(using: .utf8) else { throw PlatformError(errorDescription: "Failure parsing order request response.") }
            let partialPaymentOrder = try jsonDecoder.decode(PartialPaymentOrder.self, from: orderRequestData)
            requestOrderHandler(.success(partialPaymentOrder))
        } catch {
            requestOrderHandler(.failure(error))
        }
    }
    
    func onOrderCancelResult(orderCancelResult: OrderCancelResultDTO) throws {}

    func cleanUpDropIn() {
        sessionHolder.reset()
        dropInSessionStoredPaymentMethodsDelegate = nil
        dropInAdvancedFlowDelegate?.dropInInteractorDelegate = nil
        dropInAdvancedFlowDelegate = nil
        dropInAdvancedFlowStoredPaymentMethodsDelegate = nil
        checkBalanceHandler = nil
        requestOrderHandler = nil
        dropInViewController = nil
        hostViewController = nil
    }

    private func handlePaymentEvent(paymentEventDTO: PaymentEventDTO) {
        switch paymentEventDTO.paymentEventType {
        case .finished:
            onDropInResultFinished(paymentEventDTO: paymentEventDTO)
        case .action:
            onDropInResultAction(paymentEventDTO: paymentEventDTO)
        case .error:
            onDropInResultError(paymentEventDTO: paymentEventDTO)
        case .update:
            onDropInResultUpdate(paymentEventDTO: paymentEventDTO)
        }
    }

    private func onDropInResultFinished(paymentEventDTO: PaymentEventDTO) {
        let resultCode = ResultCode(rawValue: paymentEventDTO.result ?? "")
        let isAccepted = resultCode?.isAccepted ?? false
        finalizeAndDismiss(success: isAccepted, completion: { [weak self] in
            let paymentResult = PaymentResultDTO(
                type: PaymentResultEnum.finished,
                result: PaymentResultModelDTO(
                    resultCode: resultCode?.rawValue)
            )
            self?.dropInFlutterApi.onDropInAdvancedPlatformCommunication(
                platformCommunicationModel: PlatformCommunicationModel(
                    type: PlatformCommunicationType.result,
                    paymentResult: paymentResult
                ),
                completion: { _ in }
            )
        })
    }

    private func onDropInResultAction(paymentEventDTO: PaymentEventDTO) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: paymentEventDTO.data as Any, options: [])
            let result = try JSONDecoder().decode(Action.self, from: jsonData)
            dropInViewController?.dropInComponent.handle(result)
        } catch {
            let paymentResult = PaymentResultDTO(type: PaymentResultEnum.error, reason: error.localizedDescription)
            dropInFlutterApi.onDropInAdvancedPlatformCommunication(
                platformCommunicationModel: PlatformCommunicationModel(
                    type: PlatformCommunicationType.result,
                    paymentResult: paymentResult
                ),
                completion: { _ in }
            )
            finalizeAndDismiss(success: false) {}
        }
    }

    private func onDropInResultError(paymentEventDTO: PaymentEventDTO) {
        dropInViewController?.dropInComponent.stopLoading()

        if paymentEventDTO.error?.dismissDropIn == true || dropInAdvancedFlowDelegate?.isApplePay == true {
            finalizeAndDismiss(success: false) { [weak self] in
                let paymentResult = PaymentResultDTO(type: PaymentResultEnum.error, reason: paymentEventDTO.error?.errorMessage)
                self?.dropInFlutterApi.onDropInAdvancedPlatformCommunication(
                    platformCommunicationModel: PlatformCommunicationModel(
                        type: PlatformCommunicationType.result,
                        paymentResult: paymentResult
                    ),
                    completion: { _ in }
                )
            }
        } else {
            dropInViewController?.dropInComponent.finalizeIfNeeded(with: false, completion: {})
            let localizationParameters = (dropInViewController?.dropInComponent as? Localizable)?.localizationParameters
            let title = localizedString(.errorTitle, localizationParameters)
            let alertController = UIAlertController(
                title: title,
                message: paymentEventDTO.error?.errorMessage,
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(
                title: localizedString(.dismissButton, localizationParameters),
                style: .cancel
            ))
            hostViewController?.adyen.topPresenter.present(alertController, animated: true)
        }
    }
    
    private func onDropInResultUpdate(paymentEventDTO: PaymentEventDTO) {
        do {
            guard let updatedPaymentMethods = paymentEventDTO.data?[Constants.updatedPaymentMethodsKey] ?? "" else {
                throw PlatformError(errorDescription: "Updated payment methods not provided.")
            }
            
            guard let orderResponse = paymentEventDTO.data?[Constants.orderKey] ?? "" else {
                throw PlatformError(errorDescription: "Order not provided.")
            }
            
            let updatedPaymentMethodsData = try JSONSerialization.data(withJSONObject: updatedPaymentMethods, options: [])
            let paymentMethods = try jsonDecoder.decode(PaymentMethods.self, from: updatedPaymentMethodsData)
            let orderData = try JSONSerialization.data(withJSONObject: orderResponse, options: [])
            let order = try jsonDecoder.decode(PartialPaymentOrder.self, from: orderData)
            try dropInViewController?.dropInComponent.reload(with: order, paymentMethods)
        } catch {
            adyenPrint(error.localizedDescription)
        }
    }

    private func removeGiftCardPaymentMethods(paymentMethods: PaymentMethods, isPartialPaymentSupported: Bool) -> PaymentMethods {
        if isPartialPaymentSupported {
            return paymentMethods
        }
        
        let storedPaymentMethods = paymentMethods.stored.filter { !($0.type == PaymentMethodType.giftcard) }
        let paymentMethods = paymentMethods.regular.filter { !($0.type == PaymentMethodType.giftcard) }
        return PaymentMethods(regular: paymentMethods, stored: storedPaymentMethods)
    }

    private func sendSessionError(error: Error) {
        let platformCommunicationModel = PlatformCommunicationModel(
            type: PlatformCommunicationType.result,
            paymentResult: PaymentResultDTO(
                type: PaymentResultEnum.error,
                reason: error.localizedDescription
            )
        )
        dropInFlutterApi.onDropInSessionPlatformCommunication(
            platformCommunicationModel: platformCommunicationModel,
            completion: { _ in }
        )
    }

    private func getViewController() -> UIViewController? {
        var rootViewController = UIApplication.shared.adyen.mainKeyWindow?.rootViewController
        while let presentedViewController = rootViewController?.presentedViewController {
            let type = String(describing: type(of: presentedViewController))
            // TODO: - We need to discuss how the SDK should react if a DropInNavigationController is already displayed
            if type == "DropInNavigationController" {
                return nil
            } else {
                rootViewController = presentedViewController
            }
        }

        return rootViewController
    }
    
    private func overridePaymentMethodNames(paymentMethods: PaymentMethods, paymentMethodNames: [String?: String?]) -> PaymentMethods {
        var paymentMethodsWithAdjustedNames = paymentMethods
        for paymentMethodNamePair in paymentMethodNames {
            if let paymentMethodRawValue = paymentMethodNamePair.key,
               let paymentMethodType = PaymentMethodType(rawValue: paymentMethodRawValue),
               let paymentMethodName = paymentMethodNamePair.value {
                paymentMethodsWithAdjustedNames.overrideDisplayInformation(
                    ofRegularPaymentMethod: paymentMethodType,
                    with: .init(title: paymentMethodName)
                )
            }
        }
        
        return paymentMethodsWithAdjustedNames
    }
}

extension DropInPlatformApi: DropInInteractorDelegate {
    func finalizeAndDismiss(success: Bool, completion: @escaping (() -> Void)) {
        dropInViewController?.dropInComponent.finalizeIfNeeded(with: success) { [weak self] in
            self?.hostViewController?.dismiss(animated: true, completion: {
                completion()
            })
        }
    }
}

extension DropInPlatformApi: PartialPaymentDelegate {
    func checkBalance(with data: Adyen.PaymentComponentData, component: any Adyen.Component, completion: @escaping (Result<Adyen.Balance, any Error>) -> Void) {
        do {
            checkBalanceHandler = completion
            let platformCommunicationModel = try PlatformCommunicationModel(
                type: PlatformCommunicationType.balanceCheck,
                data: data.jsonObject.toJsonStringRepresentation()
            )
            dropInFlutterApi.onDropInAdvancedPlatformCommunication(platformCommunicationModel: platformCommunicationModel, completion: { _ in })
        } catch {
            completion(.failure(error))
        }
    }
    
    func requestOrder(for component: any Adyen.Component, completion: @escaping (Result<Adyen.PartialPaymentOrder, any Error>) -> Void) {
        requestOrderHandler = completion
        let platformCommunicationModel = PlatformCommunicationModel(type: PlatformCommunicationType.requestOrder)
        dropInFlutterApi.onDropInAdvancedPlatformCommunication(platformCommunicationModel: platformCommunicationModel, completion: { _ in })
    }
    
    func cancelOrder(_ order: Adyen.PartialPaymentOrder, component: any Adyen.Component) {
        do {
            let cancelOrderData: [String: Any] = [
                Constants.orderKey: order.jsonObject,
                Constants.shouldUpdatePaymentMethodsKey: false
            ]
            let data = try JSONSerialization.data(withJSONObject: cancelOrderData, options: [])
            let cancelOrderDataString = String(data: data, encoding: .utf8)
            let platformCommunicationModel = PlatformCommunicationModel(type: PlatformCommunicationType.cancelOrder, data: cancelOrderDataString)
            dropInFlutterApi.onDropInAdvancedPlatformCommunication(platformCommunicationModel: platformCommunicationModel, completion: { _ in })
        } catch {
            adyenPrint(error.localizedDescription)
        }
    }

}
