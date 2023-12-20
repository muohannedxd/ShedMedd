import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/floating_button.dart';
import '../../config/returnAction.dart';
import '../../constants/customColors.dart';
import '../../controller/post_item/category_controller.dart';
import 'post_an_new_item.dart';

class SubCategoryPage extends StatefulWidget {
  SubCategoryPage({super.key});

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  String selectedSubCategory = '';
  final CategoryController SubCategoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          FloatingButton(action: returnToPreviousPage,),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          SubCategory(
            subCategory: "Tops",
            isSelected: selectedSubCategory == "Tops",
            onChanged: () {
              updateSelectedSubCategory("Tops");
              SubCategoryController.updateSubCategory("Tops");
              Get.offAll(PostAnItem());
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          SubCategory(
            subCategory: "Pants",
            isSelected: selectedSubCategory == "Pants",
            onChanged: () {
              updateSelectedSubCategory("Pants");
              SubCategoryController.updateSubCategory("Pants");
              Get.offAll(PostAnItem());
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          SubCategory(
            subCategory: "Outfits",
            isSelected: selectedSubCategory == "Outfits",
            onChanged: () {
              updateSelectedSubCategory("Outfits");
              SubCategoryController.updateSubCategory("Outfits");
              Get.offAll(PostAnItem());
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          SubCategory(
            subCategory: "Shoes",
            isSelected: selectedSubCategory == "Shoes",
            onChanged: () {
              updateSelectedSubCategory("Shoes");
              SubCategoryController.updateSubCategory("Shoes");
              Get.offAll(PostAnItem());
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          SubCategory(
            subCategory: "Others",
            isSelected: selectedSubCategory == "Others",
            onChanged: () {
              updateSelectedSubCategory("Others");
              SubCategoryController.updateSubCategory("Others");
              Get.offAll(PostAnItem());
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
        ],
      ),
    );
  }

  void updateSelectedSubCategory(String subCategory) {
    setState(() {
      selectedSubCategory = subCategory;
    });
  }
}

class SubCategory extends StatelessWidget {
  final String subCategory;
  final bool isSelected;
  final VoidCallback onChanged;

  SubCategory({
    super.key,
    required this.subCategory,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        alignment: Alignment.centerLeft,
        color: Colors.white,
        margin: EdgeInsets.only(left: 23, right: 23, top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subCategory,
                    style: TextStyle(fontSize: 16, color: Color(0xFF33302E)),
                  ),
                ],
              ),
            ),
            Checkbox(
              checkColor: Colors.white,
              activeColor: CustomColors.buttonSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (Set<MaterialState> states) {
                  return BorderSide(
                    width: 1,
                    color: states.contains(MaterialState.selected)
                        ? CustomColors.buttonSecondary
                        : Colors.black,
                  );
                },
              ),
              value: isSelected,
              onChanged: (value) {
                onChanged();
              },
            ),
          ],
        ),
      ),
    );
  }
}
