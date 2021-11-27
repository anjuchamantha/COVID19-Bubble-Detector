import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../util/theme.dart';

class HealthTipsPage extends StatelessWidget {
  const HealthTipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _titles = <String>[
      'Staying Physically Active',
      'Looking after our Mental Health',
      'Eating Healthy'
    ];
    List<String> _texts = <String>[
      'Remember - Just taking a short break from sitting, by doing 3-4 minutes of light intensity physical movement, such as walking or stretching, will help ease your muscles and improve blood circulation and muscle activity.',
      'The new realities of working from home, temporary unemployment, home-schooling of children, and lack of physical contact with other family members, friends and colleagues take time to get used to. Adapting to lifestyle changes such as these, and managing the fear of contracting the virus and worry about people close to us who are particularly vulnerable, are challenging for all of us. They can be particularly difficult for people with mental health conditions.',
      'While no foods or dietary supplements can prevent or cure COVID-19 infection, healthy diets are important for supporting immune systems. Good nutrition can also reduce the likelihood of developing other health problems, including obesity, heart disease, diabetes and some types of cancer.',
    ];
    List<String> _images = <String>['exercise', 'music', 'cook'];

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
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: _titles.length,
                itemBuilder: (BuildContext context, int index) {
                  return HealthTipCard(
                    title: _titles[index],
                    text: _texts[index],
                    image: _images[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(indent: 16, endIndent: 16),
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
