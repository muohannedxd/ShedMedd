import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/components/emptyListWidget.dart';
import 'package:shedmedd/components/errorWidget.dart';
import 'package:shedmedd/config/searchArguments.dart';
import '../../components/itemCardShimmer.dart';
import '../../config/bouncingScroll.dart';
import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';
import '../../components/itemCard.dart';
import '../../components/Shop/CategoryChooser.dart';
import '../../controller/items/itemsController.dart';

class ShopHome extends StatelessWidget {
  ShopHome({
    super.key,
  });

  //final Map<String, dynamic> items;
  final ItemsController itemsController = Get.put(ItemsController());

  /**
   * refresh on slide down
   */
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshPage() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    itemsController.updateCategoryChooser(itemsController.category.value);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    /**
     * number of shown item in each category
     */
    final int showCount = 10;

    /**
     * To display data when widget first loads 
     */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      itemsController.updateCategoryChooser(itemsController.category.value);
    });

    return RefreshIndicator(
      backgroundColor: CustomColors.bgColor,
      color: CustomColors.textPrimary,
      displacement: MediaQuery.of(context).size.height * 0.08,
      key: refreshKey,
      onRefresh: refreshPage,
      child: ListView(
        children: [
          // category chooser
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
            child: CategoryChooser(controller: itemsController),
          ),
      
          // Feature Products
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Feature Products',
                      style: TextStyle(
                          color: CustomColors.textPrimary,
                          fontSize: TextSizes.subtitle,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/discover/results',
                            arguments: SearchArguments(
                                '${itemsController.category.value} All',
                                false,
                                false));
                      },
                      child: Text(
                        'Show all',
                        style: TextStyle(color: CustomColors.textGrey),
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                    physics: BouncingScroll(),
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: FutureBuilder(
                              future: itemsController.categoriedItems.value,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<DocumentSnapshot<Object?>>? itemsList =
                                      snapshot.data;
                                  if (itemsList!.isEmpty) {
                                    return EmptyListWidget(
                                        emptyError:
                                            'There are no items to show here.');
                                  } else {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: itemsList
                                          .take(showCount)
                                          .map((document) =>
                                              ItemCard(item: document))
                                          .toList(),
                                    );
                                  }
                                } else if (snapshot.hasError) {
                                  return CustomErrorWidget(
                                      errorText:
                                          'An error occured. Try again later');
                                } else {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ItemCardShimmer(),
                                      ItemCardShimmer(),
                                      ItemCardShimmer()
                                    ],
                                  );
                                }
                              })),
                    ))
              ],
            ),
          ),
      
          // Recommended
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended',
                      style: TextStyle(
                          color: CustomColors.textPrimary,
                          fontSize: TextSizes.subtitle,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/discover/results',
                            arguments: SearchArguments(
                                '${itemsController.category.value} All',
                                false,
                                false));
                      },
                      child: Text(
                        'Show all',
                        style: TextStyle(color: CustomColors.textGrey),
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                  physics: BouncingScroll(),
                  scrollDirection: Axis.horizontal,
                  child: Obx(() => Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: FutureBuilder(
                          future: itemsController.categoriedItems.value,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<DocumentSnapshot<Object?>>? itemsList =
                                  snapshot.data;
                              if (itemsList!.isEmpty) {
                                return EmptyListWidget(
                                    emptyError:
                                        'There are no items to show here.');
                              } else {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: itemsList
                                      .take(showCount)
                                      .map((document) => ItemCard(item: document))
                                      .toList(),
                                );
                              }
                            } else if (snapshot.hasError) {
                              return CustomErrorWidget(
                                  errorText: 'An error occured. Try again later');
                            } else {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ItemCardShimmer(),
                                  ItemCardShimmer(),
                                  ItemCardShimmer()
                                ],
                              );
                            }
                          }))),
                ),
              ],
            ),
          ),
      
          // Deals
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Deals',
                      style: TextStyle(
                          color: CustomColors.textPrimary,
                          fontSize: TextSizes.subtitle,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/discover/results',
                            arguments: SearchArguments(
                                '${itemsController.category.value} All',
                                false,
                                false));
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(color: CustomColors.textGrey),
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                  physics: BouncingScroll(),
                  scrollDirection: Axis.horizontal,
                  child: Obx(() => Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: FutureBuilder(
                          future: itemsController.categoriedItems.value,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<DocumentSnapshot<Object?>>? itemsList =
                                  snapshot.data;
                              if (itemsList!.isEmpty) {
                                return EmptyListWidget(
                                    emptyError:
                                        'There are no items to show here.');
                              } else {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: itemsList
                                      .take(showCount)
                                      .map((document) => ItemCard(item: document))
                                      .toList(),
                                );
                              }
                            } else if (snapshot.hasError) {
                              return CustomErrorWidget(
                                  errorText: 'An error occured. Try again later');
                            } else {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ItemCardShimmer(),
                                  ItemCardShimmer(),
                                  ItemCardShimmer()
                                ],
                              );
                            }
                          }))),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
