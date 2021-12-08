import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/page_state_contollers/LandingPagesController/landing_pages_controller.dart';
import '../../../util/routes.dart';
import '../../../util/ui_util.dart';
import '../../widgets/landin_page_body_text.dart';
import '../../widgets/landing_page_button.dart';

class LandingBluetooth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LandingPagesController landingPagesController = Get.find();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Enable Bluetooth'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SvgPicture.asset('images/landing_bluetooth.svg'),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: LandingPageBodyText(
            text:
                'Bubble Detector requires bluetooth access to scan the nearby contacts.',
          ),
        ),
        Spacer(),
        LandingPageButton(
          text: 'Enable Bluetooth',
          onPressed: () {
            // var phoneNumber = "+94" +
            //     authPageController.phoneNumberInputController.value.text;
            // print(phoneNumber);
            // authPageController.phoneNumberEnteredTrue();
            // authPageController.phoneAuth(phoneNumber);
            UiUtil.enableBluetooth().then((value) {
              if (value != null) {
                if (value) {
                  Get.snackbar(
                    'Bluetooth Enabled',
                    'Bluetooth successfully enabled.',
                  );
                  // landingPagesController.increaseStepCounter();
                  // landingPagesController.nextLandingPage();
                  Get.toNamed(AppRoutes.HOME);
                } else {
                  Get.snackbar(
                    'Bluetooth not Enabled',
                    'Bubble Detector requires bluetooth access to scan the nearby contacts.',
                  );
                }
              }
            });
          },
        ),
        Spacer(),
      ],
    );
  }
}
