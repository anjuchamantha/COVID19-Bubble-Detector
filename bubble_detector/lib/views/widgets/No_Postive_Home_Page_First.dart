import 'package:bubble_detector/util/routes.dart';
import 'package:bubble_detector/views/widgets/HomePageFirst.dart';
import 'package:flutter/material.dart';

class NoPostiveHomePageFirst extends StatelessWidget {
  const NoPostiveHomePageFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageFirst(
      title: 'Are you detected positive?',
      mainText: "Notify others\nLet's stop the spread together!",
      subtitle: "But don't worry your personal data will not be revelaed 😇",
      backgroundColor: Colors.green[400],
      redriectPage: AppRoutes.DETECT_COVID_PAGE,
      healthTipsTop: 140,
    );
  }
}
