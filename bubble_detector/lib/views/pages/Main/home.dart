import 'package:bubble_detector/controllers/bluetooth_controllers/requirement_state_controller.dart';
import 'package:bubble_detector/controllers/database_controllers/user_controller.dart';
import 'package:bubble_detector/util/theme.dart';
import 'package:bubble_detector/util/ui_util.dart';
import 'package:bubble_detector/views/pages/Main/home_page.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

import 'package:flutter_foreground_task/ui/with_foreground_task.dart';

import '../../../util/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'emergency_contact_page.dart';

class Home extends StatelessWidget {
  final RequirementStateController controller =
      Get.find<RequirementStateController>();
  final UserController userCntroller = Get.find();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TabController _tabController = new TabController(length: 4, vsync: this)

    return DefaultTabController(
      length: 2,
      child: WithForegroundTask(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 10),
                      Text('Home'),
                    ],
                  ),
                ),
                Tab(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 10),
                      Text('Emergency'),
                    ],
                  ),
                ),
              ],
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey[400],
              indicatorColor: Colors.transparent,
              indicatorWeight: 0.1,
            ),
            title: Image(
              image: AssetImage('images/logo.png'),
              width: 150,
            ),
            actions: [
              Obx(() {
                if (!controller.locationServiceEnabled)
                  return IconButton(
                    tooltip: 'Not Determined',
                    icon: Icon(Icons.portable_wifi_off),
                    color: Colors.grey,
                    onPressed: () {},
                  );

                if (!controller.authorizationStatusOk)
                  return IconButton(
                    tooltip: 'Not Authorized',
                    icon: Icon(Icons.portable_wifi_off),
                    color: Colors.red,
                    onPressed: () async {
                      await flutterBeacon.requestAuthorization;
                    },
                  );

                return IconButton(
                  tooltip: 'Authorized',
                  icon: Icon(Icons.wifi_tethering),
                  color: ProjectColors.ACCENT_COLOR,
                  onPressed: () async {
                    await flutterBeacon.requestAuthorization;
                  },
                );
              }),
              Obx(() {
                return IconButton(
                  tooltip: controller.locationService.value
                      ? 'Location Service ON'
                      : 'Location Service OFF',
                  icon: Icon(
                    controller.locationService.value
                        ? Icons.location_on
                        : Icons.location_off,
                  ),
                  color: controller.locationService.value
                      ? ProjectColors.ACCENT_COLOR
                      : Colors.red,
                  onPressed: controller.locationService.value
                      ? () {}
                      : () async {
                          await UiUtil.handleOpenLocationSettings(
                              context, controller.checkAllRequirements);
                        },
                );
              }),
              Obx(() {
                final state = controller.bluetoothState.value;

                if (state == BluetoothState.stateOn) {
                  return IconButton(
                    tooltip: 'Bluetooth ON',
                    icon: Icon(Icons.bluetooth_connected),
                    onPressed: () {},
                    color: ProjectColors.ACCENT_COLOR,
                  );
                }

                if (state == BluetoothState.stateOff) {
                  return IconButton(
                    tooltip: 'Bluetooth OFF',
                    icon: Icon(Icons.bluetooth_disabled),
                    onPressed: () {
                      UiUtil.handleOpenBluetooth(
                          context, controller.checkAllRequirements);
                    },
                    color: Colors.red,
                  );
                }

                return IconButton(
                  icon: Icon(Icons.bluetooth_disabled),
                  tooltip: 'Bluetooth State Unknown',
                  onPressed: () {},
                  color: Colors.grey,
                );
              }),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        color: ProjectColors.BLACK,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text(
                      "Beacon",
                      style: TextStyle(
                        color: ProjectColors.BLACK,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text(
                      "Beacon Functions",
                      style: TextStyle(
                        color: ProjectColors.BLACK,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        color: ProjectColors.BLACK,
                      ),
                    ),
                  ),
                ],
                icon: Icon(
                  Icons.more_vert,
                  color: ProjectColors.ACCENT_COLOR,
                ),
                onSelected: (item) {
                  switch (item) {
                    case 0:
                      Get.toNamed(AppRoutes.SETTINGS);
                      break;
                    case 1:
                      Get.toNamed(AppRoutes.BEACON);
                      break;
                    case 2:
                      Get.toNamed(AppRoutes.BEACON_FN_PAGE);
                      break;
                    case 3:
                      userCntroller.signOut();
                      break;
                  }
                },
              ),
            ],
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: Column(
            children: [
              Container(
                child: Divider(),
                transform: Matrix4.translationValues(0.0, -6.0, 0.0),
              ),
              Expanded(
                child: SafeArea(
                  child: TabBarView(
                    children: [
                      HomePage(),
                      EmergencyContactPage(),
                    ],
                    physics: BouncingScrollPhysics(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* import 'dart:isolate';

import 'package:bubble_detector/util/foreground_task_handler.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../../../util/theme.dart';
import 'home_page.dart';
>>>>>>> Stashed changes

import '../../../util/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'emergency_contact_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TabController _tabController = new TabController(length: 4, vsync: this)

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.history)),
              Tab(icon: Icon(Icons.notifications)),
              Tab(icon: Icon(Icons.phone)),
            ],
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey[400],
            indicatorColor: Colors.transparent,
            indicatorWeight: 0.1,
          ),
          title: Image(
            image: AssetImage('images/logo.png'),
            width: 150,
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      color: ProjectColors.BLACK,
                    ),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text(
                    "Beacon",
                    style: TextStyle(
                      color: ProjectColors.BLACK,
                    ),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text(
                    "Beacon Functions",
                    style: TextStyle(
                      color: ProjectColors.BLACK,
                    ),
                  ),
                ),
              ],
              icon: Icon(
                Icons.more_vert,
                color: ProjectColors.ACCENT_COLOR,
              ),
              onSelected: (item) {
                switch (item) {
                  case 0:
                    Get.toNamed(AppRoutes.SETTINGS);
                    break;
                  case 1:
                    Get.toNamed(AppRoutes.BEACON);
                    break;
                  case 2:
                    Get.toNamed(AppRoutes.BEACON_FN_PAGE);
                    break;
                }
              },
            ),
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(
          children: [
            Container(
              child: Divider(),
              transform: Matrix4.translationValues(0.0, -6.0, 0.0),
            ),
            Expanded(
              child: SafeArea(
                child: TabBarView(
                  children: [
                    HomePage(),
                    EmergencyContactPage(),
                    EmergencyContactPage(),
                    EmergencyContactPage(),
                  ],
                  physics: BouncingScrollPhysics(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */