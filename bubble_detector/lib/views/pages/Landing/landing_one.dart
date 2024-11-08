import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../util/routes.dart';
import '../../widgets/landin_page_body_text.dart';
import '../../widgets/landing_page_button.dart';

class LandingOne extends StatelessWidget {
  const LandingOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            // Image
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset('images/landing_1.svg'),
            ),

            Spacer(),
            // Welcome Text
            Column(
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24,
                    letterSpacing: 0.18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Bubble Detector',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24,
                    letterSpacing: 0.18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // Body Text
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: LandingPageBodyText(
                text:
                    'Bubble Detector is a mobile application that will save from hassle of writing your name in a book or scanning a QR code when you go to a shop. Because Bubble Detector will do that for you.',
              ),
            ),

            // Let's get started text
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                'Then let’s get started!',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  letterSpacing: 0.15,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Register button
            LandingPageButton(
              onPressed: () {
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Get.offAllNamed(AppRoutes.LANDING_OUTER);
                  //Get.toNamed(AppRoutes.LANDING_OUTER);
                });
              },
              text: 'Register',
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
