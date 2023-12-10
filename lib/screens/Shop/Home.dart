import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/components/BarWithReturn.dart';
import 'package:shedmedd/controller/items/itemsController.dart';
import 'package:shedmedd/screens/AppSupport/ChatInbox.dart';
import 'package:shedmedd/screens/Profile/Profile.dart';
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
  
  final ItemsController itemsController = Get.put(ItemsController());

  // dummy data
  //Map<String, dynamic> items = clothingItems;
  // current Page
  late int currentPageIndex;
  bool isShownBottomBar = true;

  @override
  void initState() {
    currentPageIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // list of pages
    List<Widget> _pages = <Widget>[
      ShopHome(controller: itemsController),
      Discover(),
      PostAnItem(),
      ChatInbox(),
      Profile(),
    ];
    List<String> _pageTitles = [
      'ShedMedd',
      'Discover',
      'Sell an Item',
      'Inbox',
      'Profile'
    ];
    List<bool> _isSubpage = [false, false, true, true, false];

    return ScrollConfiguration(
      behavior: BehaviorOfScroll(),
      child: Scaffold(
        appBar: isShownBottomBar
            ? Bar(_pageTitles[currentPageIndex], _isSubpage[currentPageIndex])
            : BarWithReturn(context, 'Sell an Item', returnPage: 'shop'),
        drawer: AppDrawer(
          current: currentPageIndex,
        ),
        backgroundColor: CustomColors.bgColor,
        body: _pages[currentPageIndex],
        bottomNavigationBar: Visibility(
          visible: isShownBottomBar,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: CustomColors.grey,
                width: 2.4,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.5),
                topRight: Radius.circular(24.5),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              child: SizedBox(
                height: 80,
                child: BottomNavigationBar(
                  backgroundColor: CustomColors.bgColor,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentPageIndex,
                  selectedItemColor: CustomColors.textPrimary,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  onTap: (int index) {
                    setState(() {
                      if (index == 2) {
                        isShownBottomBar = false;
                      }
                      currentPageIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/icons/home_filled.png',
                        width: 22,
                      ),
                      icon: Image.asset(
                        'assets/icons/home.png',
                        width: 20,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset('assets/icons/search_filled.png',
                          width: 26),
                      icon: Image.asset(
                        'assets/icons/search.png',
                        width: 24,
                      ),
                      label: 'Discover',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/icons/post_filled.png',
                        width: 22,
                      ),
                      icon: Image.asset(
                        'assets/icons/post.png',
                        width: 20,
                      ),
                      label: 'Add',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/icons/inbox_filled.png',
                        width: 24,
                      ),
                      icon: Image.asset(
                        'assets/icons/inbox.png',
                        width: 22,
                      ),
                      label: 'Inbox',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/icons/profile_filled.png',
                        width: 22,
                      ),
                      icon: Image.asset(
                        'assets/icons/profile.png',
                        width: 20,
                      ),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
