import 'dart:async';

import 'package:bubble_detector/controllers/database_controllers/bluetooth_db_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class MainBluetoothController extends GetxController {
  final bluetoothStatus = false.obs;
  RxBool isDiscovering = false.obs;

  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  BluetoothDBController bluetoothDBController = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Used to enable bluetooth
  // static Future<bool?> enableBluetooth() async {
  //   return FlutterBluetoothSerial.instance.requestEnable();
  // }

  saveContactedUsers() {}

  getUsersWithBluetoothID(List<String> bluetoothIDs) {
    firestore
        .collection('users')
        .where('bluetooth_id', arrayContainsAny: bluetoothIDs)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["id"]);
      });
    });
  }

  List<String> getDiscoveredDevices() {
    if (isDiscovering.value) {
      Get.snackbar("ERROR", "Discovering is not yet completed");
      return [];
    } else {
      List<String> devices = [];
      results.forEach((item) {
        devices.add(item.device.address);
      });
      print(devices);
      Get.snackbar("Discovered Devices: ", "${devices.length}");
      List<String> users = getUsersWithBluetoothID(devices);
      print("USERS : $users");
      return devices;
    }
  }

  void startDiscovery() {
    results.clear();
    Get.snackbar("Discovering", "Discovering nearby devices");
    isDiscovering.value = true;
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen(
      (r) {
        final existingIndex = results.indexWhere(
            (element) => element.device.address == r.device.address);
        if (existingIndex >= 0)
          results[existingIndex] = r;
        else
          results.add(r);
      },
    );

    _streamSubscription!.onDone(
      () {
        isDiscovering.value = false;
        // Get.snackbar("Finished", "Discovering finished");
        getDiscoveredDevices();
      },
    );
  }
}
