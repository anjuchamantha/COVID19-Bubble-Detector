import '../database_controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get_storage/get_storage.dart';

// import '../../util/ui_util.dart';

class LandingStoreOrIndividualController extends GetxController {
  final nameController = TextEditingController();
  Rx<StoreIndividual?> storeIndividual = StoreIndividual.INDIVIDUAL.obs;
  // final GetStorage _getStorage = UiUtil.getStorage;
  final UserController userController = Get.find();

  void writeToStorage() {
    /* _getStorage.write(UiUtil.NAME, nameController.text);
    _getStorage.write(UiUtil.STOREINDIVIDUAL, storeIndividual.value); */

    print(nameController.text);
    print(storeIndividual);
  }

  void updateStoreIndividual(StoreIndividual? newStoreIndividual) {
    storeIndividual = newStoreIndividual.obs;
    this.update();
  }

  void addUser() {
    bool isStore = true;
    if (storeIndividual.value == StoreIndividual.INDIVIDUAL) {
      isStore = false;
    }
    userController.addUser(nameController.text, isStore);
  }
}

/// Used maintain whether the app is store or indiviual
enum StoreIndividual { INDIVIDUAL, STORE }
