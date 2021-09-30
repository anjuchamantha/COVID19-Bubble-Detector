import 'package:bubble_detector/controllers/page_state_contollers/auth_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/landing_step_progress.dart';
import 'landing_otp.dart';
import 'landing_phone_number.dart';

class LandingOuter extends StatelessWidget {
  const LandingOuter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthPageController authPageController = Get.find();
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
              child: Obx(() => (authPageController.phoneNumberEntered.value)
                  ? LandingOtp()
                  : LandingPhoneNumber()),
            ),
          ],
        ),
      ),
    );
  }
}
