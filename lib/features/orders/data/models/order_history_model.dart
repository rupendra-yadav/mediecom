import 'package:mediecom/features/orders/domain/entities/order_history_entity.dart';

class OrderHistoryModel extends OrderHistoryEntity {
  const OrderHistoryModel({
    super.orderId,
    super.status,
    super.date,
    super.remarks,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      orderId: json['order_id'],
      status: json['status'],
      date: json['date'],
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'status': status,
      'date': date,
      'remarks': remarks,
    };
  }
}
