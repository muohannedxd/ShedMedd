import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shedmedd/controller/post_item/description_controller.dart';
import 'package:shedmedd/controller/post_item/price_controller.dart';
import 'package:shedmedd/controller/post_item/title_controller.dart';
import '../../constants/customColors.dart';
import '../../controller/auth/auth_controller.dart';
import '../../controller/post_item/images_controller.dart';
import '../../database/itemsDB.dart';
import '../Shop/Home.dart';
import '../../controller/post_item/category_controller.dart';
import '../../controller/post_item/conditon_controller.dart';
import 'category_page.dart';
import 'condition_page.dart';

class PostAnItem extends StatefulWidget {
  PostAnItem({super.key});

  @override
  State<PostAnItem> createState() => _PostAnItemState();
}

class _PostAnItemState extends State<PostAnItem> {
  final ImageListController imageListController =
      Get.put(ImageListController());
  final TitleController _titleController = Get.put(TitleController());
  final DescriptionController _descriptionController =
      Get.put(DescriptionController());
  final PriceController _priceController = Get.put(PriceController());

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ItemsDatabase itemsDatabase = ItemsDatabase(); // Create an instance
  AuthController authController = AuthController();
  String errorMessage = "";

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageListController.addImage(pickedImage);
        print(imageListController);
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
          valueColor: AlwaysStoppedAnimation<Color>(CustomColors.buttonSecondary),
        ),
      ),
      barrierDismissible: false,
    );

    List<String> imagePaths = [];

    for (int i = 0; i < imageListController.length; i++) {
      imagePaths.add(imageListController.pathAtIndex(i));
    }

    Map<String, dynamic> newItemData = {
      'title': _titleController.title.value,
      'description': _descriptionController.description.value,
      'price': int.tryParse(_priceController.price.value),
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

  @override
  Widget build(BuildContext context) {
    void addNewItem() {
      // Add your upload logic here
      // dummy added item
      /*Map<String, dynamic> newItem = {
        'id': 0,
        'name': 'New Item',
        'category': 'Women',
        'subcategory': 'Shirt',
        'condition': 'Good',
        'price': 380,
        'description': 'This is a new pink item',
        'images': ['pink_shirt3.jpeg', 'pink_shirt2.jpeg'],
      };*/

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Shop(currentIndex: 0),
        ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
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
                    padding:
                        const EdgeInsets.only(left: 24, bottom: 20, top: 32),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.close_outlined,
                            size: 30,
                          ),
                          color: Colors.black,
                          onPressed: () {
                            // Navigate back when the button is pressed
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Shop(currentIndex: 0),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Text(
                          "Sell an item",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
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
                  height: 166,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _imageList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 100, // Adjust the width as needed
                                height: 100, // Adjust the height as needed
                                child: Image.file(
                                  File(_imageList[index].path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.white, // Background color
                          onPrimary: CustomColors.grey, // Text and icon color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(32.0), // Border radius
                            side: BorderSide(
                                color: CustomColors.grey), // Border color
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add_circle_outline),
                            SizedBox(
                                width:
                                    8), // Adjust the spacing between icon and text
                            Text(
                              "Upload Photos",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      )
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
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF626262)),
                        ),
                        SizedBox(height: 8),
                        TextField(
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
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF626262)),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          maxLines: null,
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
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF626262)),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                              hintText: "e.g. 500DA",
                              hintStyle: TextStyle(
                                  color: Color(0xFF4F4F4F), fontSize: 16),
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
                          child: Text("Upload"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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
