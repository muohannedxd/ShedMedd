import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/config/searchArguments.dart';
import 'package:shedmedd/controller/items/itemsController.dart';
import '../../config/bouncingScroll.dart';
import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';
import '../../components/itemCard.dart';
import '../../components/Shop/CategoryChooser.dart';

class ShopHome extends StatelessWidget {
  ShopHome({
    super.key,
    required this.controller,
  });

  //final Map<String, dynamic> items;
  final ItemsController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
              const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/discover/results',
                          arguments:
                              SearchArguments('Feature Products', false));
                    },
                    child: Text(
                      'Show all',
                      style: TextStyle(color: CustomColors.textGrey),
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                physics: BouncingScroll(),
                scrollDirection: Axis.horizontal,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Obx(
                      () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: controller.items.values
                              .map((item) => ItemCard(item: item))
                              .toList()),
                    )),
              )
            ],
          ),
        ),

        // Recommended
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/discover/results',
                          arguments: SearchArguments('Recommended', false));
                    },
                    child: Text(
                      'Show all',
                      style: TextStyle(color: CustomColors.textGrey),
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                physics: BouncingScroll(),
                scrollDirection: Axis.horizontal,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Obx(
                      () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: controller.items.values
                              .map((item) => ItemCard(item: item))
                              .toList()),
                    )),
              ),
            ],
          ),
        ),

        // Deals
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/discover/results',
                          arguments: SearchArguments('Deals', false));
                    },
                    child: Text(
                      'Deals',
                      style: TextStyle(color: CustomColors.textGrey),
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                physics: BouncingScroll(),
                scrollDirection: Axis.horizontal,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Obx(
                      () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: controller.items.values
                              .map((item) => ItemCard(item: item))
                              .toList()),
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
