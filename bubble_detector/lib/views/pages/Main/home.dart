import 'package:bubble_detector/util/theme.dart';
import 'package:bubble_detector/views/pages/Main/home_page.dart';

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
              ],
              icon: Icon(
                Icons.more_vert,
                color: ProjectColors.ACCENT_COLOR,
              ),
              onSelected: (item) {
                switch (item) {
                  case 0:
                    Get.toNamed(AppRoutes.SETTINGS);
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
