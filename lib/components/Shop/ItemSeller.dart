import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shedmedd/config/customCircularProg.dart';

import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';
import '../../database/usersDB.dart';

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
            child: Text('an error occured'),
          );
        } else if (snapshot.hasData) {
          DocumentSnapshot<Object?>? user = snapshot.data;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  backgroundColor: CustomColors.grey,
                  child: Text('MK'),
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
                      constraints: BoxConstraints(maxWidth: 180),
                      child: Text(
                        user?['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: TextSizes.medium,
                            color: CustomColors.textPrimary),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        user?['location'],
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: TextSizes.small,
                            color: CustomColors.textPrimary),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CustomCircularProgress(),
          );
        }
      },
    );
  }
}
