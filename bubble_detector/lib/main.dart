import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/home_bindings.dart';
import 'views/pages/home_page.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => HomePage(), binding: HomeBinding()),
      GetPage(name: '/second', page: () => SecondPage()),
    ],
  ));
}
