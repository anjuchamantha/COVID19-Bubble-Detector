import 'package:bubble_detector/util/routes.dart';
import 'package:bubble_detector/views/pages/Main/emergency_contact_page.dart';
import 'package:bubble_detector/views/pages/Main/main_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'bindings/app_binding.dart';
import 'bindings/home_bindings.dart';
import 'bindings/splash_bindings.dart';
import 'util/theme.dart';
import 'views/pages/Landing/landing_one.dart';
import 'views/pages/Landing/landing_outer.dart';
import 'views/pages/home_page.dart';
import 'views/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      initialBinding: AppBinding(),
      theme: PrimaryTheme.buildTheme(),
      initialRoute: AppRoutes.MAIN_HOME_PAGE,
      getPages: [
        GetPage(
          name: AppRoutes.SPLASH,
          page: () => SplashPage(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: AppRoutes.LANDING_ONE,
          page: () => LandingOne(),
        ),
        GetPage(
          name: AppRoutes.LANDING_OUTER,
          page: () => LandingOuter(),
        ),
        GetPage(
          name: AppRoutes.MAIN_HOME_PAGE,
          page: () => MainHomePage(),
        ),
        GetPage(
          name: AppRoutes.HOME,
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: AppRoutes.SECOND,
          page: () => SecondPage(),
        ),
      ],
    ),
  );
}
