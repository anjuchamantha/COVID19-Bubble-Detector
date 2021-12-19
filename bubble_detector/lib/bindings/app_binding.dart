import 'package:bubble_detector/controllers/bluetooth_controllers/beacon_controller.dart';
import 'package:bubble_detector/controllers/bluetooth_controllers/foreground_controller.dart';
import 'package:bubble_detector/controllers/bluetooth_controllers/main_bluetooth_controller.dart';
import 'package:bubble_detector/controllers/bluetooth_controllers/requirement_state_controller.dart';
import 'package:bubble_detector/controllers/database_controllers/bluetooth_db_controller.dart';
import 'package:bubble_detector/controllers/database_controllers/covid_controller.dart';
import 'package:bubble_detector/controllers/database_controllers/pushNotificationController.dart';
import 'package:bubble_detector/controllers/database_controllers/user_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(BluetoothDBController());
    // Get.put(MainBluetoothController());

    // Get.lazyPut(() => UserController());
    Get.put(UserController());
    Get.put(MainBluetoothController());
    Get.put(RequirementStateController());
    // Get.put(UserController());
    Get.put(BeaconController());
    Get.put(ForegroundController());
    Get.put(FCMController());
    Get.put(CovidController());
    // Get.lazyPut<FCMController>(() => FCMController());
    print("app binding");
  }
}
