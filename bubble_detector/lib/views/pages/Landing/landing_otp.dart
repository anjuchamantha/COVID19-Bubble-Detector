import '../../../controllers/page_state_contollers/auth_page_controller.dart';
import '../../../controllers/page_state_contollers/LandingPagesController/landing_pages_controller.dart';
import '../../widgets/landing_page_textfield.dart';
import 'package:get/get.dart';

import '../../widgets/landin_page_body_text.dart';
import '../../widgets/landing_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingOtp extends StatelessWidget {
  const LandingOtp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthPageController authPageController = Get.find();
    final LandingPagesController landingPagesController = Get.find();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Enter your OTP'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SvgPicture.asset('images/phone_otp.svg'),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              // SizedBox(width: 15),
              // Expanded(child: LandingPageTextField()),
              // SizedBox(width: 7),
              // Expanded(child: LandingPageTextField()),
              // SizedBox(width: 7),
              // Expanded(child: LandingPageTextField()),
              // SizedBox(width: 7),
              Expanded(
                child: LandingPageTextField(
                  controller: authPageController.otpInputController,
                  labelText: "OTP Code",
                  maxLength: 6,
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: LandingPageBodyText(
            text:
                'Please enter the one time password we sent you, to verify your phone number.',
          ),
        ),
        Spacer(),
        LandingPageButton(
          text: 'Next',
          onPressed: () {
            // authPageController.otpEntered.value = true;
            // var otp = authPageController.otpInputController.text.toString();
            // print(otp);
            // authPageController.otp.value = otp;

            landingPagesController.increaseStepCounter();
          },
        ),
        SizedBox(
          height: 15,
        ),
        LandingPageButton(
          secondary: true,
          text: 'I didn’t get the code',
          onPressed: () {},
        ),
        /* Divider(),
        LandingPageButton(
          text: 'Next',
          onPressed: () {},
        ), */
        Spacer(),
      ],
    );
  }
}
