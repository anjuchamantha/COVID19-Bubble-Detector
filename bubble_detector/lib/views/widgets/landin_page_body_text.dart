import 'package:flutter/material.dart';

/// Font size - 14px.
/// color - _ProjectColors.AccentColor
/// Mainly used in the Landing Page
class LandingPageBodyText extends StatelessWidget {
  final String text;

  const LandingPageBodyText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontSize: 14,
        letterSpacing: 0.25,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }
}
