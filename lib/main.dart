import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/database/firebase_options.dart';
import 'package:shedmedd/screens/Authentification/sign_up.dart';
import 'package:shedmedd/screens/Post_item/post_an_new_item.dart';
import 'package:shedmedd/screens/AppSupport/DirectMessage.dart';
import 'package:shedmedd/screens/Shop/Discover.dart';
import 'package:shedmedd/screens/Shop/Home.dart';
import 'package:shedmedd/screens/Shop/QuickSearchResults.dart';
import 'package:shedmedd/screens/Splash.dart';
import 'package:shedmedd/screens/AppSupport/RateAppPage.dart';
import 'package:shedmedd/screens/AppSupport/ChatInbox.dart';
import 'package:shedmedd/screens/Profile/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // firebase configurations
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // dotenv
  await dotenv.load(fileName: '.env');

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: CustomColors.bgColor, // Set the status bar color to white
    statusBarIconBrightness:
        Brightness.dark, // Set the status bar icons to dark
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

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
        '/inbox': (context) => ChatInbox(),
        '/message': (context) => DirectMessage(),
        '/post_item': (context) => PostAnItem(),
        '/profile': (context) => const Profile(),
        '/rateApp': (context) => RateAppPage(),
      },
      home: const Splash(),
      navigatorKey: navigatorKey,
    );
  }
}
