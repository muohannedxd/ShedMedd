import 'package:get/get.dart';

class CategoryController extends GetxController {
  String category = "";
  String subCategory = "";

  void updateCategory(String categoryName) {
    category = categoryName;
    update();
  }

  void updateSubCategory(String subCategoryName) {
    subCategory = subCategoryName;
    update();
  }
}
