import 'package:flutter/material.dart';

abstract class PrimaryTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      primaryColor: _ProjectColors.PRIMARY_COLOR,
      secondaryHeaderColor: _ProjectColors.SECONDARY_COLOR,
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: _ProjectColors.ACCENT_COLOR,
        displayColor: _ProjectColors.ACCENT_COLOR,
      ),
      scaffoldBackgroundColor: _ProjectColors.BACKGROUND_COLOR,
      backgroundColor: _ProjectColors.BACKGROUND_COLOR,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: _ProjectColors.PRIMARY_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          textStyle: TextStyle(
            fontSize: 14,
            letterSpacing: 1.25,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
          elevation: 0,
        ),
      ),
    );
  }
}

// 7D7E97
abstract class _ProjectColors {
  static const Color BACKGROUND_COLOR = Color(0xffFDFDFF);
  static const Color PRIMARY_COLOR = Color(0xff191BA9);
  static const Color SECONDARY_COLOR = Color(0xff5BC2F1);
  static const Color ACCENT_COLOR = Color(0xff7D7E97);
}
