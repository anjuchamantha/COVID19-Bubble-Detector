import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CovidController extends GetxController {
  Rx<DateTime> dateSelected = DateTime.now().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final contactedUsers = <User>[].obs;

  updateDateSelected(DateTime dateTime) {
    print("GET : ${dateTime.toString()}");
    dateSelected.value = dateTime;
    dateSelected.refresh();
    print("COVID DATE: ${dateSelected.toString()}");
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

  getContactedUsers() async {
    List<String> users = [];
    // DateTime bef_ = dateSelected.value.
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    var result = await userRef
        .collection("contacts_collection")
        .where('contacts_collection.timestamp',
            isLessThanOrEqualTo: dateSelected.value.toString())
        .get();
    print(result.toString());
    result.docs.forEach((res) {
      print(res.data());
      users.add(res.id);
    });
    print(users);
  }
}
