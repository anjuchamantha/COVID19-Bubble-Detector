import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../util/routes.dart';

class SplashController extends GetxController {
  var auth = FirebaseAuth.instance;

  bool checkUserLoggedIn() {
    var user = auth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
