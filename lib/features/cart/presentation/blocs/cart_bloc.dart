import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediecom/features/cart/presentation/blocs/cart_event.dart';
import 'package:mediecom/features/cart/presentation/blocs/cart_state.dart';
import 'package:mediecom/features/explore/domain/entities/product_entity.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>((event, emit) {
      final updatedItems = List<ProductEntity>.from(state.items)
        ..add(event.item);
      emit(state.copyWith(items: updatedItems));
    });

    on<RemoveFromCart>((event, emit) {
      final updatedItems = state.items
          .where((item) => item.M1_CODE != event.productCode)
          .toList();
      emit(state.copyWith(items: updatedItems));
    });

    on<ClearCart>((event, emit) {
      emit(state.copyWith(items: []));
    });
  }
}
