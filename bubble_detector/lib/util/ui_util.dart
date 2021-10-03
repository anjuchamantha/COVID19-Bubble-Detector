import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class UiUtil {
  /// Use this to call the GetStorage in the application
  static final GetStorage getStorage = GetStorage();
  static const String NAME = 'name';
  static const String STOREINDIVIDUAL = 'storeIndividual';

  /// Used to call the [number] passed
  static telephone(String number) async {
    if (await canLaunch('tel:$number')) {
      await launch('tel:$number');
    }
  }

  /// Used to enable bluetooth
  static Future<bool?> enableBluetooth() async {
    return FlutterBluetoothSerial.instance.requestEnable();
  }
}
