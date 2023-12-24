import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/customColors.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CustomColors.grey,
      highlightColor: CustomColors.grey,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            child: CircleAvatar(
              backgroundColor: CustomColors.grey,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 16,
                  decoration: BoxDecoration(
                      color: CustomColors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                ),
                SizedBox(height: 10),
                Container(
                  width: 140,
                  height: 16,
                  decoration: BoxDecoration(
                      color: CustomColors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
