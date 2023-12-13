import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shedmedd/components/button.dart';
import 'package:shedmedd/config/customCircularProg.dart';
import 'package:shedmedd/config/searchArguments.dart';
import 'package:shedmedd/database/itemsDB.dart';
import '../../components/itemCard.dart';
import '../../config/bouncingScroll.dart';
import '../../config/myBehavior.dart';
import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';

class QuickSearchResults extends StatefulWidget {
  const QuickSearchResults({super.key});

  @override
  State<QuickSearchResults> createState() => _QuickSearchResults();
}

class _QuickSearchResults extends State<QuickSearchResults> {
  // price
  RangeValues _selectedRange = RangeValues(0, 10000);
  //final ItemsController itemsController = Get.put(ItemsController());

  // category
  List<DropdownMenuItem> categories = [
    DropdownMenuItem(
      child: Text('All'),
      value: 'All',
    ),
    DropdownMenuItem(
      child: Text('Men'),
      value: 'Men',
    ),
    DropdownMenuItem(
      child: Text('Women'),
      value: 'Women',
    ),
    DropdownMenuItem(
      child: Text('Kids'),
      value: 'Kids',
    ),
  ];
  String selectedCategory = 'Men';

  // sub category
  List<DropdownMenuItem> subcategories = [
    DropdownMenuItem(
      child: Text('All'),
      value: 'All',
    ),
    DropdownMenuItem(
      child: Text('Tops'),
      value: 'Tops',
    ),
    DropdownMenuItem(
      child: Text('Pants'),
      value: 'Pants',
    ),
    DropdownMenuItem(
      child: Text('Shoes'),
      value: 'Shoes',
    ),
    DropdownMenuItem(
      child: Text('Outfits'),
      value: 'Outfits',
    ),
    DropdownMenuItem(
      child: Text('Others'),
      value: 'Others',
    ),
  ];
  String selectedSubcategory = 'Tops';

  // condition
  List<DropdownMenuItem> conditions = [
    DropdownMenuItem(
      child: Text('All'),
      value: 'All',
    ),
    DropdownMenuItem(
      child: Text('New with tags'),
      value: 'New with tags',
    ),
    DropdownMenuItem(
      child: Text('New without tags'),
      value: 'New without tags',
    ),
    DropdownMenuItem(
      child: Text('Very good'),
      value: 'Very good',
    ),
    DropdownMenuItem(
      child: Text('Good'),
      value: 'Good',
    ),
    DropdownMenuItem(
      child: Text('Satisfactory'),
      value: 'Satisfactory',
    ),
  ];
  String selectedCondition = 'All';

