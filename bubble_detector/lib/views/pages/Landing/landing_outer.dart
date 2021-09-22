import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/landin_page_body_text.dart';
import '../../widgets/landing_page_button.dart';
import '../../widgets/landing_page_textfield.dart';
import '../../widgets/landing_step_progress.dart';

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
              child: Column(
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
                    child: LandingPageTextField(),
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
                    onPressed: () {},
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
