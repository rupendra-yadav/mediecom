import 'package:flutter/material.dart';

abstract class Colours {
  //Scaffold Background

  static const Color scaffoldBackground = Color(0xFFF7F8FA);

  // Theme Base Colors
  static const Color primaryColor = Color(0xFF007B7F); // Teal Green
  static const Color secondaryColor = Color(0xFF1CA7E0); // Sky Blue
  static const Color neutralGray = Color(0xFFA9A9A9); // DarkGray
  static const Color white = Color(0xFFFFFFFF); // Light background
  static const Color dark = Color(0xFF1A1A1A); // Text / foreground
  static const Color accentCoral = Color(0xFFFF6B6B); // Optional highlight

  // Status Colors
  static const Color error = Color(0xFFE53935); // Red
  static const Color success = Color(0xFF43A047); // Green
  static const Color info = Color(0xFF1E88E5); // Blue

  //Background Colors
  static const Color primaryBackgroundColour = Color(0xFFE6F5F5);
  static const Color highlightBackgroundColour = Color(0xFFE7F6FB);
  static const Color backgroundColour = Color(0xffF0F0F0);
}

//   static const Color primary100Colour = Color(0xff049FFF);
//   static const Color primary80Colour = Color(0xcc2bacfc);
//   static const Color primary60Colour = Color(0x992bacfc);
//   static const Color primary40Colour = Color(0x662bacfc);
//   static const Color primary20Colour = Color(0x332bacfc);
//
//   static const Color dark100Colour = Color(0xff2E3034);
//   static const Color dark80Colour = Color(0xcc2E3034);
//   static const Color dark60Colour = Color(0x992E3034);
//   static const Color dark = Color(0x662E3034);
//   static const Color dark20Colour = Color(0x332E3034);
//
//   static const Color white = Color(0xffffffff);
//   static const Color white80Colour = Color(0xccffffff);
//   static const Color white60Colour = Color(0x99ffffff);
//   static const Color white40Colour = Color(0x66ffffff);
//   static const Color white20Colour = Color(0x33ffffff);
//
//   static const Color grey100Colour = Color(0xff8F92A1);
//   static const Color grey80Colour = Color(0xcc8F92A1);
//   static const Color grey60Colour = Color(0x998F92A1);
//   static const Color grey40Colour = Color(0x668F92A1);
//   static const Color grey20Colour = Color(0x338F92A1);
//
//   static const Color neutralGray = Color(0xffE4E4E7);
//   static const Color lightGrey80Colour = Color(0xccE4E4E7);
//   static const Color lightGrey60Colour = Color(0x99E4E4E7);
//   static const Color lightGrey40Colour = Color(0x66E4E4E7);
//   static const Color lightGrey20Colour = Color(0x33E4E4E7);
//
//   static const Color green100Colour = Color(0xff53D769);
//   static const Color green80Colour = Color(0xcc53D769);
//   static const Color green60Colour = Color(0x9953D769);
//   static const Color green40Colour = Color(0x6653D769);
//   static const Color green20Colour = Color(0x3353D769);
//
//   static const Color info100Colour = Color(0xff4285F4);
//   static const Color info80Colour = Color(0xcc4285F4);
//   static const Color info60Colour = Color(0x994285F4);
//   static const Color info40Colour = Color(0x664285F4);
//   static const Color info20Colour = Color(0x334285F4);
//
//   static const Color red100Colour = Color(0xffEC6B6C);
//   static const Color red80Colour = Color(0xccEC6B6C);
//   static const Color red60Colour = Color(0x99EC6B6C);
//   static const Color red40Colour = Color(0x66EC6B6C);
//   static const Color red20Colour = Color(0x33EC6B6C);
//
//
//
//
// }

