import '../../widgets/landin_page_body_text.dart';
import '../../widgets/landing_page_button.dart';
import '../../widgets/landing_page_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingPhoneNumber extends StatelessWidget {
  const LandingPhoneNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
