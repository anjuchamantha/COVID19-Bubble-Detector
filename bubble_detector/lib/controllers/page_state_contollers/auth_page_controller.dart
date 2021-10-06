import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LandingPagesController/landing_pages_controller.dart';

class AuthPageController extends GetxController {
  final LandingPagesController landingPagesController = Get.find();
  final phoneNumberInputController = TextEditingController();
  final otpInputController = TextEditingController();
  var auth = FirebaseAuth.instance;
  var verId = '';

  final otp = "".obs;

  Future<void> _waitOtp() async {
    if (otp.value == "") {
      await 200.milliseconds.delay();
      return _waitOtp();
    }
  }

  phoneAuth(String phoneNumber) async {
    await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 120),
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          otp.value = credential.toString();
          await auth.signInWithCredential(credential);
          if (auth.currentUser != null) {
            Get.snackbar("SMS OTP", "Automatic Login Successful");

            landingPagesController.increaseStepCounter();
            landingPagesController.nextLandingPage();
          } else {
            Get.snackbar("ERROR", "Error in Automatic Login");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
            Get.snackbar(
                "SMS OTP Failed", "The provided phone number is not valid.");
          } else {
            print(e.code.toString());
            Get.snackbar("SMS OTP Failed", e.code);
          }
          // Handle other errors
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          await _waitOtp();

          String smsCode = otp.value.toString();
          print(smsCode);
          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);
          // Sign the user with the credential
          // Get.snackbar("SMS OTP", "Sign in with sms code");
          print("[SMS OTP] Sign in with sms code");
          await auth.signInWithCredential(credential);
          if (auth.currentUser != null) {
            Get.snackbar("SMS OTP", "Login Successful");

            landingPagesController.increaseStepCounter();
            landingPagesController.nextLandingPage();
          } else {
            Get.snackbar("ERROR", "Error SMS-OTP Login");
          }
        },
        codeAutoRetrievalTimeout: (String id) {
          this.verId = id;
        });
  }
}
