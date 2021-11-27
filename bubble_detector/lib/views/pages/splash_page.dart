import 'package:bubble_detector/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController splashController = Get.find();

  /// Initial page route based on user logged in
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      Future.delayed(Duration(seconds: 2), () {
        bool user = splashController.checkUserLoggedIn();
        if (user) {
          Get.toNamed(AppRoutes.HOME);
        } else {
          Get.toNamed(AppRoutes.LANDING_ONE);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashPageWidget();
  }
}

class SplashPageWidget extends StatelessWidget {
  const SplashPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(
              width: 4 * MediaQuery.of(context).size.width / 5,
              child: Image(
                image: AssetImage('images/logo.png'),
              ),
            ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage('images/splash_bottom.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
