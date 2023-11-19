import 'package:flutter/material.dart';
import 'package:shedmedd/config/myBehavior.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    final searchKey = ModalRoute.of(context)!.settings.arguments as String;

    return ScrollConfiguration(
      behavior: BehaviorOfScroll(),
      child: Scaffold(
        backgroundColor: CustomColors.bgColor,
        body: ListView(
          children: [
            // return button
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 20, bottom: 20),
              child: ReturnButton(searchKey: searchKey),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 20, bottom: 20),
              child: Row(
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
                        '142 results',
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
                  Text(
                    searchKey,
                    style: TextStyle(
                        color: CustomColors.textPrimary,
                        fontSize: TextSizes.medium,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),

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
        SizedBox(
          width: 20,
        ),
        TextButton(
          onPressed: () {
            print('filtering button');
          },
          child: Row(
            children: [
              Text(
                    searchKey,
                    style: TextStyle(
                        color: CustomColors.textPrimary,
                        fontSize: TextSizes.medium,
                        fontWeight: FontWeight.bold),
                  )
            ],
          ),
        )
      ],
    );
  }
}
