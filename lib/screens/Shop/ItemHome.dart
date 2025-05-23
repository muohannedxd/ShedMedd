import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shedmedd/components/floating_button.dart';
import 'package:shedmedd/components/customCircularProg.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/database/itemsDB.dart';
import 'package:shedmedd/screens/Authentification/sign_up.dart';
import 'package:shedmedd/utilities/successfulSnackBar.dart';
import '../../components/Shop/ItemInformation.dart';
import '../../components/Shop/ItemPictures.dart';
import '../../components/Shop/ItemSeller.dart';
import '../../components/errorWidget.dart';
import '../../database/chatDB.dart';
import '../../utilities/myBehavior.dart';
import '../../utilities/returnAction.dart';
import '../../constants/textSizes.dart';
import '../../database/usersDB.dart';
import 'Home.dart';

class ItemHome extends StatelessWidget {
  final String itemID;

  ItemHome({Key? key, required this.itemID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot> currentItem = ItemsDatabase().getOneItem(itemID);

    String loggedInId = "";
    bool isLoggedIn = false;
    if (FirebaseAuth.instance.currentUser != null) {
      isLoggedIn = true;
      loggedInId = FirebaseAuth.instance.currentUser!.uid;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: CustomColors.bgColor, // Set the color you want
        statusBarIconBrightness:
            Brightness.dark, // Use dark icons for better visibility
      ),
      child: Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future: currentItem,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CustomCircularProgress(),
              );
            } else if (snapshot.hasError) {
              return CustomErrorWidget(
                errorText: 'An error occured. Try again later',
              );
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return CustomErrorWidget(errorText: 'Item does not exist!');
            }

            DocumentSnapshot<Object?>? item = snapshot.data;

