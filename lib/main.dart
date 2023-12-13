import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/firebase_options.dart';
import 'package:shedmedd/screens/Authentification/sign_up.dart';
import 'package:shedmedd/screens/Post_item/post_an_new_item.dart';
import 'package:shedmedd/screens/Shop/DirectMessage.dart';
import 'package:shedmedd/screens/Shop/Discover.dart';
import 'package:shedmedd/screens/Shop/Home.dart';
import 'package:shedmedd/screens/Shop/QuickSearchResults.dart';
import 'package:shedmedd/screens/Splash.dart';
import 'package:shedmedd/screens/AppSupport/RateAppPage.dart';
import 'package:shedmedd/screens/AppSupport/ChatInbox.dart';
import 'package:shedmedd/screens/Profile/Profile.dart';

void main() async {
  // firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: CustomColors.bgColor, // Set the status bar color to white
    statusBarIconBrightness:
        Brightness.dark, // Set the status bar icons to dark
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShedMedd',
      theme: ThemeData(
        fontFamily: 'ProductSans',
      ),
      initialRoute: '/',
      routes: {
        '/shop': (context) => Shop(
              currentIndex: 0,
            ),
        '/discover': (context) => Discover(),
        '/discover/results': (context) => QuickSearchResults(),
        '/signup': (context) => SignUp(),
        '/message': (context) => DirectMessage(),
        '/post_item': (context) => PostAnItem(),
        '/profile': (context) => const Profile(),
        '/rateApp': (context) => RateAppPage(),
        '/inbox': (context) => ChatInbox(),
      },
      home: const Splash(),
    );
  }
}
