import 'package:flutter/material.dart';

import '../../util/routes.dart';
import 'HomePageFirst.dart';

class DirectContactHomePageFirst extends StatelessWidget {
  const DirectContactHomePageFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageFirst(
      title: 'Marked as a direct contact ',
      mainText: "Get yourself checked \nLet's stop the spread together!",
      subtitle: "Keep you can your loved ones safe from \nCOVID 19 virus 😇",
      backgroundColor: Colors.red[400],
      redriectPage: AppRoutes.COVID_TEST,
      healthTipsTop: 140,
    );
  }
}
