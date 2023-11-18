import 'package:flutter/material.dart';
import 'package:shedmedd/components/button.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/screens/Shop/shop.dart';
import 'package:shedmedd/screens/authentification/sign_up.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800]!.withOpacity(0.8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 350,
            ),
            Text(
              'Welcome to ShedMedd',
              style: TextStyle(
                fontSize: TextSizes.verybig,
                color: CustomColors.white,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Button(
                title: 'Get Started',
                action: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SignUp()));
                })
          ],
        ),
      ),
    );
  }
}
