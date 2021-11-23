import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'bindings/app_binding.dart';
import 'bindings/home_page_bindings.dart';
import 'bindings/landing_binding.dart';
import 'bindings/splash_bindings.dart';
import 'util/routes.dart';
import 'util/theme.dart';
import 'views/pages/Landing/landing_one.dart';
import 'views/pages/Landing/landing_outer.dart';
import 'views/pages/Main/home_page.dart';
import 'views/pages/Settings/discovery_page.dart';
import 'views/pages/Settings/main_seetings_page.dart';
import 'views/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      initialBinding: AppBinding(),
      theme: PrimaryTheme.buildTheme(),
      initialRoute: AppRoutes.SPLASH,
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
          binding: LandingOuterBinding(),
        ),
        GetPage(
          name: AppRoutes.HOME,
          page: () => HomePage(),
          binding: HomePageBinding(),
        ),
        GetPage(
          name: AppRoutes.SETTINGS,
          page: () => MainSettingsPage(),
        ),
        GetPage(
          name: AppRoutes.DISCOVERY,
          page: () => DiscoveryPage(),
        ),
      ],
    ),
  );
}
