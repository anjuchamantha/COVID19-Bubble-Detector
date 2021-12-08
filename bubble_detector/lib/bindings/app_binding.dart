import 'package:bubble_detector/controllers/bluetooth_controllers/main_bluetooth_controller.dart';
import 'package:bubble_detector/controllers/database_controllers/bluetooth_db_controller.dart';
import 'package:bubble_detector/controllers/database_controllers/user_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(BluetoothDBController());
    Get.put(MainBluetoothController());

    // Get.lazyPut(() => UserController());
    // Get.put(UserController());
    Get.put(MainBluetoothController());
    print("app binding");
  }
}
