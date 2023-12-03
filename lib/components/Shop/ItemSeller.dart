import 'package:flutter/material.dart';

import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';

class Seller extends StatelessWidget {
  const Seller({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          child: CircleAvatar(
            backgroundColor: CustomColors.grey,
            child: Text('MK'),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 180
                ),
                child: Text(
                  'Mohanned kadache',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: TextSizes.medium,
                      color: CustomColors.textPrimary),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                child: Text(
                  'Algiers, Algeria',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: TextSizes.small,
                      color: CustomColors.textPrimary),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
