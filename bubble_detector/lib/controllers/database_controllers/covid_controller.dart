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

  updateDateSelected(DateTime dateTime) {
    print("GET : ${dateTime.toString()}");
    dateSelected.value = dateTime;
    dateSelected.refresh();
    print("COVID DATE: ${dateSelected.toString()}");
  }

  updateDuration(List<dynamic> durations) {
    daysDuration.value = durations[0];
    hrsDuration.value = durations[1];
    minDuration.value = durations[2];
    secDuration.value = durations[3];
  }

  getContactedUsers() async {
    isLoading.value = true;
    contactedUsers.value = [];
    // DateTime bef_ = dateSelected.value.
    final daysAgo = dateSelected.value.subtract(new Duration(
      days: daysDuration.value,
      hours: hrsDuration.value,
      minutes: minDuration.value,
      seconds: secDuration.value,
    ));
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
    isLoading.value = false;
  }
}
