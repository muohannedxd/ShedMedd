import 'package:flutter/material.dart';
import 'package:shedmedd/components/SidebarButton.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/screens/Profile/Profile.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<bool> current = [true, false, false, false, false, false];

  void setCurrent(index) {
    for (int i = 0; i < current.length; i++) {
      current[i] = false;
    }
    setState(() {
      current[index] = true;
    });
  }

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
                  current: current[0],
                  action: () {
                    setCurrent(0);
                    if (!current[0]) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/shop');
                    }
                  },
                ),
                SidebarButton(
                  title: 'Discover',
                  icon: Icons.search_outlined,
                  current: current[1],
                  action: () {
                    setCurrent(1);
                    if (!current[0]) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/discover');
                    }
                  },
                ),
                SidebarButton(
                  title: 'My profile',
                  icon: Icons.person_outline,
                  current: current[2],
                  action: () {
                    setCurrent(2);
                    if (!current[2]) {
                      Navigator.pop(context); // Close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
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
                  current: current[3],
                  action: () {
                    setCurrent(3);
                  },
                ),
                SidebarButton(
                  title: 'Support',
                  icon: Icons.email_outlined,
                  current: current[4],
                  action: () {
                    setCurrent(4);
                  },
                ),
                SidebarButton(
                  title: 'About us',
                  icon: Icons.info_outline,
                  current: current[5],
                  action: () {
                    setCurrent(5);
                  },
                ),
              ],
            )));
  }
}
