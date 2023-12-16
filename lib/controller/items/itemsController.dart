import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../database/itemsDB.dart';

class ItemsController extends GetxController {
  final category = 'Women'.obs;
  final subCategory = 'Tops'.obs;
  final condition = 'Very good'.obs;
  final minPrice = 0.obs;
  final maxProce = 10000.obs;

  final categoriedItems = Rx<Future<List<DocumentSnapshot>>?>(null);
  final items = Rx<Future<List<DocumentSnapshot>>?>(null);
  final filteredItems = Rx<Future<List<DocumentSnapshot>>?>(null);

  void updateCategoryChooser(String categoryName) {
    category.value = categoryName;
    categoriedItems.value = ItemsDatabase().getCategoryItems(categoryName);
  }

  void filterItems(Set set, 
      {
        String name = 'All',
        String category = 'All',
        String subcategory = 'All',
        String condition = 'All',
        double minPrice = 0,
        double maxPrice = 10000
      }) {
    Map<String, dynamic> filters = {
      'name': name,
      'category': category,
      'subcategory': subcategory,
      'condition': condition,
      'minPrice': minPrice,
      'maxPrice': maxPrice
    };
    filteredItems.value = ItemsDatabase().getFilteredItems(filters);
  }
}
