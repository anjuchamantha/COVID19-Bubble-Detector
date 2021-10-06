import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingPageTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final int maxLength;
  final TextAlign textAlign;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const LandingPageTextField({
    Key? key,
    required this.controller,
    this.hintText = '',
    this.labelText = '',
    this.maxLength = 1,
    this.textAlign = TextAlign.center,
    this.keyboardType = const TextInputType.numberWithOptions(decimal: true),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(color: Colors.orangeAccent),
        ),
        contentPadding: EdgeInsets.all(18),
        hintText: hintText,
        labelText: labelText,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
        this.keyboardType == TextInputType.numberWithOptions(decimal: true)
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
      ],
      textAlign: textAlign,
      keyboardType: this.keyboardType,
    );
  }
}
