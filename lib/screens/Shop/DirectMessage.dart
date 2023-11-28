import 'package:flutter/material.dart';
import 'package:shedmedd/components/Shop/ItemNamePrice.dart';

import '../../../../../components/Shop/ReturnButton.dart';

class DirectMessage extends StatefulWidget {
  const DirectMessage({super.key});

  @override
  State<DirectMessage> createState() => _DirectMessage();
}

class _DirectMessage extends State<DirectMessage> {
  String name = '';
  String condition = '';
  int price = 0;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    name = arguments['name'] as String;
    condition = arguments['condition'] as String;
    price = arguments['price'] as int;

    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: Scaffold(
        body: ListView(children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
            child: ReturnButton(searchKey: 'Mohanned Kadache'),
          ),
          Divider(),
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            child:
                ItemNamePrice(name: name, condition: condition, price: price),
          ),
          Divider()
        ]),
      ),
    );
  }
}
