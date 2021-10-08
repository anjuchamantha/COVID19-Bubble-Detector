import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class MainBluetoothController extends GetxController {
  final bluetoothStatus = false.obs;

  /// Used to enable bluetooth
  // static Future<bool?> enableBluetooth() async {
  //   return FlutterBluetoothSerial.instance.requestEnable();
  // }
}
