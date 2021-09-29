import 'package:bubble_detector/controllers/page_state_contollers/home_page_controller.dart';
import 'package:get/get.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }
}
