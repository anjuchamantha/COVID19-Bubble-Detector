import 'dart:isolate';
import 'dart:math';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class ForegroundTaskHandler extends TaskHandler {
  String name = '';

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
        notificationText: 'Bubble Detector is keeping you safe 😃');

    name = _runForegroundTask();

    // Send data to the main isolate.
    sendPort?.send(timestamp);
    sendPort?.send(name);
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    // You can use the clearAllData function to clear all the stored data.
    await FlutterForegroundTask.clearAllData();
  }

  //Todo: Replace this with the correct method
  String _runForegroundTask() {
    var randomChars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var length = Random().nextInt(10);
    var result = '';
    for (var i = 0; i < length; i++) {
      result += randomChars[Random().nextInt(randomChars.length - 1)];
    }
    return result;
  }
}
