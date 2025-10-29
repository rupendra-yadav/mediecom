import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mediecom/core/common/app/cache_helper.dart';
import 'package:mediecom/core/constants/media_constants.dart';
import 'package:mediecom/core/extentions/context_extensions.dart';
import 'package:mediecom/features/auth/presentation/auth_injection.dart';
import 'package:mediecom/features/auth/presentation/pages/onboarding_page.dart';
import 'package:mediecom/features/auth/presentation/pages/phone_number.dart';
import 'package:mediecom/features/explore/presentation/pages/home_screen.dart';
// import 'package:skillslinks/core/constants/media_constants.dart';
// import 'package:skillslinks/core/extentions/context_extensions.dart';
// import 'package:skillslinks/features/auth/presentation/screens/welcome_screen.dart';
// import 'package:skillslinks/vendor_features/dashboard/presentation/screens/home_dashboard.dart';

// import '../../../../core/common/app/cache_helper.dart';
// import '../../../../core/services/injection/injectiontion_container.dart';
// import '../../../user/presentation/screens/create_profile_screen.dart';
// import '../../../user/presentation/screens/fetch_location_screen.dart';
// import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _decideNextRoute();
  }

  Future<void> _decideNextRoute() async {
    //   // Wait for the splash screen duration
    await Future.delayed(const Duration(seconds: 3));

    //   // Guard against calling context on a disposed widget
    if (!mounted) return;

    final cacheHelper = sl<CacheHelper>();
    String destinationPath;
    // context.go(PhoneNumberPage.path);

    //   // --- Flattened Logic with Early Returns for Clarity ---

    //   // 1. Is it the user's first time opening the app?
    //   if (cacheHelper.isFirstTime()) {
    //     destinationPath = WelcomeScreen.path;
    //     context.go(destinationPath);
    //     return;
    //   }

    // 2. If not the first time, are they logged in?
    log("${!cacheHelper.isLoggedIn()}");
    if (cacheHelper.isLoggedIn()) {
      destinationPath = PhoneNumberPage.path;
      context.go(destinationPath);
      return;
    }

    //   // 3. If logged in, is their profile complete?
    //   // This is a safer way to check, handling both null user and empty name.
    //   final user = cacheHelper.getUser();
    //   if (user == null || user.name.isEmpty) {
    //     destinationPath = CreateProfileScreen.path;
    //     context.go(destinationPath);
    //     return;
    //   }

    // 4. If all checks pass, they are a returning, logged-in user with a profile.
    // destinationPath = HomeScreen.path;
    destinationPath = OnboardingPage.path;
    context.go(destinationPath);

    //   // for vendor app
    //   if (cacheHelper.isVendor()) {
    //     destinationPath = Dashboard.path;
    //     context.go(destinationPath);
    //   }
  }

  @override
  Widget build(BuildContext context) {
    // Using a Scaffold is a more standard and robust approach
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppMedia.imgSplash,
            height: context.height,
            width: context.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white, // More visible on a dark splash image
              ),
            ),
          ),
        ],
      ),
    );
  }
}