/*import 'package:flutter/material.dart';


abstract class Colours {
  // Primary (Brand/Action/Interactive - A vibrant color related to your brand)
  // Choose a color that represents your app's personality.
  // Examples:
  //   - A brighter blue: #29ABE2 (light, modern)
  //   - A teal: #008080 (trustworthy, sophisticated)
  //   - An orange: #FF9800 (energetic, friendly)
  static const Color primary100Colour = Color(0xff29ABE2); // Example: Bright Blue
  static const Color primary80Colour = Color(0xcc29ABE2);
  static const Color primary60Colour = Color(0x9929ABE2);
  static const Color primary40Colour = Color(0x6629ABE2);
  static const Color primary20Colour = Color(0x3329ABE2);

  // Secondary (Rental Focus - A color associated with flexibility and short-term use)
  // Consider a softer, more approachable color.
  // Examples:
  //   - A muted green: #8BC34A
  //   - A light blue-gray: #B0BEC5
  static const Color secondary100Colour = Color(0xff8BC34A); // Example: Muted Green
  static const Color secondary80Colour = Color(0xcc8BC34A);
  static const Color secondary60Colour = Color(0x998BC34A);
  static const Color secondary40Colour = Color(0x668BC34A);
  static const Color secondary20Colour = Color(0x338BC34A);

  // Tertiary (Purchase Focus - A color associated with ownership and long-term value)
  // Consider a bolder, more stable color.
  // Examples:
  //   - A deep blue: #3F51B5
  //   - A warm brown: #795548
  static const Color tertiary100Colour = Color(0xff3F51B5); // Example: Deep Blue
  static const Color tertiary80Colour = Color(0xcc3F51B5);
  static const Color tertiary60Colour = Color(0x993F51B5);
  static const Color tertiary40Colour = Color(0x663F51B5);
  static const Color tertiary20Colour = Color(0x333F51B5);

  // Back (Navigation)
  static const Color blackColour = Color(0xff000000);
  static const Color black80Colour = Color(0xcc000000);
  static const Color black60Colour = Color(0x99000000);
  static const Color black40Colour = Color(0x66000000);
  static const Color black20Colour = Color(0x33000000);




  // White (Background)
  static const Color white = Color(0xffF7F7F7);
  static const Color white80Colour = Color(0xccF7F7F7);
  static const Color white60Colour = Color(0x99F7F7F7);
  static const Color white40Colour = Color(0x66F7F7F7);
  static const Color white20Colour = Color(0x33F7F7F7);



  // Dark Grey (Text)
  static const Color dark100Colour = Color(0xff484848);
  static const Color dark80Colour = Color(0xcc484848);
  static const Color dark60Colour = Color(0x99484848);
  static const Color dark = Color(0x66484848);
  static const Color dark20Colour = Color(0x33484848);


  // Grey (Border/Divider)
  static const Color grey100Colour = Color(0xFF888888);
  static const Color grey80Colour = Color(0xCC888888);
  static const Color grey60Colour = Color(0x99888888);
  static const Color grey40Colour = Color(0x66888888);
  static const Color grey20Colour = Color(0x33888888);


  // Light Grey (Subtle Separation)
  static const Color neutralGray = Color(0xffEEEEEE);
  static const Color lightGrey80Colour = Color(0xccEEEEEE);
  static const Color lightGrey60Colour = Color(0x99EEEEEE);
  static const Color lightGrey40Colour = Color(0x66EEEEEE);
  static const Color lightGrey20Colour = Color(0x33EEEEEE);

  // Green (Success)
  static const Color green100Colour = Color(0xff34A853);
  static const Color green80Colour = Color(0xcc34A853);
  static const Color green60Colour = Color(0x9934A853);
  static const Color green40Colour = Color(0x6634A853);
  static const Color green20Colour = Color(0x3334A853);

  // Info (Blue)
  static const Color info100Colour = Color(0xff4285F4);
  static const Color info80Colour = Color(0xcc4285F4);
  static const Color info60Colour = Color(0x994285F4);
  static const Color info40Colour = Color(0x664285F4);
  static const Color info20Colour = Color(0x334285F4);

  // Red (Error)
  static const Color red100Colour = Color(0xffEA4335);
  static const Color red80Colour = Color(0xccEA4335);
  static const Color red60Colour = Color(0x99EA4335);
  static const Color red40Colour = Color(0x66EA4335);
  static const Color red20Colour = Color(0x33EA4335);
}*/

// import 'package:flutter/material.dart';

// abstract class Colours {
//   // Base Color (From the gradient: #9400D3 - Deep Violet)
//   static const Color primaryColor = Color(0xFF9400D3);
//   static const Color primary100Colour = Color(0xFF9C27B0);
//   static const Color primary80Colour = Color(0xCC9C27B0);
//   static const Color primary60Colour = Color(0x999C27B0);
//   static const Color primary40Colour = Color(0x669C27B0);
//   static const Color primary20Colour = Color(0x339C27B0);

//   // // Primary (Action/Interactive - More accessible & vibrant violet)
//   // static const Color primary100Colour = Color(
//   //   0xFF9C27B0,
//   // ); // Slightly brighter violet
//   // // static const Color primary100Colour = Color(0xFFE0BBE4); // Slightly brighter violet
//   // static const Color primary80Colour = Color(0xCC9C27B0);
//   // static const Color primary60Colour = Color(0x999C27B0);
//   // static const Color primary40Colour = Color(0x669C27B0);
//   // static const Color primary20Colour = Color(0x339C27B0);
//   // // static const Color primary20Colour = Color.fromARGB(51, 231, 152, 245);

