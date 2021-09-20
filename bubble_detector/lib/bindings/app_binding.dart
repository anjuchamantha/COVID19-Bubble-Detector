import 'package:bubble_detector/controllers/auth_controller.dart';

import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    print("app binding");
    Get.put(AuthController(), permanent: true);
  }
}
