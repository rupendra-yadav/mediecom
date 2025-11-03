import 'package:get_it/get_it.dart';
import 'package:mediecom/features/explore/data/data_sources/product_remote_data_source.dart';
import 'package:mediecom/features/explore/data/repositories_impl/product_repository_impl.dart';
import 'package:mediecom/features/explore/domain/repositories/product_repository.dart';
import 'package:mediecom/features/explore/domain/usecases/get_products_usecase.dart';
import 'package:mediecom/features/explore/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

void initExplore() {
  // Use cases
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );

  // Bloc
  sl.registerFactory(() => ProductBloc(getProductsUseCase: sl()));
}
