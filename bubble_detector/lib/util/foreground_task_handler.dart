import 'dart:developer';
import 'dart:isolate';

import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controllers/bluetooth_controllers/beacon_controller.dart';
import 'constants.dart';
import 'ui_util.dart';

class ForegroundTaskHandler extends TaskHandler {
  int updateCount = 0;
  String name = '';

  // final beaconController = Get.isRegistered<BeaconController>()
  //     ? Get.find<BeaconController>()
  //     : Get.put(BeaconController());

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    // You can use the getData function to get the data you saved.

    final customData =
        await FlutterForegroundTask.getData<String>(key: 'customData');
    print('customData: $customData');
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    FlutterForegroundTask.updateService(
      notificationTitle: 'Bubble Detector',
      notificationText: name, // Bubble Detector is keeping you safe 😃
    );
    //await _runForegroundTask();

    sendPort?.send(timestamp);
    sendPort?.send(name);

    updateCount++;
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    // You can use the clearAllData function to clear all the stored data.
    await FlutterForegroundTask.clearAllData();
  }

  // _runForegroundTask() async {
  //   var major = UiUtil.major();
  //   log('asdasdasdasd');
  //   await beaconController.initBroadcastBeacon();

  //   beaconController.isBeaconBroadcasting.value =
  //       await flutterBeacon.isBroadcasting();

  //   await beaconController.startBroadcast(APP_UUID, major, UiUtil.minor());
  // }

  //Todo: Replace this with the correct method
  // Future<String> _runForegroundTask() async {
  //   var randomChars =
  //       'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  //   log(1222);
  //   var length = Random().nextInt(10);
  //   await Future.delayed(Duration(seconds: 2));
  //   var result = '';
  //   for (var i = 0; i < length; i++) {
  //     result += randomChars[Random().nextInt(randomChars.length - 1)];
  //   }
  //   return result;
  // }

  /*  String _runForegroundTask() {
    var randomChars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    log(1222);
    var length = Random().nextInt(10);
    var result = '';
    for (var i = 0; i < length; i++) {
      result += randomChars[Random().nextInt(randomChars.length - 1)];
    }
    return result;
  } */
}
