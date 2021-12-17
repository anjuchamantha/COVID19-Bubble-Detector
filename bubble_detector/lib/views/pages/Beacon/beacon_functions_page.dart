import 'dart:ffi';

import 'package:bubble_detector/controllers/bluetooth_controllers/beacon_controller.dart';
import 'package:bubble_detector/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeaconFunctionsPage extends StatelessWidget {
  const BeaconFunctionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final beaconController = Get.isRegistered<BeaconController>()
        ? Get.find<BeaconController>()
        : Get.put(BeaconController());
    User? user = FirebaseAuth.instance.currentUser;
    var phoneNumber = user!.phoneNumber;
    print("User Phone Number : " + phoneNumber.toString());
    var major = phoneNumber?.substring(4, 8) ?? "";
    var minor = phoneNumber?.substring(8) ?? "";
    // final beaconController = Get.put(BeaconController());
    return Scaffold(
      appBar: AppBar(title: Text("Beacon Functions Page")),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                ListTile(
                  title: Obx(
                    () {
                      return (beaconController.isBeaconBroadcasting.value)
                          ? ElevatedButton(
                              child: Text('Stop Broadcast'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[900],
                              ),
                              onPressed: () {
                                beaconController.stopBroadcast();
                              },
                            )
                          : ElevatedButton(
                              child: Text('Broadcast'),
                              onPressed: () {
                                beaconController.startBroadcast(
                                    APP_UUID, major, minor);
                              },
                            );
                    },
                  ),
                ),
                Obx(() {
                  return (beaconController.isBeaconBroadcasting.value)
                      ? Container(
                          padding: EdgeInsets.fromLTRB(16, 2, 16, 2),
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.red[900],
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.deepOrange,
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        );
                }),
                // Text(
                //   "Broadcast Details",
                //   // style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Text("UUID   : "),
                      // Text(
                      //   "$APP_UUID",
                      //   style: TextStyle(color: Colors.grey),
                      // ),
                      // Obx(() {
                      //   return Text(
                      //       "Major : ${beaconController.beaconMajor.value}");
                      // }),
                      // Obx(() {
                      //   return Text(
                      //       "Minor : ${beaconController.beaconMinor.value}");
                      // }),
                      Obx(() {
                        return Text(
                            "Phone Number: ${beaconController.broadcastBeacon.value.phone}");
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Column(
              children: [
                ListTile(
                  title: Obx(
                    () {
                      return (beaconController.isBeaconScanning.value)
                          ? ElevatedButton(
                              child: Text('Stop Scan'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[900],
                              ),
                              onPressed: () {
                                beaconController.pauseScanBeacon();
                              },
                            )
                          : ElevatedButton(
                              child: Text('Scan'),
                              onPressed: () {
                                beaconController.scanBeacon();
                              },
                            );
                    },
                  ),
                ),
                Obx(() {
                  return (beaconController.isBeaconScanning.value)
                      ? Container(
                          padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.red[900],
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.deepOrange,
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                        );
                }),
                Text(
                  "Nearby Users",
                  // style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  int beaconCount = beaconController.beaconMsgs.length;
                  if (beaconCount != 0) {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: beaconCount,
                          itemBuilder: (ctxt, index) {
                            String key = beaconController.beaconMsgs.keys
                                .elementAt(index);
                            // return buildMessage(fcmController.messages[index]);
                            return buildBeaconTile(
                                "${beaconController.beaconMsgs[key].phone}",
                                beaconController.beaconMsgs[key].accuracy);
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              child: Text('Clear List'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[400],
                              ),
                              onPressed: () {
                                beaconController.clearBeaconList();
                              },
                            ),
                            ElevatedButton(
                              child: Text('Mark as contacted'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[400],
                              ),
                              onPressed: () {
                                beaconController.updateContactedUsers();
                              },
                            ),
                          ],
                        )
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No users for now",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildBeaconTile(String name, double distance) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[100],
        ),
        child: Row(
          children: [
            Expanded(child: Text("+94 7 **** ${name.substring(8, 12)}")),
            Text("$distance m"),
          ],
        ),
      ),
    );
  }
}
