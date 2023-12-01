import 'package:flutter/material.dart';
import 'package:shedmedd/components/Bar.dart';
import 'package:shedmedd/components/Drawer.dart';
import 'package:shedmedd/components/Shop/CategoryChooser.dart';
import 'package:shedmedd/components/itemCard.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/config/myBehavior.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: BehaviorOfScroll(),
      child: Scaffold(
        appBar: Bar('ShedMedd'),
        drawer: AppDrawer(),
        backgroundColor: CustomColors.bgColor,
        body: ListView(
          children: [
            // category chooser
            Padding(
              padding:
                  const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
              child: CategoryChooser(),
            ),
    
            // Feature Products
            Padding(
              padding:
                  const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
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
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ItemCard(),
                          ItemCard(),
                          ItemCard(),
                          ItemCard(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    
            // Recommended
            Padding(
              padding:
                  const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
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
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ItemCard(),
                          ItemCard(),
                          ItemCard(),
                          ItemCard(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    
            // Deals
            Padding(
              padding:
                  const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
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
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ItemCard(),
                          ItemCard(),
                          ItemCard(),
                          ItemCard(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
