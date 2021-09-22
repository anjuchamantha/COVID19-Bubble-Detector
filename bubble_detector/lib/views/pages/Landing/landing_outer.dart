import 'package:bubble_detector/views/pages/Landing/landing_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/landin_page_body_text.dart';
import '../../widgets/landing_page_button.dart';
import '../../widgets/landing_page_textfield.dart';
import '../../widgets/landing_step_progress.dart';
import 'landing_phone_number.dart';

class LandingOuter extends StatelessWidget {
  const LandingOuter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: LandingStepProgress(currentStep: 1),
            ),
            SizedBox(height: 40),
            Text(
              'Register',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
                letterSpacing: 0.18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: LandingOtp(),
            ),
          ],
        ),
      ),
    );
  }
}
