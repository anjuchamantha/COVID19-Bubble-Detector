import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var authenticated = false.obs;
  // FirebaseAuth auth = FirebaseAuth.instance;

  void authenticate() {
    authenticated.toggle();
  }

  void phoneAuth() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+44 7123 123 456',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
