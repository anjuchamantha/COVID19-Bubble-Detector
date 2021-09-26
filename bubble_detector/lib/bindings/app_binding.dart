import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    print("app binding");
    Get.put(AuthController(), permanent: true);
  }
}
