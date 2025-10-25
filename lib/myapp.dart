import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediecom/core/services/routes/app_router.dart';
import 'package:mediecom/core/style/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      child: SafeArea(
        bottom: true,
        top: false,
        left: false,
        right: false,
        child: MaterialApp.router(
          title: 'Skill Links',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colours.white,
            fontFamily: 'Urbanist',
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colours.secondaryColor,
            ),
            useMaterial3: true,
          ),

          builder: (context, child) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colours.primaryColor,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
              child: child ?? const SizedBox(),
            );
          },

          // home: NavigationScreen(),
          routerConfig: router,
        ),
      ),
    );
  }
}
