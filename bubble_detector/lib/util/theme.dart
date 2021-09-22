import 'package:flutter/material.dart';

abstract class PrimaryTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: _ProjectColors.BACKGROUND_COLOR,
      backgroundColor: _ProjectColors.BACKGROUND_COLOR,
    );
  }
}

abstract class _ProjectColors {
  static const Color BACKGROUND_COLOR = Color(0xffFDFDFF);
}
