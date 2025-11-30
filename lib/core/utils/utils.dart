import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediecom/core/common/error/app_failures.dart';
import 'package:mediecom/core/style/app_colors.dart';
// import 'dart:developer';

// import 'package:url_launcher/url_launcher.dart';
// import 'package:maps_launcher/maps_launcher.dart';

// void launchCaller(String tel) async {
//   var url = Uri.parse("tel:$tel");
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// void launchWhatsApp(String tel) async {
//   final uri = Uri.parse(
//     'https://wa.me/$tel?text=${Uri.encodeComponent("Hii")}',
//   );
//   // try {
//   //   await launchUrl(uri, mode: LaunchMode.platformDefault);
//   // } catch (e) {
//   //   final Uri fallbackUri = Uri.parse(fallbackUrl);
//   //   await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
//   // }

//   await launchUrl(uri, mode: LaunchMode.externalApplication);
// }

// Future<void> goToUrl(String? url) async {
//   if (url == null || url.isEmpty) return; // skip empty

//   final Uri uri = Uri.parse(url.trim());

//   if (!uri.hasScheme) {
//     // ensure https:// is added if missing
//     url = "https://$url";
//   }
//   print(await canLaunchUrl(Uri.parse(url)));

//   final Uri safeUri = Uri.parse(url);

//   // if (await canLaunchUrl(safeUri)) {
//   await launchUrl(safeUri, mode: LaunchMode.externalApplication);
//   // } else {
//   // appLog("Could not launch $url");
//   // }
// }

// void launchMap(double lat, double long) async {
//   MapsLauncher.launchCoordinates(lat, long);
// }

// double getAverage(List<String> numbers) {
//   if (numbers.isEmpty) return 0;

//   List<double> doubleList = numbers.map((e) => double.parse(e)).toList();
//   double sum = doubleList.reduce((a, b) => a + b);

//   return sum / doubleList.length;
// }

String mapFailureToMessage(Failure failure) {
  switch (failure) {
    case ServerFailure():
      return 'Server Error: ${failure.message}';
    case NetworkFailure():
      return 'Network Error: ${failure.message}';
    default:
      return 'Unexpected Error';
  }
}

void appLog(String msg) {
  if (kDebugMode) {
    // prints only in debug mode
    // no logs in release builds
    // kDebugMode = true only when debug
    // false in release / profile
    // so safe for production
    // ignore: avoid_print
    log(msg);
  }
}

Future<XFile?> showImagePickerSheet(BuildContext context, String title) async {
  final ImagePicker picker = ImagePicker();

  return showModalBottomSheet<XFile?>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 20),

              // 🎯 Icon Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOption(
                    icon: Iconsax.camera,
                    color: Colors.blue,
                    label: "Camera",
                    onTap: () async {
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.camera,
                      );
                      Navigator.pop(context, image);
                    },
                  ),
                  _buildOption(
                    icon: Iconsax.gallery,
                    color: Colors.green,
                    label: "Gallery",
                    onTap: () async {
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      Navigator.pop(context, image);
                    },
                  ),
                  _buildOption(
                    icon: Iconsax.close_circle,
                    color: Colors.red,
                    label: "Cancel",
                    onTap: () => Navigator.pop(context, null),
                  ),
                ],
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      );
    },
  );
}

/// 🔹 Small helper widget for icon buttons
Widget _buildOption({
  required IconData icon,
  required Color color,
  required String label,
  required VoidCallback onTap,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: onTap,
    child: Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}
