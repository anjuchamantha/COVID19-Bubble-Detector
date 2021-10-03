import 'package:bubble_detector/views/pages/Landing/landing_otp.dart';
import 'package:bubble_detector/views/pages/Landing/landing_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'landing_page_state.dart';

class LandingPagesController extends GetxController {
  RxInt stepCounter = 1.obs;
  RxInt landingPageState = 1.obs;
  void increaseStepCounter() => stepCounter++;

  /// This returns the next state of the Landing Page Series
  /// [1] - [LandingPhoneNumber]
  /// [2] - [LandingOtp]
  void nextLandingPage() => landingPageState++;
}
