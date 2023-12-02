import 'package:flutter/material.dart';
import '../constants/customColors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/shop');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.buttonPrimary.withOpacity(0.8),
      body: Center(
        child: Image.asset(
          'assets/icons/logo_white_large.png',
          width: 140,
          height: 140,
        ),
      ),
    );
  }
}
