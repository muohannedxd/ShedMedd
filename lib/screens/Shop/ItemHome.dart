import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/controllers/itemsController.dart';
import '../../components/Shop/ItemInformation.dart';
import '../../components/Shop/ItemPictures.dart';
import '../../components/Shop/ItemSeller.dart';
import '../../config/myBehavior.dart';
import '../../constants/textSizes.dart';

class ItemHome extends StatelessWidget {
  final itemID;
  final bool isSeller;

  ItemHome({super.key, required this.itemID, this.isSeller = false});

  final ItemsController itemsController = Get.put(ItemsController());

  @override
  Widget build(BuildContext context) {
    dynamic currentItem = itemsController.getItem(itemID);

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
                      child: Pictures(images: currentItem['images']),
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
                          name: currentItem['name'],
                          category: currentItem['category'],
                          subcategory: currentItem['subcategory'],
                          condition: currentItem['condition'],
                          price: currentItem['price'],
                          description: currentItem['description']),
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

      isSeller
          ? Positioned(
              top: MediaQuery.of(context).size.height * 0.06,
              right: MediaQuery.of(context).size.width * 0.05,
              child: SettingsButton())
          : Visibility(visible: false, child: Text('')),

      // go to DM button
      !isSeller
          ? Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DirectMessageButton(
                  name: currentItem['name'], condition: currentItem['condition'], price: currentItem['price']),
            )
          : Visibility(visible: false, child: Text('')),
    ]);
  }
}

class DirectMessageButton extends StatelessWidget {
  const DirectMessageButton({
    super.key,
    required this.name,
    required this.condition,
    required this.price,
  });

  final String name;
  final String condition;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColors.buttonPrimary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/message',
            arguments: {
              'name': name,
              'condition': condition,
              'price': price,
            },
          );
        },
        child: Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/dm.png',
                    width: 20, color: CustomColors.white),
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

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
        backgroundColor: CustomColors.white,
        onPressed: () => print('hh'),
        child: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit_outlined,
                      color: CustomColors.textPrimary),
                  title: Text(
                    'Edit',
                    style: TextStyle(color: CustomColors.textPrimary),
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete_outline,
                      color: CustomColors.textPrimary),
                  title: Text('Delete',
                      style: TextStyle(color: CustomColors.textPrimary)),
                ),
              ),
            ];
          },
          child: Icon(
            Icons.more_vert_rounded,
            color: CustomColors.textPrimary,
          ),
        ));
  }
}
