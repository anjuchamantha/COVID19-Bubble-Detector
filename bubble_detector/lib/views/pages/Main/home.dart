import 'dart:isolate';

import 'package:bubble_detector/util/foreground_task_handler.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../../../util/theme.dart';
import 'home_page.dart';

import '../../../util/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'emergency_contact_page.dart';

void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(ForegroundTaskHandler());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ReceivePort? _receivePort;

  @override
  void initState() {
    super.initState();
    _HomeForegroundFunctions.initForegroundTask();
    _HomeForegroundFunctions.startForegroundTask(
      _receivePort,
      startCallback,
    );
  }

  @override
  void dispose() {
    _receivePort?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TabController _tabController = new TabController(length: 4, vsync: this)

    return DefaultTabController(
      length: 4,
      child: WithForegroundTask(
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
      ),
    );
  }
}

abstract class _HomeForegroundFunctions {
  static Future<void> initForegroundTask() async {
    await FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'notification_channel_id',
        channelName: 'Bubble Detector',
        channelDescription: 'Bubble Detector is keeping you safe 😃',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        autoRunOnBoot: true,
        allowWifiLock: true,
      ),
      printDevLog: true,
    );
  }

  static Future<bool> startForegroundTask(
      ReceivePort? receivePortHome, Function startCallback) async {
    // You can save data using the saveData function.
    await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');

    ReceivePort? receivePort;
    if (await FlutterForegroundTask.isRunningService) {
      receivePort = await FlutterForegroundTask.restartService();
    } else {
      receivePort = await FlutterForegroundTask.startService(
        notificationTitle: 'Foreground Service is running',
        notificationText: 'Tap to return to the app',
        callback: startCallback,
      );
    }

    if (receivePort != null) {
      receivePortHome = receivePort;
      receivePortHome.listen((message) {
        if (message is DateTime) {
          print('receive timestamp: $message');
        } else if (message is int) {
          print('receive updateCount: $message');
        }
      });

      return true;
    }

    return false;
  }

  static Future<bool> stopForegroundTask() async {
    return await FlutterForegroundTask.stopService();
  }
}
