import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            width: 136,
            height: 180,
            child: Center(child: Text('image')),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: 120,
              child: Text(
                'Beige Hoodie',
                style: TextStyle(
                    color: CustomColors.textPrimary,
                    fontSize: TextSizes.small,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 4,
          ),
          Container(
              width: 120,
              child: Text('700 DZD',
                  style: TextStyle(
                      color: CustomColors.textPrimary,
                      fontSize: TextSizes.regular,
                      fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
