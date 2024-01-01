import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shedmedd/components/profileShimmer.dart';
import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';
import '../../database/usersDB.dart';
import '../customCircularProg.dart';
import '../errorWidget.dart';

class Seller extends StatelessWidget {
  final String sellerID;
  const Seller({super.key, required this.sellerID});

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot> seller = UsersDatabase().getOneUser(sellerID);

    return FutureBuilder(
      future: seller,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: CustomErrorWidget(
                  errorText: 'An error occured. Try again later'));
        } else if (snapshot.hasData) {
          DocumentSnapshot<Object?>? user = snapshot.data;
          if (user == null || !user.exists) {
            return CustomErrorWidget(errorText: 'User does not exist!');
          }
          String initials = user['name'].toUpperCase().substring(0, 2);
          String imageUrl = user['profile_pic'];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                child: CircleAvatar(
                    backgroundColor: CustomColors.grey,
                    child: ClipOval(
                        child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(child: CustomCircularProgress()),
                      errorWidget: (context, url, error) => Text(initials),
                    ))),
              ),
              SizedBox(
                width: 20,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 180),
                      child: Text(
                        user['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: TextSizes.medium,
                            color: CustomColors.textPrimary),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    user['location'] != ''
                        ? Container(
                            width: 200,
                            child: Text(
                              user['location'],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: TextSizes.small,
                                  color: CustomColors.textPrimary),
                            ),
                          )
                        : Visibility(visible: false, child: Text(''))
                  ],
                ),
              ),
            ],
          );
        } else {
          return ProfileShimmer();
        }
      },
    );
  }
}
