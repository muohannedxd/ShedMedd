import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/screens/Authentification/sign_up.dart';
import 'package:shedmedd/screens/Shop/DirectMessage.dart';
import 'package:shedmedd/screens/Shop/Discover.dart';
import 'package:shedmedd/screens/Shop/Home.dart';
import 'package:shedmedd/screens/Shop/SearchResults.dart';
import 'package:shedmedd/screens/Splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: CustomColors.bgColor, // Set the status bar color to white
    statusBarIconBrightness: Brightness.dark, // Set the status bar icons to dark
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShedMedd',
      theme: ThemeData(
        fontFamily: 'ProductSans',
      ),
      initialRoute: '/',
      routes: {
        '/shop': (context) => Shop(currentIndex: 0,),
        '/discover': (context) => Discover(),
        '/discover/results': (context) => SearchResults(),
        '/signup': (context) => SignUp(),
        '/message': (context) => DirectMessage(),
      },
      home: const Splash(),
    );
  }
}