//   static const Color secondary = Color(0xFFFFCB40);

//   static const Color blackTrans2 = Color(0x1A2A2A2A);

//   // Secondary (Subtle accent - A very light, desaturated violet)
//   static const Color secondary100Colour = Color(
//     0xFFEDE7F6,
//   ); // Lightest violet shade
//   static const Color secondary80Colour = Color(0xCCEDE7F6);
//   static const Color secondary60Colour = Color(0x99EDE7F6);
//   static const Color secondary40Colour = Color(0x66EDE7F6);
//   static const Color secondary20Colour = Color(0x33EDE7F6);

//   // Tertiary (Accent/Highlight -  A *very* muted gold/yellow.  Subtle.)
//   static const Color tertiary100Colour = Color(0xFFFFFDE7); // Light Yellow
//   static const Color tertiary80Colour = Color(0xCCFFFDE7);
//   static const Color tertiary60Colour = Color(0x99FFFDE7);
//   static const Color tertiary40Colour = Color(0x66FFFDE7);
//   static const Color tertiary20Colour = Color(0x33FFFDE7);

//   // Back (Navigation - Very dark gray.  Close to black, good contrast.)
//   static const Color blackColour = Color(0xFF212121); // Very Dark Gray
//   static const Color black80Colour = Color(0xCC212121);
//   static const Color black60Colour = Color(0x99212121);
//   static const Color black40Colour = Color(0x66212121);
//   static const Color black20Colour = Color(0x33212121);

//   // White (Background)
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color white80Colour = Color(0xCCFFFFFF);
//   static const Color white60Colour = Color(0x99FFFFFF);
//   static const Color white40Colour = Color(0x66FFFFFF);
//   static const Color white20Colour = Color(0x33FFFFFF);

//   // Dark Grey (Text -  Readable against white, secondary, tertiary)
//   static const Color dark100Colour = Color(0xFF424242); // Dark Gray
//   static const Color dark80Colour = Color(0xCC424242);
//   static const Color dark60Colour = Color(0x99424242);
//   static const Color dark = Color(0x66424242);
//   static const Color dark20Colour = Color(0x33424242);

//   // Grey (Border/Divider - Light, subtle divider)
//   static const Color grey100Colour = Color(0xFFBDBDBD); // Medium Gray
//   static const Color grey80Colour = Color(0xCCBDBDBD);
//   static const Color grey60Colour = Color(0x99BDBDBD);
//   static const Color grey40Colour = Color(0x66BDBDBD);
//   static const Color grey20Colour = Color(0x33BDBDBD);

//   // Light Grey (Subtle Separation - almost white)
//   static const Color neutralGray = Color(0xFFF5F5F5); // Very Light Gray
//   static const Color lightGrey80Colour = Color(0xCCF5F5F5);
//   static const Color lightGrey60Colour = Color(0x99F5F5F5);
//   static const Color lightGrey40Colour = Color(0x66F5F5F5);
//   static const Color lightGrey20Colour = Color(0x33F5F5F5);

//   // Green (Success)
//   static const Color green100Colour = Color(0xFF4CAF50); // Green
//   static const Color green80Colour = Color(0xCC4CAF50);
//   static const Color green60Colour = Color(0x994CAF50);
//   static const Color green40Colour = Color(0x664CAF50);
//   static const Color green20Colour = Color(0x334CAF50);

//   // Info (Blue - A standard, recognizable info color)
//   static const Color info100Colour = Color(0xFF2196F3); // Blue
//   static const Color info80Colour = Color(0xCC2196F3);
//   static const Color info60Colour = Color(0x992196F3);
//   static const Color info40Colour = Color(0x662196F3);
//   static const Color info20Colour = Color(0x332196F3);

//   // Red (Error - A clear error indicator)
//   static const Color red100Colour = Color(0xFFF44336); // Red
//   static const Color red80Colour = Color(0xCCF44336);
//   static const Color red60Colour = Color(0x99F44336);
//   static const Color red40Colour = Color(0x66F44336);
//   static const Color red20Colour = Color(0x33F44336);
// }

// abstract class ColoursBlue {
//   // Base Color (From the gradient: #2196F3 - Standard Blue)
//   static const Color primaryColor = Color(0xFF2196F3);

