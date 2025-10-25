import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediecom/features/auth/presentation/pages/phone_number_login.dart';
import 'package:mediecom/features/auth/presentation/pages/splash_screen.dart';
import 'package:mediecom/features/bottom_navigation/presentation/bottom_navigation_bar.dart';
import 'package:mediecom/features/cart/presentation/pages/cart.dart';
import 'package:mediecom/features/explore/presentation/pages/home_screen.dart';
import 'package:mediecom/features/explore/presentation/pages/product_details.dart';
import 'package:mediecom/features/orders/presentation/pages/orders.dart';
import 'package:mediecom/features/user/presentation/pages/profile.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

const Duration transitionDuration = Duration(milliseconds: 600);
const Offset slideInFromRight = Offset(1.0, 0.0);
const Offset slideUpFromBottom = Offset(0.0, 1.0);
const Curve transitionCurve = Curves.easeInOut;

CustomTransitionPage buildTransitionPage(Widget child, Offset begin) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: transitionDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(
        begin: begin,
        end: Offset.zero,
      ).chain(CurveTween(curve: transitionCurve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          buildTransitionPage(const SplashScreen(), slideInFromRight),
    ),
    GoRoute(
      path: PhoneOtpLoginPage.path,
      pageBuilder: (context, state) =>
          buildTransitionPage(const PhoneOtpLoginPage(), slideInFromRight),
    ),

    /// Bottom Navigation Routes
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return NavigationScreen(child: child);
      },
      routes: [
        GoRoute(
          path: HomeScreen.path,
          pageBuilder: (context, state) =>
              buildTransitionPage(const HomeScreen(), slideInFromRight),
        ),
        GoRoute(
          path: Cart.path,
          pageBuilder: (context, state) {
            return buildTransitionPage(const Cart(), slideInFromRight);
          },
        ),
        GoRoute(
          path: Orders.path,
          pageBuilder: (context, state) =>
              buildTransitionPage(const Orders(), slideInFromRight),
        ),
        // GoRoute(
        //   path: OfferScreen.path,
        //   pageBuilder: (context, state) =>
        //       buildTransitionPage(const OfferScreen(), slideInFromRight),
        // ),
        GoRoute(
          path: ProfilePage.path,
          pageBuilder: (context, state) =>
              buildTransitionPage(const ProfilePage(), slideInFromRight),
        ),
      ],
    ),

    // // observers: [NavigatorObserverWithAds()],
    // observers: [
    //   FirebaseService().analyticsObserver, // Add Analytics observer here
  ],
);
