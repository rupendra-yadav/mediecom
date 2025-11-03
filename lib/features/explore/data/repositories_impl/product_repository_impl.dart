import 'package:dartz/dartz.dart';
import 'package:mediecom/core/common/error/app_exceptions.dart';
import 'package:mediecom/core/common/error/app_failures.dart';
import 'package:mediecom/features/explore/data/data_sources/product_remote_data_source.dart';
import 'package:mediecom/features/explore/domain/entities/product_entity.dart';
import 'package:mediecom/features/explore/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? categoryId,
  }) async {
    try {
      final products = await remoteDataSource.getProducts(
        categoryId: categoryId,
      );
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(
        UnexpectedFailure(
          message: 'Unexpected error occurred',
          statusCode: 500,
        ),
      );
    }
  }
}
