import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';

import '../screens/Shop/Home.dart';

AppBar Bar(title, subpage) {
  return AppBar(
    surfaceTintColor: CustomColors.bgColor,
    elevation: 0,
    backgroundColor: CustomColors.bgColor,
    title: Text(
      title,
      style: TextStyle(
          fontSize: TextSizes.subtitle,
          color: CustomColors.textPrimary,
          fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    leading: Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.only(left: 22),
        child: !subpage ? IconButton(
          icon: Image.asset('assets/icons/menu.png',
              color: CustomColors.textPrimary),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ) : Visibility(visible: false, child: Text(''))
      ),
    ),
    actions: [
      !subpage ? Padding(
        padding: const EdgeInsets.only(right: 22),
        child: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Shop(currentIndex: 3),
                        ),
                      );
              },
              icon: Image.asset('assets/icons/dm.png', width: 22,));
          }
        ),
      ) : Visibility(visible: false, child: Text(''))
    ],
  );
}
