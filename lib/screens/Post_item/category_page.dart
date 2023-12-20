import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/screens/Post_item/sub_category_page.dart';
import '../../components/floating_button.dart';
import '../../config/returnAction.dart';
import '../../constants/customColors.dart';
import '../../controller/post_item/category_controller.dart';

class CategoryPage extends StatelessWidget {
  final CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          FloatingButton(title: 'Category', action: returnToPreviousPage,),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          Category(page: "Men", controller: categoryController),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          Category(page: 'Women', controller: categoryController),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          Category(page: 'Kids', controller: categoryController),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String page;
  final CategoryController controller;

  const Category({Key? key, required this.page, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.updateCategory(page);
        Get.to(SubCategoryPage());
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 40, right: 40, bottom: 19, top: 19),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                page,
                style: TextStyle(fontSize: 16, color: Color(0xFF33302E)),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF33302E),
                size: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
