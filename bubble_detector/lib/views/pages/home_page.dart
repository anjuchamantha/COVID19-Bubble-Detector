import 'package:bubble_detector/controllers/page_controller.dart';
import 'package:bubble_detector/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.find();
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  'Authenticated: ${authController.authStatus.value}',
                )),
            Obx(() => Text(
                  'clicks: ${homeController.count}',
                )),
            ElevatedButton(
              child: Text('Next Route'),
              onPressed: () {
                Get.toNamed('/second');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => homeController.increment(),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final AuthController authController = Get.find();
  final HomeController homeController = Get.find();
  @override
  Widget build(context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => homeController.increment(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  'Authenticated: ${authController.authStatus.value.toString()}',
                )),
            Obx(() => Text(
                  'clicks: ${homeController.count}',
                )),
            ElevatedButton(
              child: Text('Authenticate'),
              onPressed: () {
                authController.phoneAuth("+94778396415");
              },
            ),
          ],
        ),
      ),
    );
  }
}
