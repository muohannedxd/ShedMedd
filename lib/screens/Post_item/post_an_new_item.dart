import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shedmedd/controllers/itemsController.dart';
import '../../constants/customColors.dart';
import '../Shop/Home.dart';
import 'package:shedmedd/screens/Profile/Profile.dart';
import 'package:shedmedd/controllers/itemsController.dart';
import '../../constants/customColors.dart';
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
  List<XFile> _imageList = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageList.add(pickedImage);
      });
    }
  }

  final CategoryController categoryController =
      Get.put(CategoryController(), permanent: true);
  final ConditionController conditionController =
      Get.put(ConditionController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final ItemsController itemsController = Get.put(ItemsController());

    void addNewItem() {
      // Add your upload logic here
      // dummy added item
      Map<String, dynamic> newItem = {
        'id': 0,
        'name': 'New Item',
        'category': 'Women',
        'subcategory': 'Shirt',
        'condition': 'Good',
        'price': 380,
        'description': 'This is a new pink item',
        'images': ['pink_shirt3.jpeg', 'pink_shirt2.jpeg'],
      };

      itemsController.addItem(newItem);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Shop(currentIndex: 0),
        ),
      );
    }

    return Scaffold(
      backgroundColor: CustomColors.backgroundForPostItem,
      body: Container(
        child: ListView(
          children: [
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
                margin:
                    EdgeInsets.only(left: 40, right: 40, top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: TextStyle(fontSize: 14, color: Color(0xFF626262)),
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
              color: CustomColors.backgroundForPostItem,
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 32),
              child: Container(
                margin:
                    EdgeInsets.only(left: 40, right: 40, top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Describe your item:",
                      style: TextStyle(fontSize: 14, color: Color(0xFF626262)),
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
              color: CustomColors.backgroundForPostItem,
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
                margin:
                    EdgeInsets.only(left: 40, right: 40, top: 16, bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: TextStyle(fontSize: 14, color: Color(0xFF626262)),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "e.g. 500DA",
                          hintStyle:
                              TextStyle(color: Color(0xFF4F4F4F), fontSize: 16),
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
              color: CustomColors.backgroundForPostItem,
            ),
            Container(
              color: Colors.white,
              child: Container(
                margin:
                    EdgeInsets.only(left: 21, right: 21, bottom: 16, top: 47),
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
    );
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
                          : "${catogoryController.category} && ${catogoryController.subCategory}",
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
