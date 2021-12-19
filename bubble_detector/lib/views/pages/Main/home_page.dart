import 'package:bubble_detector/views/widgets/Direct_Contact_Home_Page_First.dart';
import 'package:bubble_detector/views/widgets/HomePageFirst.dart';
import 'package:bubble_detector/views/widgets/Indirect_Contact_Home_Page_First.dart';
import 'package:bubble_detector/views/widgets/No_Postive_Home_Page_First.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../util/routes.dart';
import '../../../util/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                          'in the last 5 days',
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
                  Positioned(
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          '65',
                          style: TextStyle(
                            fontSize: 72,
                            color: ProjectColors.BLACK,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                          ),
                        ),
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
                              '33',
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
                              '33',
                              style: TextStyle(
                                fontSize: 14,
                                color: ProjectColors.BLACK,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
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
                              '33',
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
                  ),
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
