import 'package:bubble_detector/bindings/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/pages/home_page.dart';

void main() {
  runApp(GetMaterialApp(
    initialBinding: AppBinding(),
    initialRoute: '/home',
    getPages: [
      GetPage(
        name: '/home',
        page: () => HomePage(),
      ),
      GetPage(
        name: '/second',
        page: () => SecondPage(),
      ),
    ],
  ));
}
