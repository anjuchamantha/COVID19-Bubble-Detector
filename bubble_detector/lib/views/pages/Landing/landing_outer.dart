import '../../../controllers/page_state_contollers/LandingPagesController/landing_page_state.dart';

import '../../../controllers/page_state_contollers/auth_page_controller.dart';
import '../../../controllers/page_state_contollers/LandingPagesController/landing_pages_controller.dart';
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
    final LandingPagesController landingPagesController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Obx(
                () => LandingStepProgress(
                  currentStep: landingPagesController.stepCounter.value,
                ),
              ),
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
/*             GetX<LandingPagesController>(
              builder: (controller) {
                print(2);
                return Expanded(
                  child: _landingPageWidget(
                    landingPagesController.landingPageState.value,
                  ),
                );
              },
            ), */
            GetBuilder<LandingPagesController>(
              builder: (controller) => Expanded(
                child: _landingPageWidget(
                  landingPagesController.landingPageState.value,
                ),
              ),
            ),
            /*  Obx(
              () => Expanded(
                child: _landingPageWidget(
                  landingPagesController.landingPageState.value,
                ),
              ),
            ), */
          ],
        ),
      ),
    );
  }

/*   Widget _landingPageWidget(LandingPageState landingPageState) {
    print(landingPageState.current());
    switch (landingPageState.current()) {
      case LandingPagePhoneNumberState:
        return LandingPhoneNumber();

      case LandingPageOtpState:
        return LandingOtp();

      default:
        return Container();
    }
  } */

  Widget _landingPageWidget(int landingPageState) {
    print(landingPageState);
    print('asdddddddddddddddddddddddd');
    switch (landingPageState) {
      case 1:
        return LandingPhoneNumber();

      case 2:
        return LandingOtp();

      default:
        return Container();
    }
  }
}
