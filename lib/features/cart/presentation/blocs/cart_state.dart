import 'package:mediecom/features/explore/domain/entities/product_entity.dart';

class CartState {
  final List<ProductEntity> items;

  const CartState({this.items = const []});

  CartState copyWith({List<ProductEntity>? items}) {
    return CartState(items: items ?? this.items);
  }
}
