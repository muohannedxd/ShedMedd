import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context, String contentText, Color bgColor) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 3),
    backgroundColor: bgColor,
    elevation: 2,
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
    closeIconColor: CustomColors.white,
    dismissDirection: DismissDirection.down,
    content: Text(contentText, style: TextStyle(fontWeight: FontWeight.w500, fontSize: TextSizes.medium),),
  ));
}
