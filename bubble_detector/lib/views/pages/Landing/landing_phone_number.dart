import '../../../controllers/page_state_contollers/auth_page_controller.dart';
import '../../../controllers/page_state_contollers/LandingPagesController/landing_pages_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/landin_page_body_text.dart';
import '../../widgets/landing_page_button.dart';
import '../../widgets/landing_page_textfield.dart';

class LandingPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthPageController authPageController = Get.find();
    final LandingPagesController landingPagesController = Get.find();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Enter the Phone Number'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SvgPicture.asset('images/phone_phone.svg'),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: LandingPageTextField(
            controller: authPageController.phoneNumberInputController,
            hintText: "771234567",
            labelText: "Phone Number",
            maxLength: 9,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LandingPageBodyText(
            text:
                'Bubble Detector requires your phone number to register you, we only collect this data and nothing else.',
          ),
        ),
        Spacer(),
        LandingPageButton(
          text: 'Next',
          onPressed: () {
            var phoneNumber = "+94" +
                authPageController.phoneNumberInputController.value.text;
            print(phoneNumber);
            authPageController.phoneNumberEnteredTrue();
            authPageController.phoneAuth(phoneNumber);

            landingPagesController.increaseStepCounter();
            landingPagesController.nextLandingPage();
          },
        ),
        Spacer(),
      ],
    );
  }
}
