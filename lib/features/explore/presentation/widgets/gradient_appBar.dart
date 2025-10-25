import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String address;
  final VoidCallback? onNotificationTap;
  final bool isUserName;

  const GradientAppBar({
    super.key,
    required this.name,
    required this.address,
    this.onNotificationTap,
    required this.isUserName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colours.primaryColor,
            Colours.primaryColor,
            Colours.highlightBackgroundColour,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        // borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        // boxShadow: [
        //   BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
        // ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SafeArea(
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Name and Address
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isUserName) ...[
                    Text(
                      "Hi, $name 👋",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.location5,
                          size: 14,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            address,
                            style: AppTextStyles.karala10w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (!isUserName) ...[
                    Text(
                      "$name",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Right: Notification Icon
            InkWell(
              onTap: onNotificationTap,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.notification, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
