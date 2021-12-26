import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'bindings/app_binding.dart';
import 'bindings/home_page_bindings.dart';
import 'bindings/landing_binding.dart';
import 'bindings/splash_bindings.dart';
import 'util/foreground_task_handler.dart';
import 'util/routes.dart';
import 'util/theme.dart';
import 'views/pages/Beacon/beacon_functions_page.dart';
import 'views/pages/Beacon/beacon_page.dart';
import 'views/pages/Covid/detect_covid_page.dart';
import 'views/pages/Landing/landing_one.dart';
import 'views/pages/Landing/landing_outer.dart';
import 'views/pages/Main/home.dart';
import 'views/pages/Other/covid_test.dart';
import 'views/pages/Other/health_tips.dart';
import 'views/pages/Settings/discovery_page.dart';
import 'views/pages/Settings/main_seetings_page.dart';
import 'views/pages/splash_page.dart';

void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background
  FlutterForegroundTask.setTaskHandler(ForegroundTaskHandler());
}

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
      debugShowCheckedModeBanner: false,
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
          page: () => Home(),
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
        GetPage(
          name: AppRoutes.HEALTH_TIPS,
          page: () => HealthTipsPage(),
        ),
        GetPage(
          name: AppRoutes.COVID_TEST,
          page: () => CovidTestPage(),
        ),
        GetPage(
          name: AppRoutes.BEACON,
          page: () => BeaconPage(),
        ),
        GetPage(
          name: AppRoutes.BEACON_FN_PAGE,
          page: () => BeaconFunctionsPage(),
        ),
        GetPage(
          name: AppRoutes.DETECT_COVID_PAGE,
          page: () => DetectCovidPage(),
        ),
      ],
    ),
  );
}
