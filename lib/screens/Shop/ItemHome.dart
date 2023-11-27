import 'package:flutter/material.dart';
import 'package:shedmedd/data/items.dart';

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

    return Scaffold(
      body: Center(
        child: Text(name),
      ),
    );
  }
}
