import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';

AppBar Bar(title, subpage) {
  return AppBar(
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
        child: Icon(Icons.mark_chat_unread_outlined, color: CustomColors.textPrimary,),
      ) : Visibility(visible: false, child: Text(''))
    ],
  );
}
