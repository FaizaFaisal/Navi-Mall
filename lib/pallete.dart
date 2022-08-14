//palette.dart
import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff7c9c79, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      //
      50: Color(0xff708c6d), //10%
      100: Color(0xff637d61), //20%
      200: Color(0xff576d55), //30%
      300: Color(0xff4a5e49), //40%
      400: Color(0xff3e4e3d), //50%
      // Light Shades  as in Pale
      500: Color(0xff323e30), //60%
      600: Color(0xff252f24), //70%
      700: Color(0xff191f18), //80%
      800: Color(0xff0c100c), //90%
      900: Color(0xff000000), //100%
    },
  );
} // you can define define int 500 as the default shade and add your lighter tints above and darker tints below.
