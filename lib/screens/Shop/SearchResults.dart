import 'package:flutter/material.dart';
import '../../components/itemCard.dart';
import '../../config/bouncingScroll.dart';
import '../../config/myBehavior.dart';
import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';
import '../../data/items.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    final searchKey = ModalRoute.of(context)!.settings.arguments as String;
    Map<String, dynamic> items = clothingItems;

    return ScrollConfiguration(
      behavior: BehaviorOfScroll(),
      child: Scaffold(
        backgroundColor: CustomColors.bgColor,
        body: ListView(
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
                        '${items.length} results',
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
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: CustomColors.grey)),
                      ),
                      onPressed: () {
                        print('tryna filter');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 10),
                        child: Row(
                          children: [
                            Text('Filter',
                                style: TextStyle(
                                    color: CustomColors.textPrimary,
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
                      )),
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
                      for (int i = 0; i < items.length; i += 2)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ItemCard(
                                    item: items.values.toList()[i],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                if (i + 1 < items.length)
                                  Expanded(
                                    child: ItemCard(
                                      item: items.values.toList()[i+1],
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
        ),
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
