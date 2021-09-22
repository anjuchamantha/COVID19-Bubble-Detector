import 'package:bubble_detector/bindings/splash_bindings.dart';
import 'package:bubble_detector/util/theme.dart';
import 'package:bubble_detector/views/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'bindings/app_binding.dart';
import 'bindings/home_bindings.dart';
import 'views/pages/home_page.dart';

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
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashPage(),
          binding: SplashBinding(),
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
