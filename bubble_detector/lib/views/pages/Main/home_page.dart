import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/database_controllers/covid_controller.dart';
import '../../../util/routes.dart';
import '../../../util/theme.dart';
import '../../widgets/Indirect_Contact_Home_Page_First.dart';

class HomePage extends StatelessWidget {
  final CovidController covidController = Get.find();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        /// Change this with [DirectContactHomePage] and [NoPostiveHomePage]
        Expanded(
          child: IndirectHomePageFirst(),
        ),

        SizedBox(height: 8),

        Divider(endIndent: 16, indent: 16),

        SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total People Contacted',
                          style: TextStyle(
                            fontSize: 14,
                            color: ProjectColors.BLACK,
                            letterSpacing: 0.2,
                          ),
                        ),
                        Text(
                          'in the last ${covidController.daysDuration.value} days',
                          style: TextStyle(
                            fontSize: 12,
                            color: ProjectColors.ACCENT_COLOR,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(height: 6),
                        SvgPicture.asset(
                          'images/Group 2.svg',
                          height: MediaQuery.of(context).size.height / 3.8,
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    int contactedUsersCount =
                        covidController.directcontactedUsers.length;
                    int storeCount = covidController.contactedStores.length;
                    int indirectCount =
                        covidController.indirectContactedUsers.length;
                    int allCount = contactedUsersCount + indirectCount;
                    if (contactedUsersCount != 0) {
                      return Positioned(
                        right: 0,
                        child: Column(
                          children: [
                            // Total Count
                            Text(
                              allCount.toString(),
                              style: TextStyle(
                                fontSize: 72,
                                color: ProjectColors.BLACK,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),

                            // Direct Count
                            Row(
                              children: [
                                Text(
                                  'Direct Contacts : ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ProjectColors.BLACK,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                Text(
                                  contactedUsersCount.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ProjectColors.BLACK,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 4),

                            // Store Count
                            Row(
                              children: [
                                Text(
                                  'Stores Entered : ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ProjectColors.BLACK,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                Text(
                                  storeCount.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ProjectColors.BLACK,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),

                            // indirect count
                            Row(
                              children: [
                                Text(
                                  'Indirect Contacts : ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ProjectColors.ACCENT_COLOR,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                Text(
                                  indirectCount.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ProjectColors.ACCENT_COLOR,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Positioned(
                        right: 20,
                        top: 20,
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: -9,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 64,
                                  color: ProjectColors.SECONDARY_BLACK,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                            Text(
                              'Contacts',
                              style: TextStyle(
                                fontSize: 24,
                                color: ProjectColors.SECONDARY_BLACK,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 12),
                  ElevatedButton(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('More Details'),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.DETECT_COVID_PAGE);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        ProjectColors.SECONDARY_COLOR,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
