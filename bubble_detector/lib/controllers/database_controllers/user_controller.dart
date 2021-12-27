import 'package:bubble_detector/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uuid/uuid.dart';

class UserController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
//   User currentUser = FirebaseAuth.instance.currentUser;
// if (currentUser != null) {
//   await currentUser.reload();
// }

//   User? user = await FirebaseAuth.instance.currentUser;

  Future<void> addUser(String name, bool isStore) {
    User? user = FirebaseAuth.instance.currentUser;
    // var uuid = Uuid();
    print("ADD USER1");
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    // Call the user's CollectionReference to add a new user
    print("ADD USER2");
    return userRef.set({
      'id': user.uid,
      'isStore': isStore,
      'name': name,
      'phone': user.phoneNumber,
      // 'bluetooth_id': uuid.v5(Uuid.NAMESPACE_URL, user!.uid),
    }).then((value) {
      print("User Added");
      // Get.snackbar("User Data Added", "Successfully added User Data.");
    }).catchError((error) {
      print("Failed to add user: $error");
      Get.snackbar("ERROR", "Error saving User Data.");
    });
  }

  Future<void> updateUser(String key, String value) {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    return userRef.update({
      key: value,
    }).then((value) {
      print("User $key updated");
      // Get.snackbar("Successfull", "User $key updated");
    }).catchError((error) {
      print("Failed to update user $key with value $value: Error - $error");
      Get.snackbar("ERROR", "Failed to update user $key with value $value");
    });
  }

  void signOut() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      Get.toNamed(AppRoutes.SPLASH);
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        margin: EdgeInsets.only(bottom: 12, left: 8, right: 8),
        duration: Duration(seconds: 4),
      );
    }
  }
}
