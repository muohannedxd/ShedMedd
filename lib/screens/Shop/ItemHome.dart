import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/data/items.dart';
import '../../components/Shop/ItemInformation.dart';
import '../../components/Shop/ItemPictures.dart';
import '../../components/Shop/ItemSeller.dart';
import '../../config/myBehavior.dart';
import '../../constants/textSizes.dart';

class ItemHome extends StatefulWidget {
  const ItemHome({super.key});

  @override
  State<ItemHome> createState() => _ItemHome();
}

class _ItemHome extends State<ItemHome> {
  @override
  Widget build(BuildContext context) {
    final itemID = ModalRoute.of(context)!.settings.arguments;
    Map<String, dynamic> currentItem;

    String name = '';
    String category = '';
    String subcategory = '';
    String condition = '';
    var price = 0;
    String description = '';
    List<String> images = [];

    clothingItems.forEach((key, item) {
      if (item['id'] == itemID) {
        currentItem = item;
        name = currentItem['name'];
        category = item['category'];
        subcategory = currentItem['subcategory'];
        condition = currentItem['condition'];
        price = currentItem['price'];
        description = currentItem['description'];
        images = currentItem['images'];
      }
    });

    return Stack(children: [
      Scaffold(
        body: Center(
          child: ScrollConfiguration(
              behavior: BehaviorOfScroll(),
              child: Scaffold(
                backgroundColor: CustomColors.bgColor,
                body: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: Pictures(images: images),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 10),
                      child: Seller(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 20, bottom: 20),
                      child: ItemInformation(
                          name: name,
                          category: category,
                          subcategory: subcategory,
                          condition: condition,
                          price: price,
                          description: description),
                    ),
                  ],
                ),
              )),
        ),
      ),

      // return button
      Positioned(
          top: MediaQuery.of(context).size.height * 0.06,
          left: MediaQuery.of(context).size.width * 0.05,
          child: ReturnButton()),

      // go to DM button
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: DirectMessageButton(),
      ),
    ]);
  }
}

class DirectMessageButton extends StatelessWidget {
  const DirectMessageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.buttonPrimary,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
      ),
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          print('pressed');
        },
        child: Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_rounded,
                  color: CustomColors.white,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Message the Seller',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.white,
                    fontSize: TextSizes.subtitle,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: CustomColors.white,
      onPressed: () => Navigator.pop(context),
      child: Icon(
        Icons.arrow_back_ios_rounded,
        color: CustomColors.textPrimary,
        size: 20,
      ),
    );
  }
}