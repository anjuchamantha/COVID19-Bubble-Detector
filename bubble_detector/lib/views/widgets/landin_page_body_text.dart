import 'package:flutter/material.dart';

/// Font size - 14px.
/// color - _ProjectColors.AccentColor
/// Mainly used in the Landing Page
class LandingPageBodyText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;

  const LandingPageBodyText({
    Key? key,
    required this.text,
    this.color = Colors.transparent,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontSize: 14,
        letterSpacing: 0.25,
        height: 1.5,
        color:
            this.color == Colors.transparent ? Color(0xff7D7E97) : this.color,
        fontWeight: this.fontWeight,
      ),
      textAlign: TextAlign.center,
    );
  }
}
