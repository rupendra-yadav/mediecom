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
//   // log("Could not launch $url");
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
