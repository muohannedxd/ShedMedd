import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../database/itemsDB.dart';

class CategoryChooserController extends GetxController {
  final category = "Women".obs;
  final categoryItems = Rx<Future<List<DocumentSnapshot>>?>(null);

  void updateCategoryChooser(String categoryName) {
    category.value = categoryName;
    categoryItems.value = ItemsDatabase().getCategoryItems(categoryName);
  }
}