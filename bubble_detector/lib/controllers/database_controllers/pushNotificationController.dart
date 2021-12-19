import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:bubble_detector/controllers/database_controllers/user_controller.dart';
import 'package:bubble_detector/models/notification_msg.dart';
import 'package:bubble_detector/util/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FCMController extends GetxController {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  UserController userController = Get.find();
  // final SecureStorageController secureStorageController =
  //     Get.find<SecureStorageController>();
  final messages = <NotificationMsg>[].obs;
  final unread = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    print("FIREBASE CLOUD MESSAGING INIT");

    // if (Platform.isIOS) {
    //   _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true),
    //   );
    // }
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    String? token = await _firebaseMessaging.getToken();
    print("FirebaseMessaging token: $token");
    userController.updateUser("firebase_msg_token", token.toString());

    // secureStorageController.storeFirebaseToken(token);

    // Handling Message In Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      Get.snackbar("Notificaion", event.notification!.body.toString());
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
      Get.snackbar("Notificaion", message.notification!.body.toString());
    });
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  Future<void> _messageHandler(RemoteMessage message) async {
    print('background message ${message.notification!.body}');
  }

  void addMessage(Map<String, dynamic> msg) {
    // DateTime now = DateTime.now();
    final notification = msg['data'];
    messages.add(
      NotificationMsg(
          notification['title'],
          notification['body'],
          notification['dateTime'],
          notification['distance'],
          notification['isDirect']),
    );
    unread.update((_) {
      unread.value = unread.value + 1;
    });
    for (var i in messages) {
      print(i.title);
    }
  }

  void removeMessage(NotificationMsg msg) {
    messages.remove(msg);
    print("message removed");
    for (var i in messages) {
      print(i.title);
    }
  }

  void resetUnread() {
    unread.update((_) {
      unread.value = 0;
    });
  }

  List<NotificationMsg> getMessages() {
    return messages;
  }

  Future<bool> sendPushNotifications(
      List<String> userTokens, bool isDirect) async {
    var postUrl = Uri.parse(FCM_URL);
    var title;
    var body;
    var direct;
    if (isDirect) {
      direct = "direct";
      title = "COVID Alert - Direct Contact";
      body =
          "A person you have directly contacted recently has detected COVID Positive.";
    } else {
      direct = "indirect";
      title = "COVID Alert - In-Direct Contact";
      body =
          "A person you have indirectly contacted recently through a store has detected COVID Positive.";
    }
    final data = {
      "registration_ids": userTokens,
      "collapse_key": "ALERT",
      "priority": "high",
      "notification": {
        "title": title,
        "body": body,
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      },
      "data": {
        "title": title,
        "body": body,
        "click_action": "FLUTTER_NOTIFICAdaTION_CLICK",
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=$FIREBASE_SERVER_KEY' // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('FCM Success');
      Get.snackbar("Notification sent",
          "${userTokens.length} notifications sent to $direct contacts");
      return true;
    } else {
      print('FCM Error');
      print(response.body.toString());
      Get.snackbar("Notification ERROR",
          "Error sending notifications to $direct contacts");
      // on failure do sth
      return false;
    }
  }
}
