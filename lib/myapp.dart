import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediecom/core/services/routes/app_router.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/features/auth/presentation/auth_injection.dart';
import 'package:mediecom/features/auth/presentation/bloc/send_otp/send_otp_bloc.dart';
import 'package:mediecom/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:mediecom/features/auth/presentation/bloc/verify_otp/verify_otp_bloc.dart';
import 'package:mediecom/features/master/presentation/blocs/banner/banner_bloc.dart';
import 'package:mediecom/features/master/presentation/blocs/category/category_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      child: MultiBlocProvider(
        providers: [
          ///Auth
          BlocProvider(create: (context) => sl<SignInBloc>()),
          BlocProvider(create: (context) => sl<SendOtpBloc>()),
          BlocProvider(create: (context) => sl<VerifyOtpBloc>()),

          /// BANNERS/SLIDERS
          BlocProvider(create: (context) => sl<BannerBloc>()),

          ///CATEGORIES
          BlocProvider(create: (context) => sl<CategoryBloc>()),
        ],
        child: SafeArea(
          bottom: true,
          top: false,
          left: false,
          right: false,
          child: MaterialApp.router(
            title: 'Mediecom',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colours.white,
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
      ),
    );
  }
}
