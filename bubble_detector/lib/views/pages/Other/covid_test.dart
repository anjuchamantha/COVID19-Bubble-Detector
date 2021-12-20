import 'dart:ui';

import 'package:bubble_detector/controllers/page_state_contollers/LandingPagesController/coivd_test_page_controller.dart';
import 'package:bubble_detector/util/routes.dart';
import 'package:bubble_detector/views/widgets/landing_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../util/theme.dart';

class CovidTestPage extends StatelessWidget {
  const CovidTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Spacer(),
            Text(
              'You were marked as a contact',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ProjectColors.ACCENT_COLOR,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Take a PCR or Rapid-Antigen test for COVID-19.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ProjectColors.PRIMARY_COLOR,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 32),
            SvgPicture.asset(
              'images/covid_test.svg',
              height: MediaQuery.of(context).size.height / 3.5,
            ),
            SizedBox(height: 32),
            Text(
              "Let's stop the spread TOGETHER !",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ProjectColors.BLACK,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 16),
            Divider(indent: 16, endIndent: 16),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Are you detected positive?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ProjectColors.ACCENT_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 130,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.DETECT_COVID_PAGE);
                    },
                    child: Text(
                      'Detected\nPositive',
                      textAlign: TextAlign.center,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ProjectColors.SECONDARY_COLOR),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(indent: 16, endIndent: 16),
            SizedBox(height: 16),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class CovidPostiveNegativeRadioButton extends StatelessWidget {
  const CovidPostiveNegativeRadioButton({
    Key? key,
    required this.value,
  }) : super(key: key);

  final CovidPostiveNegative value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: Text(
          value == CovidPostiveNegative.NEGATIVE ? 'Negative' : 'Postive',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: ProjectColors.BLACK),
        ),
        leading: Radio<CovidPostiveNegative>(
          value: value,
          groupValue: CovidPostiveNegative.NEGATIVE,
          onChanged: (CovidPostiveNegative? value) {},
          activeColor: ProjectColors.PRIMARY_COLOR,
        ),
      ),
    );
  }
}
