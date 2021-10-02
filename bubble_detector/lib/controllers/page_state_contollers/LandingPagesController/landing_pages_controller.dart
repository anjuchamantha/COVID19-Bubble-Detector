import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'landing_page_state.dart';

class LandingPagesController extends GetxController {
  RxInt stepCounter = 1.obs;
  RxInt landingPageState = 1.obs;
  //Rx<LandingPageState> landingPageState = LandingPagePhoneNumberState().obs;

  void increaseStepCounter() => stepCounter++;

  // This returns the next state of the Landing Page Series
  /*  void nextLandingPage() {
    landingPageState = landingPageState.value.nextState().obs;
    print(landingPageState.value.runtimeType);
  } */

  void nextLandingPage() => landingPageState++;
}
