import 'dart:async';

import 'package:bubble_detector/controllers/bluetooth_controllers/requirement_state_controller.dart';
import 'package:bubble_detector/controllers/database_controllers/bluetooth_db_controller.dart';
import 'package:bubble_detector/models/beacon.dart';
import 'package:bubble_detector/util/constants.dart';
import 'package:get/get.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class BeaconController extends GetxController {
  RequirementStateController requirementsController =
      Get.isRegistered<RequirementStateController>()
          ? Get.find<RequirementStateController>()
          : Get.put(RequirementStateController());

  BluetoothDBController bluetoothDBController =
      Get.isRegistered<BluetoothDBController>()
          ? Get.find<BluetoothDBController>()
          : Get.put(BluetoothDBController());

  bool get broadcastReady =>
      requirementsController.authorizationStatusOk == true &&
      requirementsController.locationServiceEnabled == true &&
      requirementsController.bluetoothEnabled == true;
  RxBool isBeaconBroadcasting = false.obs;
  RxBool isBeaconScanning = false.obs;
  var beaconMajor = ''.obs;
  var beaconMinor = ''.obs;
  final broadcastBeacon = BeaconMsg("uuid", 0, 0, 0.0).obs;

  StreamSubscription<RangingResult>? _streamRanging;
  final _regionBeacons = <Region, List<Beacon>>{};
  final beacons = <Beacon>{}.obs;
  final beaconMsgs = {}.obs;

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
    // isBeaconScanning.value = await flutterBeacon.isBroadcasting();
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
        // identifier: "Cubeacon",
        proximityUUID: APP_UUID,
        major: int.tryParse(major) ?? 0,
        minor: int.tryParse(minor) ?? 0,
      ));
      beaconMajor.value = major;
      beaconMinor.value = minor;
      broadcastBeacon.update((val) {
        val?.uuid = APP_UUID;
        val?.major = int.tryParse(major) ?? 0;
        val?.minor = int.tryParse(minor) ?? 0;
        val?.setPhoneNumber(major, minor);
      });
    }
    isBeaconBroadcasting.value = await flutterBeacon.isBroadcasting();
  }

  stopBroadcast() async {
    await flutterBeacon.stopBroadcast();
    isBeaconBroadcasting.value = await flutterBeacon.isBroadcasting();
  }

  pauseScanBeacon() async {
    _streamRanging?.pause();
    // beacons.clear();
    isBeaconScanning.value = false;
  }

  clearBeaconList() {
    beacons.clear();
    beaconMsgs.clear();
  }

  scanBeacon() async {
    isBeaconScanning.value = true;
    beacons.clear();
    await flutterBeacon.initializeScanning;
    final regions = <Region>[
      Region(
        identifier: 'Cubeacon',
        proximityUUID: APP_UUID,
      ),
    ];

    if (_streamRanging != null) {
      if (_streamRanging!.isPaused) {
        _streamRanging?.resume();
        return;
      }
    }
    _streamRanging = flutterBeacon.ranging(regions).listen(
      (RangingResult result) {
        print(result);
        _regionBeacons[result.region] = result.beacons;
        // beacons.clear();
        _regionBeacons.values.forEach((list) {
          beacons.addAll(list);

          list.forEach((b) {
            BeaconMsg msg =
                BeaconMsg(b.proximityUUID, b.major, b.minor, b.accuracy);
            beaconMsgs[b.minor.toString()] = msg;
            // beaconMsgs.add(msg);
          });
        });
        // beacons.sort(_compareParameters);
      },
    );
  }

  int _compareParameters(Beacon a, Beacon b) {
    int compare = a.proximityUUID.compareTo(b.proximityUUID);

    if (compare == 0) {
      compare = a.major.compareTo(b.major);
    }

    if (compare == 0) {
      compare = a.minor.compareTo(b.minor);
    }

    return compare;
  }

  updateContactedUsers() {
    bluetoothDBController.updateContactedUsers(beaconMsgs);
  }
}
