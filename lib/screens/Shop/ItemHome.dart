import 'package:flutter/material.dart';

class ItemHome extends StatefulWidget {
  const ItemHome({super.key});

  @override
  State<ItemHome> createState() => _ItemHome();
}

class _ItemHome extends State<ItemHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Home of an item'),),
    );
  }
}