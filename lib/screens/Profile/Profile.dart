import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/screens/Authentification/log_in.dart';
import 'package:shedmedd/screens/Profile/ProfileSettings.dart';

import '../../config/searchArguments.dart';
import '../Shop/Home.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Shop(currentIndex: 0)),
            (route) => false);
        return false;
      },
      child: Scaffold(
        drawer: Drawer(),
        backgroundColor: CustomColors.bgColor,
        body: ListView(
          padding: EdgeInsets.all(28),
          children: [
            // First Section: Profile Information
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icon for Settings
                    // Profile Picture
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/profile_picture.png'),
                    ),
                    // Add padding between the image and the name
                    SizedBox(width: 20),
                    // Name and Email of the Person
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: CustomColors.textPrimary,
                            fontSize: TextSizes.title - 6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'johndoe@gmail.com',
                          style: TextStyle(
                            color: CustomColors.textPrimary,
                            fontSize: TextSizes.subtitle - 4,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      // Add padding to the right
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            isHovered = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            isHovered = false;
                          });
                        },
                        child: Transform.rotate(
                          angle: isHovered ? 0.5 : 0,
                          child: IconButton(
                            icon: Image.asset(
                              'assets/icons/edit_profile.png',
                              width: 24,
                            ),
                            onPressed: () {
                              // Handle settings icon press
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileSettings()),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Second Section: Options Box
            Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: CustomColors.grey,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // My Products
                  _buildOptionItem('shopping_bag.png', 'My Products', () {
                    Navigator.pushNamed(context, '/discover/results',
                        arguments: SearchArguments('My Products', true, true));
                  }),
                  Divider(),
                  // Rate This App
                  _buildOptionItem('star.png', 'Rate This App', () {
                    Navigator.pushNamed(context, '/rateApp');
                  }),
                  Divider(),
                  // Log Out
                  _buildOptionItem('logout.png', 'Log Out', () {
                    _showLogoutConfirmationDialog();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(String icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/${icon}',
              width: 20,
              color: CustomColors.textPrimary,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: CustomColors.textPrimary,
                fontSize: TextSizes.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop();
      Get.offAll(LogIn());
    } catch (e) {
      print("Error during logout: $e");
      // Handle errors if needed
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color to white
          title: Text(
            'Logout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: TextStyle(
              fontSize: TextSizes.medium,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: TextSizes.medium,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _signOut();
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: TextSizes.medium,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
