import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';

AppBar Bar(title) {
  return AppBar(
    elevation: 0,
    backgroundColor: CustomColors.bgColor,
    title: Text(
      title,
      style: TextStyle(
          fontSize: TextSizes.subtitle,
          color: CustomColors.black,
          fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset('assets/icons/menu.png', color: CustomColors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Image.asset('assets/icons/notification.png', color: CustomColors.black),
      )
    ],
  );
}
