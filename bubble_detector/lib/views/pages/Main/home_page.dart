import 'emergency_contact_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TabController _tabController = new TabController(length: 4, vsync: this)

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home_outlined)),
              Tab(icon: Icon(Icons.history)),
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).scaffoldBackgroundColor,
            indicatorColor: Colors.transparent,
            indicatorWeight: 0.1,
          ),
          title: Image(
            image: AssetImage('images/logo.png'),
            width: 150,
          ),
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
                      EmergencyContactPage(),
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
