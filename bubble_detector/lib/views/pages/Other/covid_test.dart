import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../controllers/page_state_contollers/LandingPagesController/coivd_test_page_controller.dart';
import '../../../util/theme.dart';
import '../../widgets/landing_page_button.dart';

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
              'Have you taken a test for COVID-19 ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ProjectColors.PRIMARY_COLOR,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 64),
            SvgPicture.asset(
              'images/covid_test.svg',
              height: MediaQuery.of(context).size.height / 3.5,
            ),
            SizedBox(height: 64),
            Text(
              'I tested',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: ProjectColors.ACCENT_COLOR),
            ),
            Row(
              children: [
                CovidPostiveNegativeRadioButton(
                  value: CovidPostiveNegative.NEGATIVE,
                ),
                CovidPostiveNegativeRadioButton(
                  value: CovidPostiveNegative.POSTIVE,
                ),
              ],
            ),
            Spacer(),
            LandingPageButton(
              text: 'Completed',
              onPressed: () {},
            ),
            Spacer(),
            SizedBox(height: 8),
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
