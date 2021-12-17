import 'package:get/get.dart';

class CovidController extends GetxController {
  Rx<DateTime> dateSelected = DateTime.now().obs;

  updateDateSelected(DateTime dateTime) {
    print("GET : ${dateTime.toString()}");
    dateSelected.value = dateTime;
    dateSelected.refresh();
    // dateSelected.update((d) {
    //   d = dateTime;
    //   update();
    // });
    print("COVID DATE: ${dateSelected.toString()}");
  }
}
