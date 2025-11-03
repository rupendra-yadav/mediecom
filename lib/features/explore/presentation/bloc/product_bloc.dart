import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediecom/features/explore/domain/usecases/get_products_usecase.dart';
import 'package:mediecom/features/explore/domain/entities/product_entity.dart';

// Events
abstract class ProductEvent {}

class FetchProducts extends ProductEvent {
  final String? categoryId;
  FetchProducts({this.categoryId});
}

// States
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  ProductLoaded({required this.products});
}

class ProductFailure extends ProductState {
  final String message;
  ProductFailure({required this.message});
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc({required this.getProductsUseCase}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProductsUseCase.call(categoryId: event.categoryId);
    result.fold(
      (failure) => emit(ProductFailure(message: failure.message)),
      (products) => emit(ProductLoaded(products: products)),
    );
  }
}
