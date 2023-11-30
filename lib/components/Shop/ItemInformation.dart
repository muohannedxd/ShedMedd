import 'package:flutter/material.dart';

import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';
import 'ItemNamePrice.dart';

class ItemInformation extends StatelessWidget {
  const ItemInformation(
      {super.key,
      required this.name,
      required this.category,
      required this.subcategory,
      required this.condition,
      required this.price,
      required this.description});

  final String name;
  final String category;
  final String subcategory;
  final String condition;
  final int price;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemNamePrice(name: name, condition: condition, price: price),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: TextSizes.subtitle,
                    color: CustomColors.textPrimary)),
            SizedBox(
              height: 10,
            ),
            Text(
              '${category}, ${subcategory}',
              style: TextStyle(
                  fontSize: TextSizes.small,
                  height: 1.5,
                  color: CustomColors.textPrimary.withOpacity(0.8)),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: TextSizes.subtitle,
                    color: CustomColors.textPrimary)),
            SizedBox(
              height: 10,
            ),
            Text(
              '${description} ${description} ${description} ${description} ${description}',
              style: TextStyle(
                  fontSize: TextSizes.small,
                  height: 1.5,
                  color: CustomColors.textPrimary.withOpacity(0.8)),
            )
          ],
        ),
        SizedBox(
          height: 80,
        )
      ],
    );
  }
}