import 'dart:ui';

import '../../../util/ui_util.dart';
import '../../../util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/landin_page_body_text.dart';

class EmergencyContactPage extends StatelessWidget {
  const EmergencyContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> name = <String>[
      'Notification of Spread',
      'Notification of Spread',
      'Notification of Spread'
    ];
    List<String> phoneNumber = <String>[
      '0112 860 000',
      '0112 860 000',
      '0112 860 000'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            'Emergency Contacts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
              letterSpacing: 0.15,
            ),
          ),
        ),

        SizedBox(height: 12),

        // Main Contact Cards
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: MainContactCard(
                title: 'Suwasariya',
                number: '1990',
                imageLocation: 'doc_emer_cont.svg',
                cardColor: Theme.of(context).primaryColor,
                textColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            Expanded(
              flex: 3,
              child: MainContactCard(
                title: 'Police',
                number: '119',
                imageLocation: 'police_emer_cont.svg',
                cardColor: ProjectColors.TERTIARY_COLOR,
                textColor: ProjectColors.ACCENT_COLOR,
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        // Subtitle
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            'Other Emergency Contacts',
            style: TextStyle(
              fontSize: 16,
              color: ProjectColors.BLACK,
              letterSpacing: 0.15,
            ),
          ),
        ),

        SizedBox(height: 12),

        Expanded(
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: name.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  UiUtil.telephone(phoneNumber[index]);
                },
                child: Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone_rounded,
                        color: ProjectColors.SECONDARY_BLACK,
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LandingPageBodyText(
                            text: name[index],
                            color: ProjectColors.SECONDARY_BLACK,
                            fontWeight: FontWeight.w300,
                          ),
                          Text(
                            phoneNumber[index],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ],
    );
  }
}

/// Main Contact Card used on top of the emergency contact page
class MainContactCard extends StatelessWidget {
  final String title;
  final String number;
  final String imageLocation;
  final Color cardColor;
  final Color textColor;

  const MainContactCard({
    Key? key,
    required this.title,
    required this.number,
    required this.imageLocation,
    required this.cardColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.18 * MediaQuery.of(context).size.height,
      child: InkWell(
        onTap: () {
          UiUtil.telephone(number);
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Title
                LandingPageBodyText(
                  text: this.title,
                  color: this.textColor,
                  fontWeight: FontWeight.w300,
                ),

                SizedBox(height: 10),

                Expanded(
                  child: Container(
                    child: new Stack(
                      children: <Widget>[
                        // SVG Image
                        new Align(
                          alignment: Alignment.bottomRight,
                          child: Opacity(
                            opacity: 0.5,
                            child: SvgPicture.asset('images/$imageLocation'),
                          ),
                        ),

                        // number
                        Text(
                          this.number,
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w900,
                            color: this.textColor,
                            letterSpacing: 0.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          color: this.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 32.0,
            offset: Offset(0, 24),
          ),
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
    );
  }
}
