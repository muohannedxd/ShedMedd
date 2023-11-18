import 'package:flutter/material.dart';
import 'package:shedmedd/components/Bar.dart';
import 'package:shedmedd/constants/customColors.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar('ShedMedd'),
      drawer: Drawer(
        child: Center(
          child: Text('yaaa'),
        )
        
      ),
      backgroundColor: CustomColors.bgColor,
      body: ListView(
        children: [
          Text('hhhh'),
          SizedBox(
            height: 400,
          ),
          Text('hhhh'),
          SizedBox(
            height: 400,
          ),
          Text('hhhh'),
          SizedBox(
            height: 400,
          ),
          Text('hhhh'),
          SizedBox(
            height: 400,
          ),
          Text('hhhh'),
          SizedBox(
            height: 400,
          ),
          Text('hhhh'),
          SizedBox(
            height: 400,
          ),
        ],
      ),
    );
  }
}
