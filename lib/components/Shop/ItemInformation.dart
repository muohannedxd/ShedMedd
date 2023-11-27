import 'package:flutter/material.dart';

import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';


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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
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
                    width: 200,
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
            SizedBox(
              width: 20,
            ),
            Text(
              '${price.toString()} DZD',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: TextSizes.title,
                  color: CustomColors.textPrimary),
            )
          ],
        ),
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
