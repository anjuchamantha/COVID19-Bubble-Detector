import 'package:bubble_detector/controllers/auth_controller.dart';
import 'package:bubble_detector/controllers/page_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => HomeController());
  }
}
