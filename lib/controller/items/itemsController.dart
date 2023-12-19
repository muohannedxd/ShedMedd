import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../database/itemsDB.dart';

class ItemsController extends GetxController {
  final category = 'Women'.obs;
  final subCategory = 'Tops'.obs;
  final condition = 'Very good'.obs;
  final minPrice = 0.obs;
  final maxPrice = 10000.obs;

  final categoriedItems = Rx<Future<List<DocumentSnapshot>>?>(null);
  final filteredItems = Rx<Future<List<DocumentSnapshot>>?>(null);
  final specificItems = Rx<Future<List<DocumentSnapshot>>?>(null);
  final myProducts = Rx<Future<List<DocumentSnapshot>>?>(null);

  void updateCategoryChooser(String categoryName) {
    category.value = categoryName;
    categoriedItems.value = ItemsDatabase().getCategoryItems(categoryName);
  }

  void filterItems({
    String category = 'All',
    String subcategory = 'All',
    String condition = 'All',
    double minPrice = 0,
    double maxPrice = 10000,
  }) {
    Map<String, dynamic> filters = {
      'category': category,
      'subcategory': subcategory,
      'condition': condition,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
    };
    filteredItems.value = ItemsDatabase().getFilteredItems(filters);
  }

  void searchItems({
    String title = 'All',
    String category = 'All',
    String subcategory = 'All',
    String condition = 'All',
    double minPrice = 0,
    double maxPrice = 10000,
  }) {
    Map<String, dynamic> filters = {
      'title': title,
      'category': category,
      'subcategory': subcategory,
      'condition': condition,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
    };
    specificItems.value = ItemsDatabase().getSpecificItems(filters);
  }

  void getMyProducts(String user_id) {
    myProducts.value = ItemsDatabase().getUserItems(user_id);
  }
}
