import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shedmedd/config/customCircularProg.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/config/getImageUrl.dart';

import '../screens/Shop/ItemHome.dart';
import 'errorWidget.dart';

class ItemCard extends StatelessWidget {
  final DocumentSnapshot<Object?> item;
  final bool isSeller;
  const ItemCard({super.key, required this.item, this.isSeller = false});

  @override
  Widget build(BuildContext context) {
    String itemId = item.id;
    String name = item['title'];
    var price = item['price'];
    String image = item['images'][0];

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemHome(
                itemID: itemId,
                isSeller: isSeller,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: getImageUrl(image),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        width: 136,
                        height: 180,
                        child: Center(
                          child: CustomCircularProgress(),
                        ));
                  } else if (snapshot.hasError) {
                    return CustomErrorWidget(
                                errorText: 'An error occured. Try again later');
                  } else {
                    String downloadUrl = snapshot.data!;
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 136,
                      height: 180,
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        downloadUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                }),
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
