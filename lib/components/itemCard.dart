import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';

import '../screens/Shop/ItemHome.dart';

class ItemCard extends StatelessWidget {
  final dynamic item;
  final bool isSeller;

  const ItemCard({super.key, required this.item, this.isSeller = false});

  @override
  Widget build(BuildContext context) {
    String name = item['name'];
    var price = item['price'];
    String image = item['images'][0];

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemHome(itemID: item['id'], isSeller: isSeller,),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              width: 136,
              height: 180,
              clipBehavior: Clip
                  .antiAlias, // Add this line to apply clipping with anti-aliasing
              child: Image.asset(
                'assets/images/dummy/${image}',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 120,
                child: Text(
                  name,
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
                child: Text('${price} DZD',
                    style: TextStyle(
                        color: CustomColors.textPrimary,
                        fontSize: TextSizes.regular,
                        fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}
