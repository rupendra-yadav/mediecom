import 'package:get_it/get_it.dart';
import 'package:mediecom/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:mediecom/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:mediecom/features/auth/domain/repositories/auth_repo.dart';
import 'package:mediecom/features/auth/domain/use_cases/login_usecase.dart';
import 'package:mediecom/features/auth/domain/use_cases/send_otp_usecase.dart';
import 'package:mediecom/features/auth/domain/use_cases/verify_otp_usecase.dart';
import 'package:mediecom/features/auth/presentation/bloc/send_otp/send_otp_bloc.dart';
import 'package:mediecom/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:mediecom/features/auth/presentation/bloc/verify_otp/verify_otp_bloc.dart';

final sl = GetIt.instance;

void initAuth() {
  /// Auth Use Cases Injection

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<SendOtpUseCase>(
    () => SendOtpUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(repository: sl.call()),
  );

  /// Auth Repository Injection
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl.call()),
  );

  /// Auth Data sources Injection
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl.call()),
  );

  /// Auth  Bloc Injection
  sl.registerFactory(() => SignInBloc(loginUseCase: sl()));

  sl.registerFactory(() => SendOtpBloc(sendOtpUseCase: sl()));

  sl.registerFactory(() => VerifyOtpBloc(verifyOtpUseCase: sl()));
}
