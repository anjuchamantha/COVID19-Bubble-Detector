import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
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

  static String major() {
    User? user = FirebaseAuth.instance.currentUser;
    var phoneNumber = user!.phoneNumber;
    log("User Phone Number : " + phoneNumber.toString());

    var major = phoneNumber?.substring(4, 8) ?? "";
    return major;
  }

  static String minor() {
    User? user = FirebaseAuth.instance.currentUser;
    var phoneNumber = user!.phoneNumber;
    log("User Phone Number : " + phoneNumber.toString());

    var minor = phoneNumber?.substring(8) ?? "";
    return minor;
  }

  static handleOpenBluetooth(BuildContext context, Function callback) async {
    if (Platform.isAndroid) {
      try {
        await flutterBeacon.openBluetoothSettings.then((value) {
          callback();
        });
      } on PlatformException catch (e) {
        print(e);
      }
    } else if (Platform.isIOS) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bluetooth is Off'),
            content: Text('Please enable Bluetooth on Settings > Bluetooth.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  static handleOpenLocationSettings(
      BuildContext context, Function callback) async {
    if (Platform.isAndroid) {
      await flutterBeacon.openLocationSettings.then((value) {
        callback();
      });
    } else if (Platform.isIOS) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Location Services Off'),
            content: Text(
              'Please enable Location Services on Settings > Privacy > Location Services.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
