import 'package:equatable/equatable.dart';

class OrderHistoryEntity extends Equatable {
  final String? orderId;
  final String? status;
  final String? date;
  final String? remarks;

  const OrderHistoryEntity({
    this.orderId,
    this.status,
    this.date,
    this.remarks,
  });

  @override
  List<Object?> get props => [orderId, status, date, remarks];
}
