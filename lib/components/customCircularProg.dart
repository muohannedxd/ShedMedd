import 'package:flutter/material.dart';

import '../constants/customColors.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(CustomColors.hoverColor),
      strokeWidth: 2.6,
    );
  }
}