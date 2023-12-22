import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/customColors.dart';

class ItemCardShimmer extends StatelessWidget {
  const ItemCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CustomColors.grey,
      highlightColor: CustomColors.grey,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 136,
              height: 180,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: CustomColors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              height: 14,
              decoration: BoxDecoration(
                  color: CustomColors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2))),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              width: 80,
              height: 16,
              decoration: BoxDecoration(
                  color: CustomColors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2))),
            ),
          ],
        ),
      ),
    );
  }
}
