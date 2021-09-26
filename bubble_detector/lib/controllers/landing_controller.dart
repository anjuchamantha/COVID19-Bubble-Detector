import 'package:get/get.dart';

class LandingController extends GetxController {
  var currentStep = 1.obs;
  void incrementCurrentStep() => currentStep++;
  void decrementCurrentStep() => currentStep--;
}
