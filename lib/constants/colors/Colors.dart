import 'dart:ui';

import 'package:flutter/material.dart';

class CustomColors {
  // Background
  static const Color backgroundBlack = Colors.black;
  static const Color backgroundWhite = Colors.white;

  static const Color containerBackgroundBlack = Colors.black38;
  static const Color containerBackgroundWhite = Colors.white38;

  static const Color textBlack = Colors.black;
  static const Color textWhite = Colors.white;
  static const Color black = Color(0x001D1D1F);
  static const Color white = Color.fromARGB(255, 245, 245, 247);
  static const Color grey = Color.fromARGB(255, 192, 192, 195);
  static const Color green = Color.fromARGB(255, 155, 167, 27);
}

class BrightnessService {
  static Brightness getBrightness(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.platformBrightness;
  }
}

// final Brightness brightness = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).platformBrightness;

// BrightnessService.getBrightness(context) == Brightness.light ? CustomColors.textBlack : Colors.transparent,