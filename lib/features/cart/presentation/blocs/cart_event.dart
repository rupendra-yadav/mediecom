import 'package:mediecom/features/explore/domain/entities/product_entity.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final ProductEntity item;
  AddToCart({required this.item});
}

class RemoveFromCart extends CartEvent {
  final String productCode;
  RemoveFromCart({required this.productCode});
}

class ClearCart extends CartEvent {}
