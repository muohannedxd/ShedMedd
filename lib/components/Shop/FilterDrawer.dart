import 'package:flutter/material.dart';

import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  // price
  RangeValues _selectedRange = RangeValues(0, 10000);

  // category
  List<DropdownMenuItem> categories = [
    DropdownMenuItem(
      child: Text('Men'),
      value: 'Men',
    ),
    DropdownMenuItem(
      child: Text('Women'),
      value: 'Women',
    ),
    DropdownMenuItem(
      child: Text('Kids'),
      value: 'Kids',
    ),
  ];
  String selectedCategory = 'Men';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: CustomColors.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: TextSizes.title,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.filter_list_rounded,
                    color: CustomColors.textPrimary,
                    size: TextSizes.title,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                        fontSize: TextSizes.medium,
                        fontWeight: FontWeight.w500),
                  ),
                  RangeSlider(
                    divisions: 100,
                    activeColor: CustomColors.buttonPrimary,
                    values: _selectedRange,
                    min: 0,
                    max: 10000,
                    onChanged: (RangeValues newRange) {
                      setState(() {
                        _selectedRange = newRange;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedRange.start.toStringAsFixed(0)} DZD',
                        style: TextStyle(
                            fontSize: TextSizes.small,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${_selectedRange.end.toStringAsFixed(0)} DZD',
                        style: TextStyle(
                            fontSize: TextSizes.small,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                        fontSize: TextSizes.medium,
                        fontWeight: FontWeight.w500),
                  ),
                  DropdownButton(
                      value: selectedCategory,
                      items: categories,
                      onChanged: (ValueChanged) {
                        setState(() {
                          selectedCategory = ValueChanged;
                        });
                      })
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sub Category',
                    style: TextStyle(
                        fontSize: TextSizes.medium,
                        fontWeight: FontWeight.w500),
                  ),
                  Text('choosing category')
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Condition',
                    style: TextStyle(
                        fontSize: TextSizes.medium,
                        fontWeight: FontWeight.w500),
                  ),
                  Text('choosing category')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
