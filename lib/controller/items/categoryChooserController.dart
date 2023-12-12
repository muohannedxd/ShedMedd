import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../database/itemsDB.dart';

class CategoryChooserController extends GetxController {
  final category = 'Women'.obs;
  final subCategory = 'Tops'.obs;
  final condition = 'Very good'.obs;
  final minPrice = 0.obs;
  final maxProce = 10000.obs;

  final items = Rx<Future<List<DocumentSnapshot>>?>(null);

  void updateCategoryChooser(String categoryName) {
    category.value = categoryName;
    items.value = ItemsDatabase().getCategoryItems(categoryName);
  }
}
