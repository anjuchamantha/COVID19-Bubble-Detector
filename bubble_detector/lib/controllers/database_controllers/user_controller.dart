import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> addUser(String name, bool isStore) {
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    // Call the user's CollectionReference to add a new user
    return userRef.set({
      'id': user!.uid,
      'isStore': isStore,
      'name': name,
      'phone': user!.phoneNumber
    }).then((value) {
      print("User Added");
      Get.snackbar("User Data Added", "Successfully added User Data.");
    }).catchError((error) {
      print("Failed to add user: $error");
      Get.snackbar("ERROR", "Error saving User Data.");
    });
  }
}
