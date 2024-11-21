import 'package:adyen_checkout/src/common/model/partial_payment/order_cancel_result.dart';

class PartialPayment {
  Future<Map<String, dynamic>> Function(Map<String, dynamic> requestBody)
      onCheckBalance;
  Future<Map<String, dynamic>> Function() onRequestOrder;
  Future<OrderCancelResult> Function(
    bool shouldUpdatePaymentMethods,
    Map<String, dynamic> order,
  ) onCancelOrder;

  PartialPayment({
    required this.onCheckBalance,
    required this.onRequestOrder,
    required this.onCancelOrder,
  });
}
