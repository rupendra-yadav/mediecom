import 'package:equatable/equatable.dart';

class OrderDetailsEntity extends Equatable {
  final String? orderId;
  final String? productId;
  final String? productName;
  final String? quantity;
  final String? price;
  final String? total;
  final String? status;
  final String? orderDate;

  const OrderDetailsEntity({
    this.orderId,
    this.productId,
    this.productName,
    this.quantity,
    this.price,
    this.total,
    this.status,
    this.orderDate,
  });

  @override
  List<Object?> get props => [
    orderId,
    productId,
    productName,
    quantity,
    price,
    total,
    status,
    orderDate,
  ];
}
