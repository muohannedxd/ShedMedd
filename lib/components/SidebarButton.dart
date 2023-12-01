import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';

class SidebarButton extends StatelessWidget {
  final Function action;
  final String title;
  final IconData icon;
  final bool current;

  const SidebarButton(
      {super.key,
      required this.title,
      required this.action,
      required this.icon,
      required this.current});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: current == true ? CustomColors.hoverColor.withOpacity(0.2) : CustomColors.grey.withOpacity(0),
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextButton(
            onPressed: () {
              action();
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
              child: Row(
                children: [
                  Icon(icon,
                      color: current == true
                          ? CustomColors.textPrimary
                          : CustomColors.textGrey),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: current == true
                            ? CustomColors.textPrimary
                            : CustomColors.textGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: TextSizes.medium),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
