import 'package:mediecom/features/orders/domain/entities/order_details_entity.dart';

class OrderDetailsModel extends OrderDetailsEntity {
  const OrderDetailsModel({
    super.orderId,
    super.productId,
    super.productName,
    super.quantity,
    super.price,
    super.total,
    super.status,
    super.orderDate,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      orderId: json['order_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      price: json['price'],
      total: json['total'],
      status: json['status'],
      orderDate: json['order_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'price': price,
      'total': total,
      'status': status,
      'order_date': orderDate,
    };
  }
}