//   // Primary (Action/Interactive - More accessible & vibrant blue)
//   static const Color primary100Colour = Color(
//     0xFF2979FF,
//   ); // Slightly brighter blue
//   // static const Color primary100Colour = Color(0xFFE0BBE4); // Slightly brighter violet
//   static const Color primary80Colour = Color(0xCC2979FF);
//   static const Color primary60Colour = Color(0x992979FF);
//   static const Color primary40Colour = Color(0x662979FF);
//   static const Color primary20Colour = Color(0x332979FF);

//   static const Color secondary = Color(0xFFFFCB40);

//   static const Color blackTrans2 = Color(0x1A2A2A2A);

//   // Secondary (Subtle accent - A very light, desaturated blue)
//   static const Color secondary100Colour = Color(
//     0xFFE3F2FD,
//   ); // Lightest blue shade
//   static const Color secondary80Colour = Color(0xCCE3F2FD);
//   static const Color secondary60Colour = Color(0x99E3F2FD);
//   static const Color secondary40Colour = Color(0x66E3F2FD);
//   static const Color secondary20Colour = Color(0x33E3F2FD);

//   // Tertiary (Accent/Highlight -  A *very* muted gold/yellow.  Subtle.)
//   static const Color tertiary100Colour = Color(0xFFFFFDE7); // Light Yellow
//   static const Color tertiary80Colour = Color(0xCCFFFDE7);
//   static const Color tertiary60Colour = Color(0x99FFFDE7);
//   static const Color tertiary40Colour = Color(0x66FFFDE7);
//   static const Color tertiary20Colour = Color(0x33FFFDE7);

//   // Back (Navigation - Very dark gray.  Close to black, good contrast.)
//   static const Color blackColour = Color(0xFF212121); // Very Dark Gray
//   static const Color black80Colour = Color(0xCC212121);
//   static const Color black60Colour = Color(0x99212121);
//   static const Color black40Colour = Color(0x66212121);
//   static const Color black20Colour = Color(0x33212121);

//   // White (Background)
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color white80Colour = Color(0xCCFFFFFF);
//   static const Color white60Colour = Color(0x99FFFFFF);
//   static const Color white40Colour = Color(0x66FFFFFF);
//   static const Color white20Colour = Color(0x33FFFFFF);

//   // Dark Grey (Text -  Readable against white, secondary, tertiary)
//   static const Color dark100Colour = Color(0xFF424242); // Dark Gray
//   static const Color dark80Colour = Color(0xCC424242);
//   static const Color dark60Colour = Color(0x99424242);
//   static const Color dark = Color(0x66424242);
//   static const Color dark20Colour = Color(0x33424242);

//   // Grey (Border/Divider - Light, subtle divider)
//   static const Color grey100Colour = Color(0xFFBDBDBD); // Medium Gray
//   static const Color grey80Colour = Color(0xCCBDBDBD);
//   static const Color grey60Colour = Color(0x99BDBDBD);
//   static const Color grey40Colour = Color(0x66BDBDBD);
//   static const Color grey20Colour = Color(0x33BDBDBD);

//   // Light Grey (Subtle Separation - almost white)
//   static const Color neutralGray = Color(0xFFF5F5F5); // Very Light Gray
//   static const Color lightGrey80Colour = Color(0xCCF5F5F5);
//   static const Color lightGrey60Colour = Color(0x99F5F5F5);
//   static const Color lightGrey40Colour = Color(0x66F5F5F5);
//   static const Color lightGrey20Colour = Color(0x33F5F5F5);

//   // Green (Success)
//   static const Color green100Colour = Color(0xFF4CAF50); // Green
//   static const Color green80Colour = Color(0xCC4CAF50);
//   static const Color green60Colour = Color(0x994CAF50);
//   static const Color green40Colour = Color(0x664CAF50);
//   static const Color green20Colour = Color(0x334CAF50);

//   // Info (Blue - A standard, recognizable info color)
//   static const Color info100Colour = Color(0xFF2196F3); // Blue
//   static const Color info80Colour = Color(0xCC2196F3);
//   static const Color info60Colour = Color(0x992196F3);
//   static const Color info40Colour = Color(0x662196F3);
//   static const Color info20Colour = Color(0x332196F3);

//   // Red (Error - A clear error indicator)
//   static const Color red100Colour = Color(0xFFF44336); // Red
//   static const Color red80Colour = Color(0xCCF44336);
//   static const Color red60Colour = Color(0x99F44336);
//   static const Color red40Colour = Color(0x66F44336);
//   static const Color red20Colour = Color(0x33F44336);

// }
