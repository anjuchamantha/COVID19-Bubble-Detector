import 'package:bubble_detector/models/contact_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CovidController extends GetxController {
  Rx<DateTime> dateSelected = DateTime.now().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final contactedUsers = <ContactUser>[].obs;

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
    contactedUsers.value = [];
    // DateTime bef_ = dateSelected.value.
    final daysAgo = dateSelected.value.subtract(new Duration(days: 7));
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    var result = await userRef
        .collection("contacts_collection")
        .where('timestamp', isGreaterThanOrEqualTo: daysAgo)
        .get();

    result.docs.forEach((res) {
      print(res.data());
      ContactUser u = ContactUser(
        res['user'],
        DateTime.fromMicrosecondsSinceEpoch(
            res['timestamp'].microsecondsSinceEpoch),
        res['distance'],
      );
      contactedUsers.add(u);
    });
    contactedUsers.sort((a, b) => a.distance.compareTo(b.distance));
  }
}
