import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/screens/AppSupport/ChatInbox.dart';
import 'package:shedmedd/screens/Authentification/sign_up.dart';
import 'package:shedmedd/screens/Profile/Profile.dart';
import 'package:shedmedd/screens/Shop/Discover.dart';
import '../../components/Bar.dart';
import '../../components/Drawer.dart';
import '../../controller/auth/auth_controller.dart';
//import '../../controller/auth/email_controller.dart';
import '../../database/usersDB.dart';
import '../Authentification/email_verification/email_verification.dart';
import '../Post_item/post_an_new_item.dart';
import 'ShopHome.dart';
import '../../constants/customColors.dart';
import '../../utilities/myBehavior.dart';

class Shop extends StatefulWidget {
  final int currentIndex;
  const Shop({super.key, required this.currentIndex});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  // current Page
  late int currentPageIndex;
  bool isShownBottomBar = true;

  final AuthController authController = Get.put(AuthController());
  final bool isLoggedIn = AuthController().isLoggedIn();
  //final EmailController _emailController = Get.put(EmailController());

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.currentIndex;
    checkVerificationStatus();
  }

  Future<void> checkVerificationStatus() async {
    bool isVerified = await UsersDatabase().isUserVerified();
    if (!isVerified && isLoggedIn) {
      Get.offAll(VerificationEmail());
    }
  }

  @override
  Widget build(BuildContext context) {
    // list of pages
    List<Widget> _pages = <Widget>[
      ShopHome(),
      Discover(),
      isLoggedIn ? PostAnItem() : SignUp(),
      isLoggedIn ? ChatInbox() : SignUp(),
      isLoggedIn ? Profile() : SignUp(),
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
            : null, // Set to null if isShownBottomBar is false
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
                height: 60,
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
                      } else if ((index == 3 || index == 4) && !isLoggedIn) {
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
                        color: CustomColors.textPrimary,
                      ),
                      icon: Image.asset(
                        'assets/icons/home.png',
                        width: 20,
                        color: CustomColors.textGrey,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/icons/search_filled.png',
                        width: 22,
                        color: CustomColors.textPrimary,
                      ),
                      icon: Image.asset('assets/icons/search.png',
                          width: 20, color: CustomColors.textGrey),
                      label: 'Discover',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset('assets/icons/post.png',
                          width: 22, color: CustomColors.textPrimary),
                      icon: Image.asset('assets/icons/post.png',
                          width: 20, color: CustomColors.textGrey),
                      label: 'Add',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset('assets/icons/inbox_filled.png',
                          width: 24, color: CustomColors.textPrimary),
                      icon: Image.asset('assets/icons/inbox.png',
                          width: 22, color: CustomColors.textGrey),
                      label: 'Inbox',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset('assets/icons/profile_filled.png',
                          width: 22, color: CustomColors.textPrimary),
                      icon: Image.asset('assets/icons/profile.png',
                          width: 20, color: CustomColors.textGrey),
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
