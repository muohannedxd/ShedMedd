import 'package:flutter/material.dart';
import 'package:shedmedd/components/SidebarButton.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/screens/Settings/Aboutus.dart';
import 'package:shedmedd/screens/Settings/settings.dart';
import 'package:shedmedd/screens/Settings/terms_of_use.dart';
import 'package:shedmedd/screens/Shop/Home.dart';

class AppDrawer extends StatefulWidget {
  final int current;
  const AppDrawer({super.key, required this.current});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  /*void setCurrent(index) {
    for (int i = 0; i < current.length; i++) {
      current[i] = false;
    }
    setState(() {
      current[index] = true;
    });
  }*/

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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            child: CircleAvatar(
                              backgroundColor: CustomColors.grey,
                              child: Text('MK'),
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
                                  width: 120,
                                  child: Text(
                                    'Mohanned kadache',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: TextSizes.regular,
                                        color: CustomColors.textPrimary),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 120,
                                  child: Text(
                                    'mohanned@gmail.com',
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
                      )),
                ),
                SidebarButton(
                  title: 'Homepage',
                  icon: Icons.home_outlined,
                  current: widget.current == 0 ? true : false,
                  action: () {
                    //setCurrent(0);
                    if (widget.current != 0) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Shop(currentIndex: 0),
                        ),
                      );
                    }
                  },
                ),
                SidebarButton(
                  title: 'Discover',
                  icon: Icons.search_outlined,
                  current: widget.current == 1 ? true : false,
                  action: () {
                    //setCurrent(1);
                    if (widget.current != 1) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Shop(currentIndex: 1),
                        ),
                      );
                    }
                  },
                ),
                SidebarButton(
                  title: 'My profile',
                  icon: Icons.person_outline,
                  current: widget.current == 4 ? true : false,
                  action: () {
                    //setCurrent(2);
                    if (widget.current != 4) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Shop(currentIndex: 4),
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
                  icon: Icons.settings_outlined,
                  current: widget.current == 5 ? true : false,
                  action: () {
                    //setCurrent(3);
                    if (widget.current != 5) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Settings(),
                        ),
                      );
                    }
                  },
                ),
                SidebarButton(
                  title: 'Terms of Use',
                  icon: Icons.notes_rounded,
                  current: widget.current == 6 ? true : false,
                  action: () {
                    //setCurrent(4);
                    if (widget.current != 6) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TermsOfUse(),
                        ),
                      );
                    }
                  },
                ),
                SidebarButton(
                  title: 'About us',
                  icon: Icons.person_search_outlined,
                  current: widget.current == 7 ? true : false,
                  action: () {
                    //setCurrent(5);
                    if (widget.current != 7) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AboutUs(),
                        ),
                      );
                    }
                  },
                ),
              ],
            )));
  }
}
