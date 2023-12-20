import 'package:flutter/material.dart';

import '../constants/customColors.dart';

class FloatingButton extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function(BuildContext) action;

  FloatingButton({
    this.title = '',
    this.icon = const Icon(Icons.arrow_back_ios_rounded),
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 24, top: 32),
      child: Row(
        children: [
          Material(
            elevation: 1,
            shape: CircleBorder(),
            color: CustomColors.white,
            child: Container(
              width: 40,
              height: 40,
              child: IconButton(
                icon: icon,
                onPressed: () {
                  action(context);
                },
              ),
            ),
          ),
          SizedBox(
            width: 100,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