  void resetFilters() {
    _selectedRange = RangeValues(0, 10000);
    selectedCategory = 'Men';
    selectedSubcategory = 'Tops';
    selectedCondition = 'All';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as SearchArguments;

    final searchKey = arguments.search;
    selectedCategory = searchKey.split(' ').first;
    selectedSubcategory = searchKey.split(' ').last;
    final isSeller = arguments.seller;

    //Map<String, dynamic> items = itemsController.items;
    Map<String, dynamic> filters = {
      'category': selectedCategory,
      'subcategory': selectedSubcategory,
      'condition': selectedCondition,
      'minPrice': _selectedRange.start,
      'maxPrice': _selectedRange.end
    };
    Future<List<DocumentSnapshot>> filteredItems = ItemsDatabase().getFilteredItems(filters);

    return ScrollConfiguration(
      behavior: BehaviorOfScroll(),
      child: Scaffold(
          endDrawer: FilterDrawer(),
          backgroundColor: CustomColors.bgColor,
          body: FutureBuilder(
              future: filteredItems,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('an error occured'),
                  );
                } else if (snapshot.hasData) {
                  List<DocumentSnapshot<Object?>>? itemsList = snapshot.data;

                  return ListView(
                    children: [
                      // return button
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 10),
                        child: ReturnButton(searchKey: searchKey),
                      ),

                      // Header
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Found',
                                  style: TextStyle(
                                      color: CustomColors.textPrimary,
                                      fontSize: TextSizes.medium,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${itemsList?.length} results',
                                  style: TextStyle(
                                      color: CustomColors.textPrimary,
                                      fontSize: TextSizes.medium,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Builder(builder: (context) {
                              return GestureDetector(
                                  onTap: () {
                                    Scaffold.of(context).openEndDrawer();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: CustomColors.grey),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18,
                                          right: 10,
                                          top: 6,
                                          bottom: 6),
                                      child: Row(
                                        children: [
                                          Text('Filter',
                                              style: TextStyle(
                                                  color:
                                                      CustomColors.textPrimary,
                                                  fontSize: TextSizes.small)),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: CustomColors.textPrimary,
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            }),
                          ],
                        ),
                      ),

                      Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 20, bottom: 10),
                          child: SingleChildScrollView(
                            physics: BouncingScroll(),
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                for (int i = 0; i < itemsList!.length; i += 2)
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: ItemCard(
                                              item: itemsList[i],
                                              isSeller: isSeller,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          if (i + 1 < itemsList.length)
                                            Expanded(
                                              child: ItemCard(
                                                item: itemsList[i + 1],
                                                isSeller: isSeller,
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                              ],
                            ),
                          )),

                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CustomCircularProgress(),
                  );
                }
              })),
    );
  }

  SafeArea FilterDrawer() {
    return SafeArea(
      child: Drawer(
        backgroundColor: CustomColors.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: TextSizes.title,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.filter_list_rounded,
                    color: CustomColors.textPrimary,
                    size: TextSizes.title,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(thickness: 1),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                        fontSize: TextSizes.medium,
                        fontWeight: FontWeight.w500),
                  ),
                  RangeSlider(
                    divisions: 100,
                    activeColor: CustomColors.buttonPrimary,
                    values: _selectedRange,
                    min: 0,
                    max: 10000,
                    onChanged: (RangeValues newRange) {
                      setState(() {
                        _selectedRange = newRange;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedRange.start.toStringAsFixed(0)} DZD',
                        style: TextStyle(
                            fontSize: TextSizes.small,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${_selectedRange.end.toStringAsFixed(0)} DZD',
                        style: TextStyle(
                            fontSize: TextSizes.small,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // category
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                        fontSize: TextSizes.medium,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: CustomColors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButton(
                        value: selectedCategory,
                        items: categories,
                        onChanged: null, // cannot change here
                        isExpanded: true,
                        underline: Container(),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              // subcategory
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sub Category',
                    style: TextStyle(
                        fontSize: TextSizes.medium,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: CustomColors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButton(
                        value: selectedSubcategory,
                        items: subcategories,
                        onChanged: null, // cannot change here
                        isExpanded: true,
                        underline: Container(),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              // Condition
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Condition',
                    style: TextStyle(
                        fontSize: TextSizes.medium,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: CustomColors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButton(
                        value: selectedCondition,
                        items: conditions,
                        onChanged: (ValueChanged) {
                          setState(() {
                            selectedCondition = ValueChanged;
                          });
                        },
                        isExpanded: true,
                        underline: Container(),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    action: resetFilters,
                    title: 'Reset',
                    xPadding: 20,
                    background: CustomColors.bgColor,
                    textColor: CustomColors.textPrimary,
                    borderColor: CustomColors.grey,
                  ),
                  Builder(builder: (context) {
                    return Button(
                      action: () {
                        Scaffold.of(context).closeEndDrawer();
                      },
                      title: 'Apply',
                      xPadding: 20,
                      background: CustomColors.buttonPrimary,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),

        // validation buttons
      ),
    );
  }
}

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
    required this.searchKey,
  });

  final String searchKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
            )),
        Text(
          searchKey,
          style: TextStyle(
              color: CustomColors.textPrimary,
              fontSize: TextSizes.medium,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
