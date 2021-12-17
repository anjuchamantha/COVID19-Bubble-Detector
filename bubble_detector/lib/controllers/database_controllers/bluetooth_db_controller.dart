import 'package:bubble_detector/models/beacon.dart';
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

    // var contacts = [];

    // beaconMsgs.forEach((k, b) {
    //   contacts.add({
    //     "user": b.phone,
    //     "distance": b.accuracy,
    //     "timestamp": DateTime.now()
    //   });
    // });

    // // Call the user's CollectionReference to add a new user
    // await userRef.update({
    //   'contacts': FieldValue.arrayUnion(contacts),
    // }).then((value) {
    //   print("Contacted Users updated");
    //   Get.snackbar("Successfull", "Contacted Users updated");
    // }).catchError((error) {
    //   print("Failed to update user Contacted Users: $error");
    //   Get.snackbar("ERROR", "Failed to update Contacted Users");
    // });

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
  }

  // getUsersWithBluetoothID(List<String> bluetoothIDs) async {
  //   List<String> users = [];
  //   var result = await firestore
  //       .collection("users")
  //       .where("bluetooth_id", whereIn: bluetoothIDs)
  //       .get();
  //   result.docs.forEach((res) {
  //     print(res.data());
  //     users.add(res.id);
  //     nearbyUsers.add(res.id);
  //   });
  //   print(users);
  //   print("[FIREBASE]");
  //   updateContactedUsers(users);
  // }
}
