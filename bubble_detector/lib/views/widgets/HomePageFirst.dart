import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../util/routes.dart';
import '../../util/theme.dart';

class HomePageFirst extends StatelessWidget {
  final String title;
  final String mainText;
  final String subtitle;
  final Color? backgroundColor;
  final String redriectPage;
  final double healthTipsTop;

  const HomePageFirst({
    Key? key,
    required this.title,
    required this.mainText,
    required this.subtitle,
    required this.backgroundColor,
    required this.redriectPage,
    required this.healthTipsTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          child: Text(
            title,
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
                    Get.toNamed(redriectPage);
                  },
                  splashColor: ProjectColors.ACCENT_COLOR,
                  child: Container(
                    color: backgroundColor,
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
                                mainText,
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
                            subtitle,
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
                top: healthTipsTop,
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
                                  'What can you do to protect you and your loved ones from COVID...',
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
      ],
    );
  }
}
