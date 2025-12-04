import 'package:flutter/material.dart';
import 'package:mediecom/features/cart/data/data_sources/cart_service.dart';
import 'package:mediecom/injection_container.dart';
import 'package:mediecom/myapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // await NotificationService().initialize();

  await CartService.init();
  await CartBackupService.init();

  await init();
  runApp(MyApp());
}
