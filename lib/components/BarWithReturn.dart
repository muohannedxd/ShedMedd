import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';

AppBar BarWithReturn(BuildContext context, String title,
    {String? returnPage, bool isNotification = false, VoidCallback? onNotificationPressed}) {
  // Set a default callback if onNotificationPressed is not provided
  onNotificationPressed ??= () {
    Navigator.pushNamed(context, '/chatInbox');
  };

  return AppBar(
    elevation: 0,
    backgroundColor: CustomColors.bgColor,
    title: Text(
      title,
      style: TextStyle(
        fontSize: TextSizes.subtitle,
        color: CustomColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    leading: Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.only(left: 22),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: CustomColors.textPrimary),
          onPressed: () {
            if (returnPage != null) {
              bool popped = false;
              while (!popped) {
                Navigator.pop(context);
                popped = ModalRoute.of(context)?.settings.name == returnPage ||
                    ModalRoute.of(context)?.settings.name == null;
              }
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
    ),
    actions: [
      if (isNotification)
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: IconButton(
            icon: Image.asset(
              'assets/icons/notification.png',
              color: CustomColors.textPrimary,
            ),
            onPressed: onNotificationPressed,
          ),
        ),
    ],
  );
}
