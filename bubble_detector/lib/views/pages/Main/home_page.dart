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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          child: Text(
            'Are you detected positive?',
            style: TextStyle(
              fontSize: 14,
              color: ProjectColors.BLACK,
              letterSpacing: 0.2,
            ),
          ),
        ),

        SizedBox(height: 12),

        Expanded(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Material(
                color: const Color(0xcffFF8906),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.DETECT_COVID_PAGE);
                  },
                  splashColor: ProjectColors.ACCENT_COLOR,
                  child: Container(
                    color: Colors.green[400],
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Notify others\nLet's stop the spread together!",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: ProjectColors.BACKGROUND_COLOR,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: ProjectColors.BACKGROUND_COLOR,
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            "But don't worry your personal data will not be revelaed 😇",
                            style: TextStyle(
                              fontSize: 14,
                              color: ProjectColors.BACKGROUND_COLOR,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 140,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.HEALTH_TIPS);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 7.2,
                    width: MediaQuery.of(context).size.width / 1.05,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        SvgPicture.asset('images/doc_emer_cont.svg'),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Health Tips',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ProjectColors.BLACK,
                                  letterSpacing: 0.1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4),
                              Flexible(
                                child: Text(
                                  'What can you do to protect you and your loved ones from COVID 19',
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ProjectColors.ACCENT_COLOR,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: ProjectColors.ACCENT_COLOR,
                          size: 16,
                        ),
                      ],
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 24.0,
                          offset: Offset(0, 16),
                        ),
                        new BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8.0,
                          offset: Offset(0, 4),
                        ),
                        new BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 1.0,
                          offset: Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
