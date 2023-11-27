import 'package:flutter/material.dart';
import 'package:shedmedd/data/items.dart';
import '../../components/Bar.dart';
import '../../components/Drawer.dart';
import '../../components/Shop/CategoryChooser.dart';
import '../../components/itemCard.dart';
import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';
import '../../config/myBehavior.dart';

import '../../config/bouncingScroll.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  // dummy data
  Map<String, dynamic> items = clothingItems;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: BehaviorOfScroll(),
      child: Scaffold(
        appBar: Bar('ShedMedd'),
        drawer: AppDrawer(
          current: 0,
        ),
        backgroundColor: CustomColors.bgColor,
        body: ListView(
          children: [
            // category chooser
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 20, bottom: 20),
              child: CategoryChooser(),
            ),

            // Feature Products
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 20, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Feature Products',
                        style: TextStyle(
                            color: CustomColors.textPrimary,
                            fontSize: TextSizes.subtitle,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Show all',
                        style: TextStyle(color: CustomColors.textGrey),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    physics: BouncingScroll(),
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: items.values
                              .map((item) => ItemCard(item: item))
                              .toList()),
                    ),
                  )
                ],
              ),
            ),

            // Recommended
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recommended',
                        style: TextStyle(
                            color: CustomColors.textPrimary,
                            fontSize: TextSizes.subtitle,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Show all',
                        style: TextStyle(color: CustomColors.textGrey),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    physics: BouncingScroll(),
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: items.values
                              .map((item) => ItemCard(item: item))
                              .toList()),
                    ),
                  ),
                ],
              ),
            ),

            // Deals
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deals',
                        style: TextStyle(
                            color: CustomColors.textPrimary,
                            fontSize: TextSizes.subtitle,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Show all',
                        style: TextStyle(color: CustomColors.textGrey),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    physics: BouncingScroll(),
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: items.values
                              .map((item) => ItemCard(item: item))
                              .toList()),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
