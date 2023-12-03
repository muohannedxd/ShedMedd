import 'package:flutter/material.dart';

import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';


class ItemNamePrice extends StatelessWidget {
  const ItemNamePrice({
    super.key,
    required this.name,
    required this.condition,
    required this.price,
  });

  final String name;
  final String condition;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 180
                ),
                child: Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: TextSizes.subtitle,
                      color: CustomColors.textPrimary),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 180
                ),
                child: Text(
                  'Condition: ${condition}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: TextSizes.small,
                      color: CustomColors.textGrey),
                ),
              )
            ],
          ),
        ),

        Text(
          '${price.toString()} DZD',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: TextSizes.title,
              color: CustomColors.textPrimary),
        )
      ],
    );
  }
}
