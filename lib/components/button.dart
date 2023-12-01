import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';

class Button extends StatelessWidget {
  final Function action;
  final String title;
  final Color background;
  final Color textColor;
  final Color borderColor;
  final double xPadding;
  final double yPadding;

  const Button(
      {super.key,
      required this.action,
      required this.title,
      this.background = CustomColors.grey,
      this.textColor = CustomColors.white,
      this.borderColor = CustomColors.white,
      this.xPadding = 34.0,
      this.yPadding = 14.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(background),
          foregroundColor: MaterialStateProperty.all<Color>(textColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor),
          )),
        ),
        onPressed: () {
          action();
        },
        child: Padding(
          padding: EdgeInsets.only(
              left: xPadding, right: xPadding, top: yPadding, bottom: yPadding),
          child: Text(
            title,
            style: TextStyle(fontSize: TextSizes.regular),
          ),
        ));
  }
}
