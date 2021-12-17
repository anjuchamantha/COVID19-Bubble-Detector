import 'package:bubble_detector/controllers/database_controllers/covid_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetectCovidPage extends StatelessWidget {
  const DetectCovidPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CovidController covidController = Get.find();
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
            Column(
              children: [
                Obx(() {
                  var now = covidController.dateSelected.value;
                  String formattedDate = DateFormat.yMMMMd('en_US').format(now);
                  return Column(
                    children: [
                      Text(
                        "Date of COVID Detection :",
                        style: TextStyle(fontSize: 16),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.grey[200],
                        child: Text(
                          "$formattedDate",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ],
                  );
                }),
                ElevatedButton(
                  onPressed: () {
                    showAlertDialog(context, covidController);
                  },
                  child: Text("Change Date"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, CovidController covidController) {
    final monthAgo = new DateTime.now().subtract(new Duration(days: 30));
    // set up the button

    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: monthAgo,
      maxTime: DateTime.now(),
      theme: DatePickerTheme(
          headerColor: Colors.orange,
          backgroundColor: Colors.blue,
          itemStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
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
