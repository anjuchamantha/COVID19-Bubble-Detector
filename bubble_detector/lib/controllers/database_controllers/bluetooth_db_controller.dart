import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BluetoothDBController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var nearbyUsers = <String>{}.obs;

  Future<void> updateUserBluetoothID(String bluetoothID) {
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    // Call the user's CollectionReference to add a new user
    return userRef.update({
      'bluetooth_id': bluetoothID,
    }).then((value) {
      print("User Bluetooth ID updated");
      Get.snackbar("Successfull", "User Bluetooth ID updated");
    }).catchError((error) {
      print("Failed to update user Bluetooth ID: $error");
      Get.snackbar("ERROR", "Failed to update user Bluetooth ID");
    });
  }

  updateContactedUsers(RxMap<dynamic, dynamic> beaconMsgs) async {
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    var batch = firestore.batch();

    beaconMsgs.forEach((key, b) {
      var docRef = userRef.collection("contacts_collection").doc();
      batch.set(docRef, {
        "user": b.phone,
        "distance": b.accuracy,
        "timestamp": DateTime.now()
      });
    });

    await batch.commit();
    Get.snackbar("Contacts Updated",
        "${beaconMsgs.length} contacts updated to Database");
  }
}
