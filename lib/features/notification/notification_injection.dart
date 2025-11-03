import 'package:get_it/get_it.dart';
import 'package:mediecom/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mediecom/features/user/domain/repositories/user_repository.dart';

final sl = GetIt.instance;

void initNotification() {
  // Bloc
  sl.registerFactory(() => NotificationBloc(repository: sl<UserRepository>()));
}
