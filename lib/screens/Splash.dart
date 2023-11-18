import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Center(
        child: Text(
          'Welcome to ShedMedd',
          style:
              TextStyle(fontSize: TextSizes.verybig, color: CustomColors.white),
        ),
      ),
    );
  }
}
