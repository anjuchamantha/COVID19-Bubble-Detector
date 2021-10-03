import 'package:get/get.dart';

import '../../../views/pages/Landing/landing_otp.dart';
import '../../../views/pages/Landing/landing_phone_number.dart';

class LandingPagesController extends GetxController {
  RxInt stepCounter = 1.obs;
  var landingPageState = LandingPhoneNumber().landingId.obs;
  void increaseStepCounter() => stepCounter++;

  /// This returns the next state of the Landing Page Series
  /// [1] - [LandingPhoneNumber]
  /// [2] - [LandingOtp]
  void nextLandingPage(int landingId) {
    landingPageState = landingId.obs + 1;
    this.update();
  }
}
