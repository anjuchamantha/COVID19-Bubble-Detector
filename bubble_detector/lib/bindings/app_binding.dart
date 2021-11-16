import 'package:bubble_detector/controllers/bluetooth_controllers/main_bluetooth_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(MainBluetoothController());
    print("app binding");
  }
}
