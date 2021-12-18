import 'dart:convert';

import 'package:bubble_detector/controllers/database_controllers/covid_controller.dart';
import 'package:bubble_detector/util/custom_picker_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetectCovidPage extends StatelessWidget {
  const DetectCovidPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CovidController covidController = Get.find();
    final datePickerController = TextEditingController(text: '0');
    // final hourPickerController = TextEditingController(text: '0');
    // final minPickerController = TextEditingController(text: '0');
    // final secPickerController = TextEditingController(text: '0');
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          "Covid Positive?",
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildDateSection(covidController, context),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                "Get Contacted users within",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Obx(() {
              return GestureDetector(
                onTap: () {
                  showPickerNumber(context, covidController);
                },
                child: Text(
                  "${covidController.daysDuration.value} Days, ${covidController.hrsDuration.value} Hours, ${covidController.minDuration.value} Minutes, ${covidController.secDuration.value} Seconds",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: Obx(() {
                return (covidController.isLoading.value)
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colors.red[900],
                      ))
                    : buildContactedUsersSection(
                        context, covidController, datePickerController);
              }),
            ),
            // buildContactedUsersSection(covidController),
          ],
        ),
      ),
    );
  }

  showPickerNumber(BuildContext context, CovidController covidController) {
    new Picker(
      adapter: NumberPickerAdapter(data: [
        NumberPickerColumn(begin: 0, end: 14),
        NumberPickerColumn(begin: 0, end: 24),
        NumberPickerColumn(begin: 0, end: 60),
        NumberPickerColumn(begin: 0, end: 60),
      ]),
      hideHeader: true,
      title: new Text("Days : Hrs : Mins : Secs"),
      onConfirm: (Picker picker, List value) {
        print(value.toString());
        print(picker.getSelectedValues());
        covidController.updateDuration(picker.getSelectedValues());
      },
    ).showDialog(context);
  }

  Column buildContactedUsersSection(context, CovidController covidController,
      TextEditingController datePicker) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red[900],
          ),
          onPressed: () {
            covidController.getContactedUsers();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Get Contacted Users",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
        Obx(() {
          int notificationCount = covidController.contactedUsers.length;
          if (notificationCount != 0) {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: notificationCount,
                  itemBuilder: (ctxt, index) {
                    String contactedDate = DateFormat('d EEE, MMM yyyy')
                        .format(covidController.contactedUsers[index].dateTime);
                    String dis = covidController.contactedUsers[index].distance
                        .toString()
                        .substring(0, 3);
                    return Column(
                      children: [
                        ListTile(
                          leading: Container(
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black87),
                            child: Center(
                              child: Text(
                                "$dis m",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          title:
                              Text(covidController.contactedUsers[index].phone),
                          subtitle: Text(contactedDate),
                        ),
                      ],
                    );
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
                        // beaconController.clearBeaconList();
                      },
                    ),
                    ElevatedButton(
                      child: Text('Mark as contacted'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[400],
                      ),
                      onPressed: () {
                        // beaconController.updateContactedUsers();
                      },
                    ),
                  ],
                )
              ],
            );
          } else {
            return Center(
              child: Text(
                "Press 'Notify Contacts' button to get the contacted users",
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            );
          }
        }),
      ],
    );
  }

  Container buildDateSection(
      CovidController covidController, BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Obx(() {
            var now = covidController.dateSelected.value;
            String formattedDate = DateFormat('d EEE, MMM yyyy').format(now);
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Date of COVID Detection",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        // color: Colors.grey[200],
                        child: Text(
                          "$formattedDate",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black87,
                      ),
                      onPressed: () {
                        showDatePicker(context, covidController);
                      },
                      child: Icon(Icons.edit_outlined),
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  showDatePicker(BuildContext context, CovidController covidController) {
    final monthAgo = new DateTime.now().subtract(new Duration(days: 30));
    // set up the button

    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: monthAgo,
      maxTime: DateTime.now(),
      theme: DatePickerTheme(
        headerColor: Colors.black87,
        // backgroundColor: Colors.,
        itemStyle: TextStyle(color: Colors.black, fontSize: 18),
        doneStyle: TextStyle(color: Colors.white, fontSize: 16),
        cancelStyle: TextStyle(color: Colors.white),
      ),
      onChanged: (date) {
        covidController.updateDateSelected(date);
        print('change $date in time zone ' +
            date.timeZoneOffset.inHours.toString());
      },
      onConfirm: (date) {
        covidController.updateDateSelected(date);
        print('confirm $date');
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );

    // set up the AlertDialog
    // AlertDialog alert = AlertDialog(
    //   title: Text("Covid Positive?"),
    //   content: Text("Please mention the date of COVID-19 detection."),
    //   actions: [
    //     Obx(() {
    //       var now = covidController.dateSelected.value;
    //       String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    //       return Text(formattedDate);
    //     }),
    //     okButton,
    //   ],
    // );

    // show the dialog
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );
  }
}
