import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'bindings/app_binding.dart';
import 'bindings/home_bindings.dart';
import 'bindings/splash_bindings.dart';
import 'util/theme.dart';
import 'views/pages/Landing/landing_one.dart';
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
      initialRoute: '/landing_one',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashPage(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: '/landing_one',
          page: () => LandingOne(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/second',
          page: () => SecondPage(),
        ),
      ],
    ),
  );
}
