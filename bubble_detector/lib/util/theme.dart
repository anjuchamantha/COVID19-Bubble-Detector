import 'package:flutter/material.dart';

abstract class PrimaryTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      primaryColor: ProjectColors.PRIMARY_COLOR,
      secondaryHeaderColor: ProjectColors.SECONDARY_COLOR,
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: ProjectColors.ACCENT_COLOR,
        displayColor: ProjectColors.ACCENT_COLOR,
      ),
      scaffoldBackgroundColor: ProjectColors.BACKGROUND_COLOR,
      backgroundColor: ProjectColors.BACKGROUND_COLOR,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: ProjectColors.PRIMARY_COLOR,
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
abstract class ProjectColors {
  static const Color BACKGROUND_COLOR = Color(0xffFDFDFF);
  static const Color PRIMARY_COLOR = Color(0xff191BA9);
  static const Color SECONDARY_COLOR = Color(0xff5BC2F1);
  static const Color TERTIARY_COLOR = Color(0xffBAE8FD);
  static const Color ACCENT_COLOR = Color(0xff7D7E97);
  static const Color BLACK = Color(0xff1B1B1B);
  static const Color SECONDARY_BLACK = Color(0xff535461);
}
