import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mediecom/core/common/app/cache_helper.dart';
import 'package:mediecom/features/auth/presentation/auth_injection.dart';
import 'package:mediecom/features/master/presentation/master_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton(() => prefs)
    ..registerLazySingleton(() => http.Client())
    // ..registerLazySingleton(() => InAppReview.instance)
    ..registerLazySingleton(() => CacheHelper(sl()));

  // /// Firebase and Notification Services
  // sl.registerLazySingleton(() => FirebaseMessaging.instance);
  // sl.registerLazySingleton(() => PushNotificationService(sl()));

  /// Initialize each feature's injection
  initAuth();
  initMaster();
  // initProfile();
  // initExplore();
  // initVendors();
  // initBooking();
  // initWishlist();
  // initPG();
}
