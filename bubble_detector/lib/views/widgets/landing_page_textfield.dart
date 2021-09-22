import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingPageTextField extends StatelessWidget {
  const LandingPageTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
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
        hintText: '07xxxxxxxx',
        labelText: 'Phone Number',
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}
