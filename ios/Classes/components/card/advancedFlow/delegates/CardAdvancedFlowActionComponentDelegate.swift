import Adyen

class CardAdvancedFlowActionComponentDelegate: ActionComponentDelegate {
    private let componentFlutterApi: ComponentFlutterApi

    init(componentFlutterApi: ComponentFlutterApi) {
        self.componentFlutterApi = componentFlutterApi
    }

    func didProvide(_ data: Adyen.ActionComponentData, from _: Adyen.ActionComponent) {
        do {
            let actionComponentData = ActionComponentDataModel(details: data.details.encodable, paymentData: data.paymentData)
            let actionComponentDataJson = try JSONEncoder().encode(actionComponentData)
            let actionComponentDataString = String(data: actionComponentDataJson, encoding: .utf8)
            componentFlutterApi.onComponentCommunication(componentCommunicationModel: ComponentCommunicationModel(type: ComponentCommunicationType.additionalDetails, data: actionComponentDataString), completion: { _ in })
        } catch {
            sendErrorToFlutterLayer(error: error)
        }
    }

    func didComplete(from _: Adyen.ActionComponent) {
        print("did complete")
        // TODO: Could we discuss when this callback is being triggered and needs to be handled?
    }

    func didFail(with error: Error, from _: Adyen.ActionComponent) {
        sendErrorToFlutterLayer(error: error)
    }

    private func sendErrorToFlutterLayer(error: Error) {
        let componentCommunicationModel = ComponentCommunicationModel(type: ComponentCommunicationType.error, data: error.localizedDescription)
        componentFlutterApi.onComponentCommunication(componentCommunicationModel: componentCommunicationModel, completion: { _ in })
    }
}
