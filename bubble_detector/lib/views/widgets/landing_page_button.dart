import 'package:flutter/material.dart';

/// This is the Theme for the Buttons in the Landing Pages
/// color - Primary Color
/// Width - Total Width
/// Use it any other place if needed
class LandingPageButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const LandingPageButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 11 * MediaQuery.of(context).size.width / 12,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(this.text),
      ),
    );
  }
}
