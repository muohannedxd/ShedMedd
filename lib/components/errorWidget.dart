import 'package:flutter/material.dart';

import '../constants/customColors.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorText;
  const CustomErrorWidget({
    super.key,
    required this.errorText
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width:
            MediaQuery.of(context).size.width * 0.6,
        child: Text(
          errorText,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: CustomColors.textPrimary),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}