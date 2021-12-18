import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';

import '../../util/foreground_task_handler.dart';

class ForegroundController extends GetxController {
  ReceivePort? receivePortHome;

  @override
  void onInit() async {
    await initForegroundTask();
    super.onInit();
  }

  @override
  void onClose() {
    receivePortHome?.close();
    super.onClose();
  }

  Future<void> initForegroundTask() async {
    await FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'notification_channel_id',
        channelName: 'Bubble Detector',
        channelDescription: 'Bubble Detector is keeping you safe 😃',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        autoRunOnBoot: true,
        allowWifiLock: true,
      ),
      printDevLog: true,
    );
  }

  Future<bool> startForegroundTask(Function beaconStart) async {
    // You can save data using the saveData function.
    await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');

    ReceivePort? receivePort;
    if (await FlutterForegroundTask.isRunningService) {
      receivePort = await FlutterForegroundTask.restartService();
    } else {
      receivePort = await FlutterForegroundTask.startService(
        notificationTitle: 'Foreground Service is running',
        notificationText: 'Tap to return to the app',
        callback: beaconStart,
      );
    }

    if (receivePort != null) {
      receivePortHome = receivePort;
      receivePortHome!.listen((message) {
        if (message is DateTime) {
          print('receive timestamp: $message');
        } else if (message is int) {
          print('receive updateCount: $message');
        }
      });
      return true;
    }
    return false;
  }

  Future<bool> stopForegroundTask() async {
    return await FlutterForegroundTask.stopService();
  }
}
