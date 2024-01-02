import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shedmedd/components/floating_button.dart';

import '../../constants/customColors.dart';
import '../../controller/auth/auth_controller.dart';
import '../../controller/post_item/category_controller.dart';
import '../../controller/post_item/conditon_controller.dart';
import '../../controller/post_item/description_controller.dart';
import '../../controller/post_item/images_controller.dart';
import '../../controller/post_item/price_controller.dart';
import '../../controller/post_item/title_controller.dart';
import '../../database/itemsDB.dart';
import '../Shop/Home.dart';
import 'category_page.dart';
import 'condition_page.dart';

class PostAnItem extends StatefulWidget {
  PostAnItem({super.key});

  @override
  State<PostAnItem> createState() => _PostAnItemState();
}

class _PostAnItemState extends State<PostAnItem> {
  final ImageListController imageListController =
      Get.put(ImageListController(), permanent: true);
  final TitleController _titleController =
      Get.put(TitleController(), permanent: true);
  final DescriptionController _descriptionController =
      Get.put(DescriptionController(), permanent: true);
  final PriceController _priceController =
      Get.put(PriceController(), permanent: true);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ItemsDatabase itemsDatabase = ItemsDatabase(); // Create an instance
  AuthController authController = AuthController();
  String errorMessage = "";

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 75,
        );

    if (pickedImage != null) {
      setState(() {
        imageListController.addImage(pickedImage);
      });
    }
  }

  final CategoryController categoryController =
      Get.put(CategoryController(), permanent: true);
  final ConditionController conditionController =
      Get.put(ConditionController(), permanent: true);

  void addNewItem() async {
    try {
      setState(() {
        errorMessage = ""; // Reset the error message
      });

      // Validate fields
      if (_titleController.title.value.isEmpty ||
          _descriptionController.description.value.isEmpty ||
          _priceController.price.value.isEmpty ||
          categoryController.category.isEmpty ||
          categoryController.subCategory.isEmpty ||
          conditionController.condition.isEmpty) {
        setState(() {
          errorMessage = "All fields must be filled";
        });
        return;
      }

      // Show loading indicator
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(CustomColors.buttonSecondary),
          ),
        ),
        barrierDismissible: false,
      );

      List<String> imagePaths = [];

      for (int i = 0; i < imageListController.length; i++) {
        imagePaths.add(imageListController.pathAtIndex(i));
      }

      Map<String, dynamic> newItemData = {
        'created_at': FieldValue.serverTimestamp(),
        'title': _titleController.title.value,
        'description': _descriptionController.description.value,
        'price': int.tryParse(_priceController.price.value),
        'isSold': false,
        'category': categoryController.category,
        'subcategory': categoryController.subCategory,
        'condition': conditionController.condition,
        'user_id': await authController.getCurrentUserId()
      };

      print(newItemData);

      await itemsDatabase.addAnItemData(newItemData, imagePaths);

      // Clear inputs and image list after successful submission
      setState(() {
        _clearInputs();
      });

      // Close the loading indicator
      Get.back();

      // Navigate to the desired screen or perform other actions after data is added
      Get.offAll(Shop(currentIndex: 0));
    } catch (e, stackTrace) {
      print("Error adding new item: $e");
      print("Stack trace: $stackTrace");

      // Close the loading indicator
      Get.back();

      // Handle the error as needed
    }
  }

  void returnFromPostingItem(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Shop(currentIndex: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Shop(currentIndex: 0)),
            (route) => false);
        return false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.white, // Set the color you want
            statusBarIconBrightness:
                Brightness.dark, // Use dark icons for better visibility
          ),
          child: Scaffold(
            backgroundColor: CustomColors.backgroundForPostItem,
            body: Container(
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                    margin: EdgeInsets.zero,
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: FloatingButton(
                            title: 'Sell an item',
                            action: returnFromPostingItem,
                            icon: Icon(
                              Icons.close_outlined,
                              size: 20,
                            ))),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Color(0xFFF3F3F6),
                  ),
                  Container(
                    height: 166,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          child: imageListController.isEmpty
                              ? Center(
                                  child: ElevatedButton(
                                    onPressed: _pickImage,
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary: Colors.white,
                                      onPrimary:
                                          CustomColors.backgroundForPostItem,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                        side: BorderSide(
                                          color: CustomColors
                                              .backgroundForPostItem,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.add_circle_outline),
                                        SizedBox(width: 8),
                                        Text(
                                          "Upload Photos",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            imageListController.length + 1,
                                        itemBuilder: (context, index) {
                                          if (index ==
                                              imageListController.length) {
                                            // Render "Add Photos" button
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 100,
                                                height: 100,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    await _pickImage();
                                                    print(imageListController);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    primary: Colors.white,
                                                    onPrimary: CustomColors
                                                        .backgroundForPostItem,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32.0),
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    Icons.add_box_outlined,
                                                    size: 32,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            // Render images from imageListController
                                            return Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: 100,
                                                    height: 100,
                                                    child: Image.file(
                                                      File(imageListController
                                                          .pathAtIndex(index)),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: IconButton(
                                                    color: Color(0xFFF3F3F6),
                                                    icon: Icon(Icons.cancel),
                                                    onPressed: () {
                                                      // Remove the image from the list
                                                      setState(() {
                                                        imageListController
                                                            .removeImage(index);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 40, right: 40, top: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF626262)),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller: TextEditingController(
                              text: _titleController.title.value,
                            ),
                            onChanged: (title) {
                              _titleController.updateTitle(title);
                            },
                            decoration: InputDecoration(
                                hintText: "e.g. White t-shirt",
                                hintStyle: TextStyle(color: Color(0xFF4F4F4F)),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CustomColors.buttonSecondary,
                                      width: 2.0),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Color(0xFFF3F3F6),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 32),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 40, right: 40, top: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Describe your item:",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF626262)),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller: TextEditingController(
                              text: _descriptionController.description.value,
                            ),
                            onChanged: (description) {
                              _descriptionController
                                  .updateDescription(description);
                            },
                            decoration: InputDecoration(
                                hintText: "e.g. Only worn few times",
                                hintStyle: TextStyle(color: Color(0xFF4F4F4F)),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CustomColors.buttonSecondary,
                                      width: 2.0),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CategoryAndCondition(
                      page: "Category",
                      categoryOrCondition: false,
                      catogoryController: categoryController,
                      conditionController: conditionController),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Color(0xFFF3F3F6),
                  ),
                  CategoryAndCondition(
                      page: 'Condition',
                      categoryOrCondition: true,
                      catogoryController: categoryController,
                      conditionController: conditionController),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 40, right: 40, top: 16, bottom: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF626262)),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller: TextEditingController(
                              text: _priceController.price.value,
                            ),
                            onChanged: (price) {
                              _priceController.updatePrice(price);
                            },
                            decoration: InputDecoration(
                              hintText: "e.g. 500",
                              hintStyle: TextStyle(
                                  color: Color(0xFF4F4F4F), fontSize: 16),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}$')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Color(0xFFF3F3F6),
                  ),
                  errorMessage.isNotEmpty
                      ? Container(
                          color: Colors.white,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                errorMessage,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  Container(
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 21, right: 21, bottom: 16, top: 47),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: addNewItem,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            textStyle: TextStyle(color: Colors.white),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16), // Adjust padding as needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.transparent),
                            ),
                            elevation: 0, // No elevation
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 38,
                            alignment: Alignment.center,
                            child: Text(
                              "Upload item",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _clearInputs() {
    _titleController.updateTitle("");
    _descriptionController.updateDescription("");
    _priceController.updatePrice("");
    categoryController
        .resetCategories(); // Implement a reset function in your CategoryController
    conditionController
        .resetCondition(); // Implement a reset function in your ConditionController
    imageListController.clear();
  }
}

class CategoryAndCondition extends StatelessWidget {
  final String page;
  final bool categoryOrCondition;
  final CategoryController catogoryController;
  final ConditionController conditionController;
  const CategoryAndCondition(
      {super.key,
      required this.page,
      required this.categoryOrCondition,
      required this.catogoryController,
      required this.conditionController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (categoryOrCondition == true) {
          Get.to(ConditionPage());
        } else {
          Get.to(CategoryPage());
        }
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
              page == "Category"
                  ? Text(
                      (catogoryController.category == "" ||
                              catogoryController.subCategory == "")
                          ? ""
                          : "${catogoryController.category} - ${catogoryController.subCategory}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 152, 150, 149)),
                    )
                  : Text(
                      (conditionController.condition == "")
                          ? ""
                          : "${conditionController.condition}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 152, 150, 149)),
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
