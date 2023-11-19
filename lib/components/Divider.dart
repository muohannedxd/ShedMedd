import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 16,
      thickness: 0.2,
      indent: 16,
      endIndent: 16,
      color: CustomColors.textGrey,
    );
  }
}