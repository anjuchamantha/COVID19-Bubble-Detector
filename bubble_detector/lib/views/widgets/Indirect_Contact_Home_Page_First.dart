import 'package:flutter/material.dart';

import '../../util/routes.dart';
import 'HomePageFirst.dart';

class IndirectHomePageFirst extends StatelessWidget {
  const IndirectHomePageFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageFirst(
      title: 'Marked as an indirect contact ',
      mainText: "Get yourself checked \nLet's stop the spread together!",
      subtitle: "Keep you can your loved ones safe from \nCOVID 19 virus 😇",
      backgroundColor: Colors.orange[400],
      redriectPage: AppRoutes.COVID_TEST,
      healthTipsTop: 140,
    );
  }
}
