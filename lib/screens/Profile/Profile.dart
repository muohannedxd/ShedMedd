import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/screens/Authentification/log_in.dart';
import 'package:shedmedd/screens/Profile/ProfileSettings.dart';
import 'package:shedmedd/controller/auth/auth_controller.dart';
import 'package:shedmedd/controller/Profile/profileController.dart';
import 'package:shedmedd/utilities/searchArguments.dart';

import '../../components/customCircularProg.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isHovered = false;
  final ProfileController _profileController = ProfileController();
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: CustomColors.bgColor,
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh the user profile when the user pulls down to refresh
          setState(() {});
        },
        child: ListView(
          padding: EdgeInsets.all(28),
          children: [
            FutureBuilder<String?>(
              future: _authController.getCurrentUserId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError || snapshot.data == null) {
                  return Text('Error fetching user ID');
                }

                String userId = snapshot.data!;

                return FutureBuilder<Map<String, dynamic>>(
                  future: _profileController.getOneUserProfile(userId),
                  builder: (context, userSnapshot) {
                    bool isLoading =
                        userSnapshot.connectionState == ConnectionState.waiting;

                    if (isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (userSnapshot.hasError || !userSnapshot.hasData) {
                      return Text('Error fetching user information');
                    }

                    String userName = userSnapshot.data!['name'] ?? '';
                    String userEmail = userSnapshot.data!['email'] ?? '';
                    String initials = userName.toUpperCase().substring(0, 2);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              child: CircleAvatar(
                                backgroundColor: CustomColors.grey,
                                child: ClipOval(
                                    child: CachedNetworkImage(
                                  imageUrl: userSnapshot.data!['profile_pic'],
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                  progressIndicatorBuilder: (context, url,
                                          progress) =>
                                      Center(child: CustomCircularProgress()),
                                  errorWidget: (context, url, error) =>
                                      Center(child: Text(initials)),
                                )),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 140,
                                  child: Text(
                                    userName,
                                    style: TextStyle(
                                      color: CustomColors.textPrimary,
                                      fontSize: TextSizes.title - 6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 140,
                                  child: Text(
                                    userEmail,
                                    style: TextStyle(
                                      color: CustomColors.textPrimary,
                                      fontSize: TextSizes.subtitle - 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
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
                                    onPressed: () async {
                                      bool result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileSettings(),
                                        ),
                                      );
                                      if (result == true) {
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: CustomColors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: CustomColors.grey,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildOptionItem('shopping_bag.png', 'My Products', () {
                    Navigator.pushNamed(context, '/discover/results',
                        arguments: SearchArguments('My Products', true, true));
                  }),
                  Divider(),
                  _buildOptionItem('star.png', 'Rate This App', () {
                    Navigator.pushNamed(context, '/rateApp');
                  }),
                  Divider(),
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
              'assets/icons/$icon',
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
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CustomColors.white,
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
