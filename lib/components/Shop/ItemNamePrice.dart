import 'package:flutter/material.dart';

import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';

class ItemNamePrice extends StatelessWidget {
  const ItemNamePrice({
    super.key,
    required this.title,
    required this.condition,
    required this.price,
    required this.isSold
  });

  final String title;
  final String condition;
  final int price;
  final bool isSold;

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
                  maxWidth: MediaQuery.of(context).size.width * 0.56,
                ),
                child: Text(
                  title,
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
                  maxWidth: MediaQuery.of(context).size.width * 0.80,
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
        !isSold ? Column(
          children: [
            Text(
              '${price.toString()}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: TextSizes.title,
                  color: CustomColors.textPrimary),
            ),
            Text(
              'DZD',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: TextSizes.title,
                  color: CustomColors.textPrimary),
            ),
          ],
        ) : Text(
              'Sold',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: TextSizes.title,
                  color: CustomColors.textPrimary),
            ),
      ],
    );
  }
}
