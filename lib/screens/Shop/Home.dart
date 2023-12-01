import 'package:flutter/material.dart';
import 'package:shedmedd/data/items.dart';
import 'package:shedmedd/screens/Shop/Discover.dart';
import '../../components/Bar.dart';
import '../../components/Drawer.dart';
import '../Post_item/post_an_new_item.dart';
import 'ShopHome.dart';
import '../../constants/customColors.dart';
import '../../config/myBehavior.dart';

class Shop extends StatefulWidget {
  final int currentIndex;
  const Shop({super.key, required this.currentIndex});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  // dummy data
  Map<String, dynamic> items = clothingItems;
  // current Page
  late int currentPageIndex;

  @override
  void initState() {
    currentPageIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // list of pages
    List<Widget> _pages = <Widget>[
      ShopHome(items: items),
      Discover(),
      PostAnItem()
    ];
    List<String> _pageTitles = ['ShedMedd', 'Discover', 'Sell an item'];
    List<bool> _isSubpage = [false, false, true];

    return ScrollConfiguration(
      behavior: BehaviorOfScroll(),
      child: Scaffold(
        appBar: Bar(_pageTitles[currentPageIndex], _isSubpage[currentPageIndex]),
        drawer: AppDrawer(
          current: currentPageIndex,
        ),
        backgroundColor: CustomColors.bgColor,
        body: _pages[currentPageIndex],
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Shadow color
                  blurRadius: 8, // Shadow blur radius
                  offset: Offset(2, 2), // Shadow offset
                ),
              ],
              color: CustomColors.bgColor),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentPageIndex,
            selectedFontSize: 16,
            selectedItemColor: CustomColors.textPrimary,
            unselectedFontSize: 12,
            onTap: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home, color: CustomColors.textPrimary),
                icon:
                    Icon(Icons.home_outlined, color: CustomColors.textPrimary),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.search, color: CustomColors.textPrimary),
                icon: Icon(Icons.search_outlined,
                    color: CustomColors.textPrimary),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.add_box_rounded,
                    color: CustomColors.textPrimary),
                icon: Icon(Icons.add_box_outlined,
                    color: CustomColors.textPrimary),
                label: 'Add',
              ),
              /*BottomNavigationBarItem(
                activeIcon:
                    Icon(Icons.email_rounded, color: CustomColors.textPrimary),
                icon:
                    Icon(Icons.email_outlined, color: CustomColors.textPrimary),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                activeIcon:
                    Icon(Icons.person_rounded, color: CustomColors.textPrimary),
                icon: Icon(Icons.person_outline_rounded,
                    color: CustomColors.textPrimary),
                label: 'Profile',
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
