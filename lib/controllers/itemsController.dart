import 'package:get/get.dart';
import 'package:shedmedd/data/items.dart';

class ItemsController extends GetxController {
  final Map<String, dynamic> items = clothingItems.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // getting a specific item
  dynamic getItem(int id) {
    dynamic item;
    items.forEach((key, value) {
      if (value['id'] == id) {
        item = value;
      }
    });
    return item;
  }

  // adding an item
  void addItem(Map<String, dynamic> newItem) {
    // Generate a unique ID for the new item
    String newKey = 'item${items.length + 1}';
    newItem['id'] = items.length + 1;
    items[newKey] = newItem;
  }
}
