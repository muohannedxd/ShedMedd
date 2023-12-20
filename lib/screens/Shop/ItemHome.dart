import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shedmedd/components/back_header_widget.dart';
import 'package:shedmedd/components/customCircularProg.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/database/itemsDB.dart';
import '../../components/Shop/ItemInformation.dart';
import '../../components/Shop/ItemPictures.dart';
import '../../components/Shop/ItemSeller.dart';
import '../../components/errorWidget.dart';
import '../../config/myBehavior.dart';
import '../../constants/textSizes.dart';
import '../../database/usersDB.dart';
import 'Home.dart';

class ItemHome extends StatelessWidget {
  final String itemID;
  final bool isSeller;

  ItemHome({super.key, required this.itemID, this.isSeller = false});

  @override
  Widget build(BuildContext context) {
    //dynamic currentItem = itemsController.getItem(1);
    Future<DocumentSnapshot> currentItem = ItemsDatabase().getOneItem(itemID);

    return Scaffold(
      body: FutureBuilder(
          future: currentItem,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return CustomErrorWidget(
                  errorText: 'An error occured. Try again later');
            } else if (snapshot.hasData) {
              DocumentSnapshot<Object?>? item = snapshot.data;
              if (item == null || !item.exists) {
                return CustomErrorWidget(errorText: 'Item does not exist!');
              }
              return Stack(children: [
                Center(
                    child: ScrollConfiguration(
                  behavior: BehaviorOfScroll(),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Pictures(images: item['images']),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 10, bottom: 10),
                        child: Seller(sellerID: item['user_id']),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 20),
                        child: ItemInformation(
                            title: item['title'],
                            category: item['category'],
                            subcategory: item['subcategory'],
                            condition: item['condition'],
                            price: item['price'],
                            description: item['description']),
                      ),
                    ],
                  ),
                )),

                // return button
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.04,
                    left: MediaQuery.of(context).size.width * 0.065,
                    child: BackHeaderWidget(
                      title: '',
                    )),

                isSeller
                    ? Positioned(
                        top: MediaQuery.of(context).size.height * 0.06,
                        right: MediaQuery.of(context).size.width * 0.05,
                        child: SettingsButton(
                          itemID: item.id,
                          imagesPaths: item['images'],
                        ))
                    : Visibility(visible: false, child: Text('')),

                // go to DM button
                !isSeller
                    ? Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: DirectMessageButton(
                            title: item['title'],
                            condition: item['condition'],
                            price: item['price'],
                            sellerID: item['user_id']),
                      )
                    : Visibility(visible: false, child: Text('')),
              ]);
            } else {
              return Center(
                child: CustomCircularProgress(),
              );
            }
          }),
    );
  }
}

class DirectMessageButton extends StatelessWidget {
  const DirectMessageButton({
    super.key,
    required this.title,
    required this.condition,
    required this.price,
    required this.sellerID,
  });

  final String title;
  final String condition;
  final int price;
  final String sellerID;

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
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/message',
                    arguments: {
                      'title': title,
                      'condition': condition,
                      'price': price,
                      'sellerName': user?['name']
                    },
                  );
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

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: CustomColors.white,
      onPressed: () => Navigator.pop(context),
      child: Icon(
        Icons.arrow_back_ios_rounded,
        color: CustomColors.textPrimary,
        size: 20,
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton(
      {super.key, required this.itemID, required this.imagesPaths});
  final itemID;
  final imagesPaths;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
        backgroundColor: CustomColors.white,
        onPressed: () => print(''),
        child: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit_outlined,
                      color: CustomColors.textPrimary),
                  title: Text(
                    'Edit',
                    style: TextStyle(color: CustomColors.textPrimary),
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: GestureDetector(
                  onTap: () => showDeleteItemDialog(context),
                  child: ListTile(
                    leading: Icon(Icons.delete_outline,
                        color: CustomColors.textPrimary),
                    title: Text('Delete',
                        style: TextStyle(color: CustomColors.textPrimary)),
                  ),
                ),
              ),
            ];
          },
          child: Icon(
            Icons.more_vert_rounded,
            color: CustomColors.textPrimary,
          ),
        ));
  }

  void showDeleteItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color to white
          title: Text(
            'Logout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this product?',
            style: TextStyle(
              fontSize: TextSizes.medium,
            ),
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
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await ItemsDatabase().deleteItem(itemID, imagesPaths);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Shop(currentIndex: 4),
                  ),
                );
                ;
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  fontSize: TextSizes.medium,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
