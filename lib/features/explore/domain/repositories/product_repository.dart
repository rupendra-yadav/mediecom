import 'package:dartz/dartz.dart';
import 'package:mediecom/core/common/error/app_failures.dart';
import 'package:mediecom/features/explore/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? categoryId,
  });
}
