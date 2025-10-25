import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mediecom/core/constants/media_constants.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/cart/presentation/pages/cart.dart';
import 'package:mediecom/features/explore/presentation/pages/home_screen.dart';
import 'package:mediecom/features/explore/presentation/widgets/gradient_appBar.dart';
import 'package:mediecom/features/orders/presentation/pages/orders.dart';
import 'package:mediecom/features/user/presentation/pages/profile.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key, required this.child});

  final Widget child;
  static const path = "/navigation_screen";

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      appBar: GradientAppBar(
        name: _getTitle(context),
        address: "123 MG Road, Bengaluru",
        onNotificationTap: () {
          // Handle notification click
        },
        isUserName: _calculateSelectedIndex(context) == 0,
      ),
      // appBar: AppBar(
      //   backgroundColor: Colours.white,
      //   title: Image.asset(AppMedia.imgLogo1, height: 40, width: 40),
      //   elevation: 0,
      //   scrolledUnderElevation: 0,
      //   actions: [
      //     Container(
      //       width: 50,
      //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(16),
      //         border: Border.all(color: Colors.grey.shade300, width: 1.5),
      //       ),
      //       child: const Icon(
      //         Icons.emoji_emotions_outlined,
      //         size: 18,
      //         color: Colors.orange,
      //       ),
      //     ),

      //     SizedBox(width: 10),
      //     Container(
      //       width: 50,
      //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(16),
      //         border: Border.all(color: Colors.grey.shade300, width: 1.5),
      //       ),
      //       child: const Icon(
      //         Icons.local_fire_department,
      //         size: 18,
      //         color: Colors.red,
      //       ),
      //     ),
      //     SizedBox(width: 10),
      //   ],
      // ),
      // extendBody: true,
      body: child,

      bottomNavigationBar: BottomAppBar(
        height: 69.h,
        color: Colours.white,
        notchMargin: 5,
        shape: CircularNotchedRectangle(inverted: false),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _onItemTapped(0, context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.home_1,
                    color: selectedIndex == 0
                        ? Colours.primaryColor
                        : Colours.neutralGray,
                  ),
                  Text(
                    "Home",
                    style: AppTextStyles.karala12w500.copyWith(
                      color: selectedIndex == 0
                          ? Colours.primaryColor
                          : Colours.neutralGray,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _onItemTapped(1, context);
              },
              child: Column(
                children: [
                  Icon(
                    Iconsax.shopping_cart,
                    color: selectedIndex == 1
                        ? Colours.primaryColor
                        : Colours.neutralGray,
                  ),
                  Text(
                    "Cart",
                    style: AppTextStyles.karala12w800.copyWith(
                      color: selectedIndex == 1
                          ? Colours.primaryColor
                          : Colours.neutralGray,
                    ),
                  ),
                ],
              ),
            ),

            InkWell(
              onTap: () {
                _onItemTapped(2, context);
              },
              child: Column(
                children: [
                  Icon(
                    Iconsax.receipt,
                    color: selectedIndex == 2
                        ? Colours.primaryColor
                        : Colours.neutralGray,
                  ),
                  Text(
                    "Orders",
                    style: AppTextStyles.karala12w800.copyWith(
                      color: selectedIndex == 2
                          ? Colours.primaryColor
                          : Colours.neutralGray,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _onItemTapped(3, context);
              },
              child: Column(
                children: [
                  Icon(
                    Iconsax.profile_2user,
                    color: selectedIndex == 3
                        ? Colours.primaryColor
                        : Colours.neutralGray,
                  ),
                  Text(
                    "Profile",
                    style: AppTextStyles.karala12w800.copyWith(
                      color: selectedIndex == 3
                          ? Colours.primaryColor
                          : Colours.neutralGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int _calculateSelectedIndex(BuildContext context) {
  final GoRouter router = GoRouter.of(context);
  final String location = router.routerDelegate.currentConfiguration.uri
      .toString();

  if (location.startsWith(HomeScreen.path)) {
    return 0;
  }
  if (location.startsWith(Cart.path)) {
    return 1;
  }
  if (location.startsWith(Orders.path)) {
    return 2;
  }
  if (location.startsWith(ProfilePage.path)) {
    return 3;
  }

  return 0;
}

void _onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      context.go(HomeScreen.path);
      break;
    case 1:
      context.go(Cart.path);
      break;
    case 2:
      context.go(Orders.path);
      break;
    case 3:
      context.go(ProfilePage.path);
      break;
  }
}

String _getTitle(BuildContext context) {
  final int index = _calculateSelectedIndex(context);

  if (index == 0) {
    // Home tab selected, show greeting based on time of day
    return "User";
  } else if (index == 1) {
    return "Cart";
  } else if (index == 2) {
    return "Orders";
  } else if (index == 3) {
    return "Profile";
  }
  return '';
}
