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
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.SETTINGS);
                    },
                    icon: Icon(
                      Icons.settings_outlined,
                      color: Colors.grey[400],
                    ))),
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
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
            ),
          ],
        ),
      ),
    );
  }
}
