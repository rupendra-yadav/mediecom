import 'package:flutter/material.dart';
import 'package:mediecom/injection_container.dart';
import 'package:mediecom/myapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // await NotificationService().initialize();
  await init();
  runApp(MyApp());
}
