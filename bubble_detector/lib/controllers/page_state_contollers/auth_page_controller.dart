import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPageController extends GetxController {
  final phoneNumberInputController = TextEditingController();
  final otpInputController = TextEditingController();

  var verId = '';

  final phoneNumberEntered = false.obs;
  final otpEntered = false.obs;
  final otp = "".obs;
  var isLoading = false.obs;
  var authStatus = ''.obs;
  var auth = FirebaseAuth.instance;

  Future<void> _waitOtp() async {
    if (!otpEntered.value) {
      await 200.milliseconds.delay();
      return _waitOtp();
    }
  }

  phoneAuth(String phoneNumber) async {
    phoneNumberEntered.value = true;
    isLoading.value = true;

    await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 120),
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          if (auth.currentUser != null) {
            Get.snackbar("SMS OTP", "Automatic Login Successful");
            isLoading.value = false;
            authStatus.value = "login successfully";
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          Get.snackbar("SMS OTP Failed", e.code);
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
          // Sign the user in (or link) with the credential
          Get.snackbar("SMS OTP", "Sign in with sms code");
          print("[SMS OTP] Sign in with sms code");
          await auth.signInWithCredential(credential);
          if (auth.currentUser != null) {
            Get.snackbar("SMS OTP", "Login Successful");
            isLoading.value = false;
            authStatus.value = "login successfully";
          }
        },
        codeAutoRetrievalTimeout: (String id) {
          this.verId = id;
        });
  }

  void phoneNumberEnteredTrue() {
    phoneNumberEntered.value = true;
  }
}
