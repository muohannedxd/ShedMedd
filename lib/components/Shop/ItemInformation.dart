import 'package:flutter/material.dart';
import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';
import 'ItemNamePrice.dart';

class ItemInformation extends StatefulWidget {
  const ItemInformation({
    super.key,
    required this.title,
    required this.category,
    required this.subcategory,
    required this.condition,
    required this.price,
    required this.isSold,
    required this.description,
  });

  final String title;
  final String category;
  final String subcategory;
  final String condition;
  final int price;
  final bool isSold;
  final String description;

  @override
  State<ItemInformation> createState() => _ItemInformationState();
}

class _ItemInformationState extends State<ItemInformation> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemNamePrice(
            title: widget.title,
            condition: widget.condition,
            price: widget.price,
            isSold: widget.isSold),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: TextSizes.subtitle,
                    color: CustomColors.textPrimary)),
            SizedBox(
              height: 10,
            ),
            Text(
              '${widget.category}, ${widget.subcategory}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: TextSizes.small,
                  color: CustomColors.textGrey),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: TextSizes.subtitle,
                    color: CustomColors.textPrimary)),
            SizedBox(
              height: 10,
            ),
            _buildDescription(),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    final maxLines = _isExpanded ? null : 3;
    final overflow = _isExpanded ? TextOverflow.visible : TextOverflow.fade;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          maxLines: maxLines,
          overflow: overflow,
          style: TextStyle(
            fontSize: TextSizes.small,
            height: 1.5,
            color: CustomColors.textPrimary.withOpacity(0.8),
          ),
        ),
        if (!_isExpanded && widget.description.length > 3 * 50)
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
            children: [
              TextButton(
                onPressed: () => setState(() => _isExpanded = true),
                child: Text(
                  'Show more',
                  style: TextStyle(color: CustomColors.textGrey),
                ),
              ),
            ],
          ),
        if (_isExpanded)
          Center(
            // Center the "Show less" button
            child: TextButton(
              onPressed: () => setState(() => _isExpanded = false),
              child: Text('Show less',
                  style: TextStyle(color: CustomColors.textPrimary)),
            ),
          ),
        SizedBox(height: 60,)
      ],
    );
  }
}
