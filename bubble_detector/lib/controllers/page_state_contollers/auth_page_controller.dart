import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LandingPagesController/landing_pages_controller.dart';

class AuthPageController extends GetxController with StateMixin {
  final LandingPagesController landingPagesController = Get.find();
  final phoneNumberInputController = TextEditingController();
  final otpInputController = TextEditingController();
  var auth = FirebaseAuth.instance;
  var verId = '';

  final otp = "".obs;
  final phone = "".obs;

/*   @override
  void onInit() {
    checkUserLoggedIn();
    super.onInit();
  } */

  Future<void> _waitOtp() async {
    if (otp.value == "") {
      await 200.milliseconds.delay();
      return _waitOtp();
    }
  }

  phoneAuth([String? phoneNumber]) async {
    if (phoneNumber != null) {
      phone.value = phoneNumber;
    }

    await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 120),
        phoneNumber: phone.value,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // otp.value = credential.toString();
          try {
            await auth.signInWithCredential(credential);
            Get.snackbar(
              "Login Successful",
              "SMS OTP Automatic Login Successful",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
            );

            landingPagesController.increaseStepCounter();
            landingPagesController.nextLandingPage();
          } catch (e) {
            Get.snackbar("ERROR", e.toString(), duration: 5000.milliseconds);
            print(e.toString());
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
          print("OTP: " + smsCode);
          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);
          // Sign the user with the credential
          // Get.snackbar("SMS OTP", "Sign in with sms code");
          print("[SMS OTP] Sign in with sms code");
          try {
            await auth.signInWithCredential(credential);
            Get.snackbar("Login Successful", "SMS OTP Login Successful");

            landingPagesController.increaseStepCounter();
            landingPagesController.nextLandingPage();
          } catch (e) {
            if (e.hashCode == 21005953 && auth.currentUser != null) {
              print("User alredy logged in via Automatic Login");
            } else {
              Get.snackbar("ERROR", "Invalid OTP", duration: 5000.milliseconds);
              print(e.toString());
              print(e.hashCode);
            }
            otp.value = "";
            this.phoneAuth();
          }
        },
        codeAutoRetrievalTimeout: (String id) {
          this.verId = id;
        });
  }
}
