import 'package:bubble_detector/controllers/page_state_contollers/auth_page_controller.dart';
import 'package:get/get.dart';

class LandingOuterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthPageController());
  }
}
