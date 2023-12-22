import 'package:flutter/material.dart';
import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';
import 'ItemNamePrice.dart';

class ItemInformation extends StatelessWidget {
  const ItemInformation(
      {super.key,
      required this.title,
      required this.category,
      required this.subcategory,
      required this.condition,
      required this.price,
      required this.isSold,
      required this.description});

  final String title;
  final String category;
  final String subcategory;
  final String condition;
  final int price;
  final bool isSold;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemNamePrice(title: title, condition: condition, price: price, isSold: isSold),
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
              '${description}',
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
