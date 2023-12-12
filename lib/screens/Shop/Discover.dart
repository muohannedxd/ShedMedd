import 'package:flutter/material.dart';
import 'package:shedmedd/config/searchArguments.dart';
import '../../components/Divider.dart';
import '../../config/bouncingScroll.dart';
import '../../config/myBehavior.dart';
import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  String search = "";
  List<bool> showSubCategory = [false, false, false];

  void toggleSubcategories(int index) {
    setState(() {
      for (int i = 0; i < showSubCategory.length; i++) {
        if (i != index) showSubCategory[i] = false;
      }
      showSubCategory[index] = !showSubCategory[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: BehaviorOfScroll(),
      child: Scaffold(
        backgroundColor: CustomColors.bgColor,
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 20, bottom: 20),
              child: SearchBar(
                  //constraints: BoxConstraints(
                  //    minWidth: 200, maxWidth: 220, minHeight: 56),
                  hintText: 'Search',
                  hintStyle: MaterialStateProperty.all(TextStyle(
                      color: CustomColors.textGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: TextSizes.small)),
                  backgroundColor: MaterialStateProperty.all(Color(0XFFFAFAFA)),
                  shadowColor:
                      MaterialStateProperty.all(CustomColors.textPrimary),
                  elevation: MaterialStateProperty.all(2),
                  shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
                  //controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 20.0)),
                  onChanged: (_) {
                    setState(() {
                      search = _;
                    });
                    //print(search);
                  },
                  leading: Image.asset(
                    'assets/icons/search_filled.png',
                    width: 22,
                    color: CustomColors.textPrimary.withOpacity(0.4),
                  ))),
          Expanded(
            child: ListView(
              children: [
                // Categories
                Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        MainCategory(
                          onToggle: () {
                            toggleSubcategories(0);
                          },
                          showSubcategories: showSubCategory[0],
                          category: 'Men',
                          bgColor: Color.fromARGB(255, 159, 164, 143),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        MainCategory(
                          onToggle: () {
                            toggleSubcategories(1);
                          },
                          showSubcategories: showSubCategory[1],
                          category: 'Women',
                          bgColor: Color.fromARGB(255, 205, 200, 199),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        MainCategory(
                          onToggle: () {
                            toggleSubcategories(2);
                          },
                          showSubcategories: showSubCategory[2],
                          category: 'Kids',
                          bgColor: Color.fromARGB(255, 177, 202, 210),
                        )
                      ],
                    )),

                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class MainCategory extends StatefulWidget {
  final String category;
  final Color bgColor;
  final Function onToggle;
  final bool showSubcategories;

  const MainCategory(
      {super.key,
      required this.category,
      required this.bgColor,
      required this.onToggle,
      required this.showSubcategories});

  @override
  State<MainCategory> createState() => _MainCategoryState();
}

class _MainCategoryState extends State<MainCategory> {
  @override
  Widget build(BuildContext context) {
    String imagePath = '';
    if (widget.category == 'Men') {
      imagePath = 'man.jpeg';
    }
    if (widget.category == 'Women') {
      imagePath = 'woman.jpeg';
    }
    if (widget.category == 'Kids') {
      imagePath = 'child.jpeg';
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.onToggle();
            });
          },
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.category,
                      style: TextStyle(
                          color: CustomColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: TextSizes.subtitle),
                    ),
                    ColorFiltered(
                      colorFilter:
                          ColorFilter.mode(widget.bgColor, BlendMode.darken),
                      child: Image.asset('assets/images/${imagePath}'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),

        // subcategories
        widget.showSubcategories
            ? SingleChildScrollView(
                physics: BouncingScroll(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SubCategory(
                      category: widget.category,
                      subcategory: 'Tops',
                      //itemsNumber: 40
                    ),
                    DividerWidget(),
                    SubCategory(
                      category: widget.category,
                      subcategory: 'Pants',
                      //itemsNumber: 42
                    ),
                    DividerWidget(),
                    SubCategory(
                      category: widget.category,
                      subcategory: 'Shoes',
                      //itemsNumber: 40
                    ),
                    DividerWidget(),
                    SubCategory(
                      category: widget.category,
                      subcategory: 'Outfits',
                      //itemsNumber: 12
                    ),
                    DividerWidget(),
                    SubCategory(
                      category: widget.category,
                      subcategory: 'Others',
                      //itemsNumber: 122
                    ),
                    DividerWidget(),
                  ],
                ),
              )
            : Visibility(visible: false, child: Text(""))
      ],
    );
  }
}

class SubCategory extends StatelessWidget {
  final String category;
  final String subcategory;
  //final int itemsNumber;
  const SubCategory({
    super.key,
    required this.category,
    required this.subcategory,
    //required this.itemsNumber
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 14, top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subcategory,
            style: TextStyle(
                color: CustomColors.textPrimary, fontSize: TextSizes.medium),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/discover/results',
                  arguments:
                      SearchArguments('${category} ${subcategory}', false));
            },
            child: Row(
              children: [
                Text(
                  'Browse all',
                  style: TextStyle(color: CustomColors.textGrey),
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
