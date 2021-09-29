import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var verId = '';
  var authStatus = ''.obs;

  var auth = FirebaseAuth.instance;

  // phoneAuth(String phoneNumber) async {
  //   isLoading.value = true;

  //   await auth.verifyPhoneNumber(
  //       timeout: Duration(seconds: 50),
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await auth.signInWithCredential(credential);
  //         if (auth.currentUser != null) {
  //           Get.snackbar("SMS OTP", "Automatic Login Successful");
  //           isLoading.value = false;
  //           authStatus.value = "login successfully";
  //         }
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         if (e.code == 'invalid-phone-number') {
  //           print('The provided phone number is not valid.');
  //         }
  //         Get.snackbar("SMS OTP Failed", e.code);
  //         // Handle other errors
  //       },
  //       codeSent: (String verificationId, int? resendToken) async {
  //         // Update the UI - wait for the user to enter the SMS code
  //         String smsCode = '123456';
  //         // Create a PhoneAuthCredential with the code
  //         PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //             verificationId: verificationId, smsCode: smsCode);
  //         // Sign the user in (or link) with the credential
  //         Get.snackbar("SMS OTP", "Sign in with sms code");
  //         print("[SMS OTP] Sign in with sms code");
  //         await auth.signInWithCredential(credential);
  //         if (auth.currentUser != null) {
  //           Get.snackbar("SMS OTP", "Login Successful");
  //           isLoading.value = false;
  //           authStatus.value = "login successfully";
  //         }
  //       },
  //       codeAutoRetrievalTimeout: (String id) {
  //         this.verId = id;
  //       });
  // }

  // otpVerify(String otp) async {
  //   isLoading.value = true;
  //   try {
  //     UserCredential userCredential = await auth.signInWithCredential(
  //         PhoneAuthProvider.credential(
  //             verificationId: this.verId, smsCode: otp));
  //     if (userCredential.user != null) {
  //       isLoading.value = false;
  //       Get.to(HomeScreen());
  //     }
  //   } on Exception catch (e) {
  //     Get.snackbar("otp info", "otp code is not correct !!");
  //   }
  // }
}
