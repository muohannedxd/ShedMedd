import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/controller/items/itemsController.dart';

class CategoryChooser extends StatelessWidget {
  CategoryChooser({super.key, required this.controller});

  final ItemsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => Column(
              children: [
                Container(
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                      onTap: () {
                        controller.updateCategoryChooser('All');
                      },
                      child: CircleAvatar(
                        backgroundColor: controller.category.value == "All"
                            ? CustomColors.textSecondary
                            : CustomColors.grey.withOpacity(0.3),
                        child: Icon(Icons.shopping_bag_outlined,
                            size: 36,
                            color: controller.category.value == "All"
                                ? CustomColors.white
                                : CustomColors.textPrimary.withOpacity(0.3)),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'All',
                  style: TextStyle(
                      color: controller.category.value == "All"
                          ? CustomColors.textPrimary
                          : CustomColors.textPrimary.withOpacity(0.3)),
                )
              ],
            )),
        Obx(() => Column(
              children: [
                Container(
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                      onTap: () {
                        controller.updateCategoryChooser('Women');
                      },
                      child: CircleAvatar(
                        backgroundColor: controller.category.value == "Women"
                            ? CustomColors.textSecondary
                            : CustomColors.grey.withOpacity(0.3),
                        child: Icon(Icons.female_outlined,
                            size: 36,
                            color: controller.category.value == "Women"
                                ? CustomColors.white
                                : CustomColors.textPrimary.withOpacity(0.3)),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Women',
                  style: TextStyle(
                      color: controller.category.value == "Women"
                          ? CustomColors.textPrimary
                          : CustomColors.textPrimary.withOpacity(0.3)),
                )
              ],
            )),
        Obx(() => Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      controller.updateCategoryChooser('Men');
                    },
                    child: CircleAvatar(
                      backgroundColor: controller.category.value == "Men"
                          ? CustomColors.textSecondary
                          : CustomColors.grey.withOpacity(0.3),
                      child: Icon(Icons.male_outlined,
                          size: 36,
                          color: controller.category.value == "Men"
                              ? CustomColors.white
                              : CustomColors.textPrimary.withOpacity(0.3)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Men',
                  style: TextStyle(
                      color: controller.category.value == "Men"
                          ? CustomColors.textPrimary
                          : CustomColors.textPrimary.withOpacity(0.3)),
                )
              ],
            )),
        Obx(
          () => Column(
            children: [
              Container(
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    controller.updateCategoryChooser('Kids');
                  },
                  child: CircleAvatar(
                    backgroundColor: controller.category.value == "Kids"
                        ? CustomColors.textSecondary
                        : CustomColors.grey.withOpacity(0.3),
                    child: Icon(Icons.child_care_outlined,
                        size: 36,
                        color: controller.category.value == "Kids"
                            ? CustomColors.white
                            : CustomColors.textPrimary.withOpacity(0.3)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Kids',
                style: TextStyle(
                    color: controller.category.value == "Kids"
                        ? CustomColors.textPrimary
                        : CustomColors.textPrimary.withOpacity(0.3)),
              )
            ],
          ),
        )
      ],
    );
  }
}
