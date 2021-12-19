import 'package:bubble_detector/controllers/database_controllers/pushNotificationController.dart';
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

  final directcontactedUsers = <ContactUser>[].obs;
  final contactedStores = <ContactUser>[].obs;
  final indirectContactedUsers = <ContactUser>[].obs;
  RxBool isLoading = false.obs;
  // RxInt storeCount = 0.obs;
  final directNotifications = <String>{}.obs;
  final inDirectNotifications = <String>{}.obs;

  FCMController fcmController = Get.find();

  updateDateSelected(DateTime dateTime) {
    print("GET : ${dateTime.toString()}");
    dateSelected.value = dateTime;
    dateSelected.refresh();
    print("COVID DATE: ${dateSelected.toString()}");
  }

  updateDuration(List<dynamic> durations) {
    // dateSelected.value = DateTime.now();
    // dateSelected.refresh();
    daysDuration.value = durations[0];
    hrsDuration.value = durations[1];
    minDuration.value = durations[2];
    secDuration.value = durations[3];
  }

  getContactedUsers() async {
    isLoading.value = true;
    // dateSelected.value = DateTime.now();
    // dateSelected.refresh();
    directcontactedUsers.clear();
    indirectContactedUsers.clear();
    contactedStores.clear();
    print("CONTACTS INIT : ${directcontactedUsers.length}");
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
    print("CONTACTS AFTER : ${directcontactedUsers.length}");
    print("CONTACTS  : $directcontactedUsers");
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
      // print("FIREBASE USER");

      print(user.docs[0].data());
      u.updateUserData(user.docs[0]['name'], user.docs[0]['id'],
          user.docs[0]['firebase_msg_token'], user.docs[0]['isStore']);
      directcontactedUsers.add(u);

      if (u.isStore) {
        contactedStores.add(u);
        await getIndirectContactedUsers(u);
      }
      // isLoading.value = false;
    });
  }

  getIndirectContactedUsers(ContactUser u) async {
    var dateOfContact = u.dateTime;
    print("INDIRECT CONTACTS INIT : ${indirectContactedUsers.length}");
    // var daysAgo = dateSelected.value.subtract(new Duration(
    //   days: daysDuration.value,
    //   hours: hrsDuration.value,
    //   minutes: minDuration.value,
    //   seconds: secDuration.value,
    // ));
    // print("DAYS AGO : ${daysAgo.toString()}");
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(u.userId);
    //TOTO: check for only that contacted date
    var result = await userRef
        .collection("contacts_collection")
        .where(
          'timestamp',
          isGreaterThanOrEqualTo: dateOfContact,
          isLessThanOrEqualTo: dateOfContact.add(Duration(days: 1)),
        )
        .get();

    print(result.toString());
    u.indirects = result.docs.length;

    // Get Firebase details of the users connected
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
      // print("FIREBASE USER");

      print(user.docs[0].data());
      u.updateUserData(user.docs[0]['name'], user.docs[0]['id'],
          user.docs[0]['firebase_msg_token'], user.docs[0]['isStore']);
      indirectContactedUsers.add(u);

      // if (u.isStore) {
      //   contactedStores.add(u);
      //   await getIndirectContactedUsers(u);
      // }
    });

    print("INDIRECT CONTACTS AFTER : ${indirectContactedUsers.length}");
    print("INDIRECT CONTACTS  : $indirectContactedUsers");
    // isLoading.value = false;
  }

  sendNotificationsToAll() async {
    directNotifications.clear();
    inDirectNotifications.clear();
    directcontactedUsers.forEach((element) {
      addToNotificationSet(element, true);
    });
    indirectContactedUsers.forEach((element) {
      addToNotificationSet(element, false);
    });
    await fcmController.sendPushNotifications(
        directNotifications.toList(), true);
    await fcmController.sendPushNotifications(
        inDirectNotifications.toList(), false);
  }

  addToNotificationSet(ContactUser u, bool isDirect) {
    String fcmToken = u.firebaseToken;
    // String contactedDate =
    //     DateFormat('h:m:s a, d EEE, MMM yyyy').format(u.dateTime);

    if (isDirect) {
      // NotificationMsg msg = NotificationMsg(
      //     "COVID Alert",
      //     "Direct Contact [distance ${u.distance.toString()} m] has detected COVID Positive on $contactedDate",
      //     u.dateTime,
      //     u.distance,
      //     isDirect);
      directNotifications.add(fcmToken);
    } else {
      // NotificationMsg msg = NotificationMsg(
      //     "COVID Alert",
      //     "In-direct contact has detected COVID Positive on $contactedDate",
      //     u.dateTime,
      //     u.distance,
      //     isDirect);
      inDirectNotifications.add(fcmToken);
    }
  }
}
