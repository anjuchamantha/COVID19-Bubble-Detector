import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(
              width: 4 * MediaQuery.of(context).size.width / 5,
              child: Image(
                image: AssetImage('images/logo.png'),
              ),
            ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage('images/splash_bottom.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
