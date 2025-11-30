import 'package:equatable/equatable.dart';
import 'package:mediecom/features/explore/domain/entities/product_entity.dart';

class ProductDetailsArgs extends Equatable {
  final String tag;
  final ProductEntity cate;

  ProductDetailsArgs({required this.cate, required this.tag});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
