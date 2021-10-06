import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/page_state_contollers/LandingPagesController/landing_pages_controller.dart';
import '../../../controllers/page_state_contollers/landing_store_or_individual_controller.dart';
import '../../widgets/landin_page_body_text.dart';
import '../../widgets/landing_page_button.dart';
import '../../widgets/landing_page_textfield.dart';

class LandingStoreOrIndividual extends StatelessWidget {
  const LandingStoreOrIndividual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LandingPagesController landingPagesController = Get.find();
    final LandingStoreOrIndividualController
        landingStoreOrIndividualController = Get.find();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Store or Individual'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SvgPicture.asset('images/store_or_individual.svg'),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: LandingPageTextField(
            controller: landingStoreOrIndividualController.nameController,
            hintText: "Name",
            keyboardType: TextInputType.name,
            maxLength: 20,
          ),
        ),
        SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<LandingStoreOrIndividualController>(
            builder: (controller) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StoreIndividualRadioButton(
                  landingStoreOrIndividualController: controller,
                  value: StoreIndividual.INDIVIDUAL,
                ),
                StoreIndividualRadioButton(
                  landingStoreOrIndividualController: controller,
                  value: StoreIndividual.STORE,
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LandingPageBodyText(
            text: 'Are you using Bubble Detector as a store or an individual ?',
          ),
        ),
        Spacer(),
        LandingPageButton(
          text: 'Next',
          onPressed: () {
            landingPagesController.increaseStepCounter();
            landingPagesController.nextLandingPage();

            landingStoreOrIndividualController.writeToStorage();
          },
        ),
        Spacer(),
      ],
    );
  }
}

class StoreIndividualRadioButton extends StatelessWidget {
  const StoreIndividualRadioButton({
    Key? key,
    required this.landingStoreOrIndividualController,
    required this.value,
  }) : super(key: key);

  final LandingStoreOrIndividualController landingStoreOrIndividualController;
  final StoreIndividual value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: Text(value == StoreIndividual.STORE ? 'Store' : 'Individual'),
        leading: Radio<StoreIndividual>(
          value: value,
          groupValue: landingStoreOrIndividualController.storeIndividual.value,
          onChanged: (StoreIndividual? value) {
            landingStoreOrIndividualController.updateStoreIndividual(value);
          },
        ),
      ),
    );
  }
}
