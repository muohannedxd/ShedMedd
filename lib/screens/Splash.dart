import 'package:flutter/material.dart';
import 'package:shedmedd/screens/Shop/Home.dart';
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
  Future.delayed(Duration(seconds: 2), () {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (_, __, ___) => Shop(currentIndex: 0),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bgColor,
      body: Center(
        child: Image.asset(
          'assets/icons/logo_large.png',
          width: 160,
          height: 160,
          color: CustomColors.textPrimary.withOpacity(0.86),
        ),
      ),
    );
  }
}
