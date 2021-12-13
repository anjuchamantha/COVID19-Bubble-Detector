import 'dart:async';

import 'package:bubble_detector/controllers/bluetooth_controllers/requirement_state_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class BeaconController extends GetxController {
  RequirementStateController requirementsController = Get.find();
  bool get broadcastReady =>
      requirementsController.authorizationStatusOk == true &&
      requirementsController.locationServiceEnabled == true &&
      requirementsController.bluetoothEnabled == true;
  RxBool isBeaconBroadcasting = false.obs;
  var beaconMajor = ''.obs;
  var beaconMinor = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    // requirementsController.startBroadcastStream.listen((flag) {
    //   if (flag == true) {
    //     initBroadcastBeacon();
    //   }
    // });
    initBroadcastBeacon();
    isBeaconBroadcasting.value = await flutterBeacon.isBroadcasting();
  }

  initBroadcastBeacon() async {
    await flutterBeacon.initializeScanning;
  }

  startBroadcast(uuid, major, minor) async {
    if (isBeaconBroadcasting.value) {
      // await flutterBeacon.stopBroadcast();
      Get.snackbar("Already Started", "Broadcast Already Started");
    } else {
      await flutterBeacon.startBroadcast(BeaconBroadcast(
        proximityUUID: uuid,
        major: int.tryParse(major) ?? 0,
        minor: int.tryParse(minor) ?? 0,
      ));
      beaconMajor.value = major;
      beaconMinor.value = minor;
    }
    isBeaconBroadcasting.value = await flutterBeacon.isBroadcasting();
  }

  stopBroadcast() async {
    await flutterBeacon.stopBroadcast();
    isBeaconBroadcasting.value = await flutterBeacon.isBroadcasting();
  }
}
