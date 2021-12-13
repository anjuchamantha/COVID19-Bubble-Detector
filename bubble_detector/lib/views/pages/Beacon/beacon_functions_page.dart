import 'package:bubble_detector/controllers/bluetooth_controllers/beacon_controller.dart';
import 'package:bubble_detector/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeaconFunctionsPage extends StatelessWidget {
  const BeaconFunctionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final beaconController = Get.find<BeaconController>();
    return Scaffold(
      appBar: AppBar(title: Text("Beacon Functions Page")),
      body: ListView(
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
                              child: Text('Start Broadcast'),
                              onPressed: () {
                                beaconController.startBroadcast(
                                    APP_UUID, "111", "000");
                              },
                            );
                    },
                  ),
                ),
                Text(
                  "Broadcast Details",
                  // style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("UUID   : "),
                      Text(
                        "$APP_UUID",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Obx(() {
                        return Text(
                            "Major : ${beaconController.beaconMajor.value}");
                      }),
                      Obx(() {
                        return Text(
                            "Minor : ${beaconController.beaconMinor.value}");
                      }),
                      Obx(() {
                        return (beaconController.isBeaconBroadcasting.value)
                            ? Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.red[900],
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.red,
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                              );
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
                  title: ElevatedButton(
                    child: const Text('Scan'),
                    onPressed: () {},
                  ),
                ),
                Text(
                  "Nearby Users",
                  // style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
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
                        Expanded(child: Text("Name")),
                        Text("0.22 m"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
