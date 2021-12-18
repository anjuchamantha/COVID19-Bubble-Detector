import 'package:bubble_detector/controllers/database_controllers/covid_controller.dart';
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
          int contactedUsersCount = covidController.directcontactedUsers.length;
          int storeCount = covidController.contactedStores.length;
          int indirectCount = covidController.indirectContactedUsers.length;
          int allCount = contactedUsersCount + indirectCount;
          if (contactedUsersCount != 0) {
            return Column(
              children: [
                ListTile(
                  trailing: Container(
                    // color: Colors.black,
                    child: Text(
                      "$allCount",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Container(
                    height: 40,
                    width: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[400],
                      ),
                      onPressed: () {
                        covidController.directcontactedUsers
                            .sort((a, b) => a.distance.compareTo(b.distance));
                      },
                      child: Center(
                        child: Text(
                          "Sort",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text("Direct contacts : $contactedUsersCount"),
                  subtitle:
                      Text("Stores : $storeCount Indirect : $indirectCount"),
                ),
                Divider(),
                Container(
                  height: MediaQuery.of(context).size.height - 475,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: contactedUsersCount,
                    itemBuilder: (ctxt, index) {
                      String contactedDate = DateFormat('h:m:s a, d EEE, MMM')
                          .format(covidController
                              .directcontactedUsers[index].dateTime);
                      String dis = covidController
                          .directcontactedUsers[index].distance
                          .toString();
                      return ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        trailing: buildIsStoreIcon(covidController, index),
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
                        title: Text(
                            "+94 7 **** ${covidController.directcontactedUsers[index].phone.substring(8, 12)}"),
                        subtitle: Text(contactedDate),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // ElevatedButton(
                      //   child: Text('Clear List'),
                      //   style: ElevatedButton.styleFrom(
                      //     primary: Colors.grey[400],
                      //   ),
                      //   onPressed: () {
                      //     // beaconController.clearBeaconList();
                      //   },
                      // ),
                      ElevatedButton(
                        child: Text('Notify Alll'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[400],
                        ),
                        onPressed: () {
                          // covidController.directcontactedUsers
                          //     .sort((a, b) => a.dateTime.compareTo(b.dateTime));
                        },
                      ),
                    ],
                  ),
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

  Widget buildIsStoreIcon(CovidController covidController, int index) {
    if (covidController.directcontactedUsers[index].isStore) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart,
            color: Colors.red[900],
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            "${covidController.directcontactedUsers[index].indirects.toString()}",
            style: TextStyle(color: Colors.red[900]),
          ),
        ],
      );
    } else {
      return Icon(
        Icons.person,
        color: Colors.black87,
      );
    }
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
            var dateSelec = covidController.dateSelected.value;
            String formattedDate =
                DateFormat('d EEE, MMM yyyy').format(dateSelec);
            String formattedTime = DateFormat('hh:mm:ss a').format(dateSelec);
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Date of COVID Detection",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        // color: Colors.grey[200],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$formattedDate",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "$formattedTime",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {
                                    covidController.dateSelected.value =
                                        DateTime.now();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                    decoration: BoxDecoration(
                                        // color: Colors.amber,
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.black87)),
                                    child: Text(
                                      "Reset to Now",
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    final currentTime = new DateTime.now().add(Duration(seconds: 1));
    // set up the button

    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: monthAgo,
      maxTime: currentTime,
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
  }
}
