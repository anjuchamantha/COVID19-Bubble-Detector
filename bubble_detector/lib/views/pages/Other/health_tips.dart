import 'package:bubble_detector/util/theme.dart';
import 'package:bubble_detector/views/pages/Main/emergency_contact_page.dart';
import 'package:bubble_detector/views/pages/Main/home_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../util/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthTipsPage extends StatelessWidget {
  const HealthTipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TabController _tabController = new TabController(length: 4, vsync: this)

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text('Health Tips'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  HealthTipCard(
                    title: 'Staying Physically Active',
                    text:
                        'Remember - Just taking a short break from sitting, by doing 3-4 minutes of light intensity physical movement, such as walking or stretching, will help ease your muscles and improve blood circulation and muscle activity.',
                    image: 'exercise',
                  ),
                  HealthTipCard(
                    title: 'Looking after our Mental Health',
                    text:
                        'The new realities of working from home, temporary unemployment, home-schooling of children, and lack of physical contact with other family members, friends and colleagues take time to get used to. Adapting to lifestyle changes such as these, and managing the fear of contracting the virus and worry about people close to us who are particularly vulnerable, are challenging for all of us. They can be particularly difficult for people with mental health conditions.',
                    image: 'music',
                  ),
                  HealthTipCard(
                    title: 'Eating Healthy',
                    text:
                        'While no foods or dietary supplements can prevent or cure COVID-19 infection, healthy diets are important for supporting immune systems. Good nutrition can also reduce the likelihood of developing other health problems, including obesity, heart disease, diabetes and some types of cancer.',
                    image: 'cook',
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class HealthTipCard extends StatelessWidget {
  final String title;
  final String text;
  final String image;

  const HealthTipCard({
    Key? key,
    required this.title,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: ProjectColors.TERTIARY_COLOR.withOpacity(0.05),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          border: Border.all(color: ProjectColors.TERTIARY_COLOR),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ProjectColors.PRIMARY_COLOR,
              ),
            ),
            SizedBox(height: 8),
            Text(text),
            SizedBox(height: 12),
            SvgPicture.asset(
              'images/$image.svg',
              height: MediaQuery.of(context).size.height / 5,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
