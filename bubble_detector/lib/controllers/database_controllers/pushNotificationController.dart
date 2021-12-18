import 'dart:io';

import 'package:bubble_detector/controllers/database_controllers/user_controller.dart';
import 'package:bubble_detector/models/message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FCMController extends GetxController {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //UserController userController = Get.find();
  // final SecureStorageController secureStorageController =
  //     Get.find<SecureStorageController>();
  final messages = <Message>[].obs;
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
    // userController.updateUser("firebase_msg_token", token.toString());

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
    DateTime now = DateTime.now();
    final notification = msg['data'];
    messages.add(
      Message(
        title: notification['title'],
        body: notification['body'],
        dateTime: now,
      ),
    );
    unread.update((_) {
      unread.value = unread.value + 1;
    });
    for (var i in messages) {
      print(i.title);
    }
  }

  void removeMessage(Message msg) {
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

  List<Message> getMessages() {
    return messages;
  }
}