            return Stack(
              children: [
                Center(
                  child: ScrollConfiguration(
                    behavior: BehaviorOfScroll(),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: Pictures(images: item!['images']),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 10),
                          child: Seller(sellerID: item['user_id']),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 20),
                          child: ItemInformation(
                            title: item['title'],
                            category: item['category'],
                            subcategory: item['subcategory'],
                            condition: item['condition'],
                            price: item['price'],
                            isSold: item['isSold'],
                            description: item['description'],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.width * 0.04,
                  child: FloatingButton(
                    action: returnToPreviousPage,
                  ),
                ),
                if (item['user_id'] == loggedInId)
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.04,
                    right: MediaQuery.of(context).size.width * 0.095,
                    child: SettingsButton(
                      itemID: item.id,
                      imagesPaths: item['images'],
                      isSold: item['isSold'],
                    ),
                  ),
                if (item['user_id'] != loggedInId)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DirectMessageButton(
                        item_id: itemID,
                        title: item['title'],
                        condition: item['condition'],
                        price: item['price'],
                        sellerID: item['user_id'],
                        currentUserId: loggedInId,
                        loggedIn: isLoggedIn),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DirectMessageButton extends StatelessWidget {
  const DirectMessageButton({
    super.key,
    required this.item_id,
    required this.title,
    required this.condition,
    required this.price,
    required this.sellerID,
    required this.currentUserId,
    required this.loggedIn,
  });

  final String item_id;
  final String title;
  final String condition;
  final int price;
  final String sellerID;
  final String currentUserId;
  final bool loggedIn;

  void navigateToChat(
      BuildContext context, DocumentSnapshot<Object?>? user) async {
    //String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    if (loggedIn) {
      String gc_id =
          await ChatDatabase().getGroupChatId(sellerID, currentUserId, item_id);

      // if chat does not exist
      if (gc_id == 'null') {
        // create one
        gc_id = await ChatDatabase()
            .createGroupChat(currentUserId, sellerID, item_id);
      }
      Navigator.pushNamed(
        context,
        '/message',
        arguments: {
          'gc_id': gc_id, // change this later
          'title': title,
          'condition': condition,
          'price': price,
          'receiverName': user?['name']
        },
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUp(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot> seller = UsersDatabase().getOneUser(sellerID);

    return Container(
        decoration: BoxDecoration(
            color: CustomColors.buttonPrimary,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        width: double.infinity,
        child: FutureBuilder(
          future: seller,
          builder: (context, snapshot) {
            DocumentSnapshot<Object?>? user = snapshot.data;
            if (snapshot.hasData) {
              return TextButton(
                onPressed: () async {
                  navigateToChat(context, user);
                },
                child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/dm.png',
                            width: 20, color: CustomColors.white),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Message the Seller',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.white,
                            fontSize: TextSizes.subtitle,
                          ),
                        ),
                      ],
                    )),
              );
            } else {
              return Center(
                child: Text('an error occured'),
              );
            }
          },
        ));
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton(
      {super.key,
      required this.itemID,
      required this.imagesPaths,
      this.isSold = false});
  final itemID;
  final bool isSold;
  final imagesPaths;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 32),
      child: Material(
        elevation: 2,
        shape: CircleBorder(),
        color: CustomColors.white,
        child: Container(
          width: 38,
          height: 38,
          child: PopupMenuButton(
            surfaceTintColor: CustomColors.textGrey,
            elevation: 16.0,
            icon: Icon(
              Icons.more_vert_rounded,
              color: CustomColors.textPrimary,
              size: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ), // Rectangular shape with rounded corners
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  enabled: !isSold,
                  value: 'Mark as Sold',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () =>
                          !isSold ? showMarkAsSoldDialog(context) : null,
                      child: ListTile(
                        leading: Image.asset(
                          'assets/icons/sold_out.png',
                          color: !isSold
                              ? CustomColors.textPrimary
                              : CustomColors.textGrey,
                          width: 20,
                        ),
                        title: Text('Mark as Sold',
                            style: TextStyle(
                                color: !isSold
                                    ? CustomColors.textPrimary
                                    : CustomColors.textGrey)),
                      ),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () => showDeleteItemDialog(context),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/icons/delete.png',
                          color: CustomColors.textPrimary,
                          width: 20,
                        ),
                        title: Text('Delete',
                            style: TextStyle(color: CustomColors.textPrimary)),
                      ),
                    ),
                  ),
                ),
              ];
            },
            position: PopupMenuPosition.under,
          ),
        ),
      ),
    );
  }

  void showDeleteItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Remove item',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CustomColors.textPrimary),
          ),
          content: Text(
            'Are you sure you want to delete this product?',
            style: TextStyle(
                fontSize: TextSizes.medium, color: CustomColors.textPrimary),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontSize: TextSizes.medium,
                    color: CustomColors.textPrimary),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (await ItemsDatabase().deleteItem(itemID, imagesPaths)) {
                  showSnackBar(context, 'Item Deleted Successfully:',
                      CustomColors.successGreen);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Shop(currentIndex: 4),
                    ),
                  );
                } else {
                  showSnackBar(context, 'Item Could not be deleted!',
                      CustomColors.redAlert);
                }
              },
              child: Text(
                'Delete',
                style: TextStyle(
                    fontSize: TextSizes.medium, color: CustomColors.redAlert),
              ),
            ),
          ],
        );
      },
    );
  }

  void showMarkAsSoldDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Mark As Sold',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CustomColors.textPrimary),
          ),
          content: Text(
            'Marking an item as Sold is a permanent action. You will not be able to change its status back.',
            style: TextStyle(
                fontSize: TextSizes.medium, color: CustomColors.textPrimary),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontSize: TextSizes.medium,
                    color: CustomColors.textPrimary),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (await ItemsDatabase().markItemAsSold(itemID)) {
                  showSnackBar(context, 'Item is marked Sold!',
                      CustomColors.successGreen);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Shop(currentIndex: 4),
                    ),
                  );
                } else {
                  showSnackBar(context, 'An error occured, try again later!',
                      CustomColors.redAlert);
                }
              },
              child: Text(
                'Mark as Sold',
                style: TextStyle(
                    fontSize: TextSizes.medium,
                    color: CustomColors.textPrimary),
              ),
            ),
          ],
        );
      },
    );
  }
}
