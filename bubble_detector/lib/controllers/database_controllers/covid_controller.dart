import 'package:bubble_detector/models/contact_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CovidController extends GetxController {
  Rx<DateTime> dateSelected = DateTime.now().obs;
  var daysDuration = 5.obs;
  var hrsDuration = 0.obs;
  var minDuration = 0.obs;
  var secDuration = 0.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final contactedUsers = <ContactUser>[].obs;
  RxBool isLoading = false.obs;
  RxInt storeCount = 0.obs;

  updateDateSelected(DateTime dateTime) {
    print("GET : ${dateTime.toString()}");
    dateSelected.value = dateTime;
    dateSelected.refresh();
    print("COVID DATE: ${dateSelected.toString()}");
  }

  updateDuration(List<dynamic> durations) {
    dateSelected.value = DateTime.now();
    dateSelected.refresh();
    daysDuration.value = durations[0];
    hrsDuration.value = durations[1];
    minDuration.value = durations[2];
    secDuration.value = durations[3];
  }

  getContactedUsers() async {
    isLoading.value = true;
    // contactedUsers.value = [];
    // contactedUsers.refresh();
    dateSelected.value = DateTime.now();
    dateSelected.refresh();
    contactedUsers.clear();
    print("CONTACTS INIT : ${contactedUsers.length}");
    // DateTime bef_ = dateSelected.value.
    var daysAgo = dateSelected.value.subtract(new Duration(
      days: daysDuration.value,
      hours: hrsDuration.value,
      minutes: minDuration.value,
      seconds: secDuration.value,
    ));
    print("DAYS AGO : ${daysAgo.toString()}");
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    var result = await userRef
        .collection("contacts_collection")
        .where('timestamp', isGreaterThanOrEqualTo: daysAgo)
        .get();

    print(result.toString());

    await getContactUserDetails(result);

    // contactedUsers.sort((a, b) => a.distance.compareTo(b.distance));
    // contactedUsers.refresh();
    print("CONTACTS AFTER : ${contactedUsers.length}");
    print("CONTACTS  : $contactedUsers");
    isLoading.value = false;
  }

  Future<void> getContactUserDetails(
      QuerySnapshot<Map<String, dynamic>> result) async {
    result.docs.forEach((res) async {
      print(res.data());
      ContactUser u = ContactUser(
        res['user'],
        DateTime.fromMicrosecondsSinceEpoch(
            res['timestamp'].microsecondsSinceEpoch),
        res['distance'],
      );

      var user = await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: res['user'])
          .get();
      print("FIREBASE USER");

      print(user.docs[0].data());
      u.updateUserData(user.docs[0]['name'], user.docs[0]['id'],
          user.docs[0]['firebase_msg_token'], user.docs[0]['isStore']);
      contactedUsers.add(u);
    });
  }
}
