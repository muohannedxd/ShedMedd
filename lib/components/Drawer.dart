import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/components/SidebarButton.dart';
import 'package:shedmedd/components/errorWidget.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/controller/auth/auth_controller.dart';
import 'package:shedmedd/database/usersDB.dart';
import 'package:shedmedd/screens/Authentification/sign_up.dart';
import 'package:shedmedd/screens/Settings/Aboutus.dart';
import 'package:shedmedd/screens/Settings/settings.dart';
import 'package:shedmedd/screens/Settings/terms_of_use.dart';
import 'package:shedmedd/screens/Shop/Home.dart';

import 'customCircularProg.dart';
import 'profileShimmer.dart';

class AppDrawer extends StatefulWidget {
  final int current;
  const AppDrawer({super.key, required this.current});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final AuthController authController = Get.put(AuthController());
  final bool isLoggedIn = AuthController().isLoggedIn();
  final Future<DocumentSnapshot> user = UsersDatabase().getLoggedInUser();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
            backgroundColor: CustomColors.bgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 50),
                      child: LoggedInUser(loggedInUser: user)),
                ),
                SidebarButton(
                  title: 'Homepage',
                  icon: widget.current == 0
                      ? Image.asset(
                          'assets/icons/home_filled.png',
                          width: 20,
                        )
                      : Image.asset(
                          'assets/icons/home.png',
                          width: 20,
                        ),
                  current: widget.current == 0 ? true : false,
                  action: () {
                    //setCurrent(0);
                    if (widget.current != 0) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Shop(currentIndex: 0),
                        ),
                      );
                    }
                  },
                ),
                SidebarButton(
                  title: 'Discover',
                  icon: widget.current == 1
                      ? Image.asset(
                          'assets/icons/search_filled.png',
                          width: 20,
                        )
                      : Image.asset(
                          'assets/icons/search.png',
                          width: 20,
                        ),
                  current: widget.current == 1 ? true : false,
                  action: () {
                    //setCurrent(1);
                    if (widget.current != 1) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Shop(currentIndex: 1),
                        ),
                      );
                    }
                  },
                ),
                SidebarButton(
                  title: 'My profile',
                  icon: widget.current == 4
                      ? Image.asset(
                          'assets/icons/profile_filled.png',
                          width: 20,
                        )
                      : Image.asset(
                          'assets/icons/profile.png',
                          width: 20,
                        ),
                  current: widget.current == 4 ? true : false,
                  action: () {
                    //setCurrent(2);
                    if (widget.current != 4) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Shop(currentIndex: 4),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 10, top: 10, bottom: 10),
                  child: Text(
                    'OTHER',
                    style: TextStyle(
                        color: CustomColors.textGrey,
                        fontSize: TextSizes.medium),
                  ),
                ),
                SidebarButton(
                  title: 'Settings',
                  icon: Image.asset(
                    'assets/icons/settings.png',
                    width: 20,
                  ),
                  current: widget.current == 5 ? true : false,
                  action: () {
                    //setCurrent(3);
                    if (widget.current != 5) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      );
                    }
                  },
                ),
                SidebarButton(
                  title: 'Terms of Use',
                  icon: Image.asset(
                    'assets/icons/termsofuse.png',
                    width: 20,
                  ),
                  current: widget.current == 6 ? true : false,
                  action: () {
                    //setCurrent(4);
                    if (widget.current != 6) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermsOfUse(),
                        ),
                      );
                    }
                  },
                ),
                SidebarButton(
                  title: 'About us',
                  icon: Image.asset(
                    'assets/icons/aboutus.png',
                    width: 20,
                  ),
                  current: widget.current == 7 ? true : false,
                  action: () {
                    //setCurrent(5);
                    if (widget.current != 7) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutUs(),
                        ),
                      );
                    }
                  },
                ),
                Visibility(
                  visible: !isLoggedIn,
                  child: SidebarButton(
                    title: 'Sign In',
                    icon: Image.asset(
                      'assets/icons/signup.png',
                      width: 20,
                    ),
                    current: widget.current == 8 ? true : false,
                    action: () {
                      //setCurrent(5);
                      if (widget.current != 8) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            )));
  }
}

class LoggedInUser extends StatelessWidget {
  LoggedInUser({super.key, required this.loggedInUser});

  final Future<DocumentSnapshot> loggedInUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Shop(currentIndex: 4),
            ),
          );
        },
        child: FutureBuilder(
            future: loggedInUser,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return CustomErrorWidget(errorText: 'Error occured');
              } else if (snapshot.hasData) {
                // get the user and his profile image url
                DocumentSnapshot<Object?>? user = snapshot.data;
                if (user == null || !user.exists) {
                  return CustomErrorWidget(
                      errorText: 'Signup to fully enjoy ShedMedd!');
                }
                String imageUrl = user['profile_pic'];
                String initials = user['name'].toUpperCase().substring(0, 2);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundColor: CustomColors.grey,
                        child: ClipOval(
                            child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(child: CustomCircularProgress()),
                          errorWidget: (context, url, error) => Text(initials),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 160,
                            child: Text(
                              user['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: TextSizes.regular,
                                  color: CustomColors.textPrimary),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: 160,
                            child: Text(
                              user['email'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: TextSizes.small,
                                  color: CustomColors.textPrimary),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Center(child: ProfileShimmer()),
                );
              }
            }));
  }
}

/**
 * 
 * return 
 */