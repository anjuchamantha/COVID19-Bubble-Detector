import 'package:get/get.dart';

import '../controllers/page_state_contollers/LandingPagesController/landing_pages_controller.dart';
import '../controllers/page_state_contollers/auth_page_controller.dart';

class LandingOuterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthPageController());
    Get.lazyPut(() => LandingPagesController());
  }
}
