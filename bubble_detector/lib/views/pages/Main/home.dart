import 'package:bubble_detector/util/theme.dart';
import 'package:bubble_detector/views/pages/Main/home_page.dart';

import 'package:flutter_foreground_task/ui/with_foreground_task.dart';

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