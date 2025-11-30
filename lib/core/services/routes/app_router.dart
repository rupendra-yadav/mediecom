import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediecom/core/services/routes/arguments/product_details.dart';
import 'package:mediecom/features/auth/presentation/pages/onboarding_page.dart';
import 'package:mediecom/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:mediecom/features/auth/presentation/pages/phone_number.dart';
import 'package:mediecom/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mediecom/features/auth/presentation/pages/splash_screen.dart';
import 'package:mediecom/features/bottom_navigation/presentation/bottom_navigation_bar.dart';
import 'package:mediecom/features/cart/presentation/pages/cart.dart';
import 'package:mediecom/features/cart/presentation/pages/check_out_page.dart';
import 'package:mediecom/features/cart/presentation/pages/order_confirmation_page.dart';
import 'package:mediecom/features/explore/presentation/pages/add_prescriptions_page.dart';
import 'package:mediecom/features/explore/presentation/pages/home_screen.dart';
import 'package:mediecom/features/explore/presentation/pages/process_request_page.dart';
import 'package:mediecom/features/explore/presentation/pages/product_details.dart';
import 'package:mediecom/features/master/presentation/pages/subcategory_page.dart';
import 'package:mediecom/features/notification/presentation/pages/notification.dart';
import 'package:mediecom/features/orders/domain/entities/order_entity.dart';
import 'package:mediecom/features/orders/presentation/pages/orders.dart';
import 'package:mediecom/features/orders/presentation/pages/orders_detail.dart';
import 'package:mediecom/features/user/presentation/pages/profile.dart';
import 'package:mediecom/features/user/presentation/pages/update_profile.dart';

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
      path: OnboardingPage.path,
      pageBuilder: (context, state) =>
          buildTransitionPage(const OnboardingPage(), slideInFromRight),
    ),

    GoRoute(
      path: SignUpScreen.path,
      pageBuilder: (context, state) =>
          buildTransitionPage(const SignUpScreen(), slideInFromRight),
    ),

    GoRoute(
      path: PhoneNumberPage.path,
      pageBuilder: (context, state) =>
          buildTransitionPage(const PhoneNumberPage(), slideInFromRight),
    ),

    GoRoute(
      path: UpdateProfileScreen.path,
      pageBuilder: (context, state) =>
          buildTransitionPage(const UpdateProfileScreen(), slideInFromRight),
    ),

    GoRoute(
      path: PaymentMethodPage.path,
      pageBuilder: (context, state) =>
          buildTransitionPage(const PaymentMethodPage(), slideUpFromBottom),
    ),

    GoRoute(
      path: OrderConfirmationPage.path,
      pageBuilder: (context, state) =>
          buildTransitionPage(const OrderConfirmationPage(), slideUpFromBottom),
    ),

    GoRoute(
      path: NotificationPage.path,
      pageBuilder: (context, state) =>
          buildTransitionPage(const NotificationPage(), slideInFromRight),
    ),

    GoRoute(
      path: OrderTrackingPage.path,
      pageBuilder: (context, state) {
        final OrderEntity order = state.extra as OrderEntity;
        return buildTransitionPage(
          OrderTrackingPage(order: order),
          slideInFromRight,
        );
      },
    ),

    GoRoute(
      path: OtpVerificationPage.path,
      pageBuilder: (context, state) {
        final phone = state.extra as String;
        return buildTransitionPage(
          OtpVerificationPage(phoneNumber: phone),
          slideInFromRight,
        );
      },
    ),

    GoRoute(
      path: ProductDetailPage.path,
      pageBuilder: (context, state) {
        final args = state.extra as ProductDetailsArgs;
        return buildTransitionPage(
          ProductDetailPage(tag: args.tag, data: args.cate),
          slideInFromRight,
        );
      },
    ),

    GoRoute(
      path: SubcategoryPage.path,
      pageBuilder: (context, state) =>
          buildTransitionPage(const SubcategoryPage(), slideInFromRight),
    ),

    GoRoute(
      path: UploadPrescriptionPage.path,
      pageBuilder: (context, state) => buildTransitionPage(
        const UploadPrescriptionPage(),
        slideUpFromBottom,
      ),
    ),

    GoRoute(
      path: ProcessRequestPage.path,
      pageBuilder: (context, state) =>
          buildTransitionPage(const ProcessRequestPage(), slideInFromRight),
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
