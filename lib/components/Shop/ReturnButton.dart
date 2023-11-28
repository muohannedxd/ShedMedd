import 'package:flutter/material.dart';

import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';


class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
    required this.searchKey,
  });

  final String searchKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
            )),
            SizedBox(width: 6,),
        Text(
          searchKey,
          style: TextStyle(
              color: CustomColors.textPrimary,
              fontSize: TextSizes.medium,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}