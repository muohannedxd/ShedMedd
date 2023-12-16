import 'package:flutter/material.dart';
import 'package:shedmedd/components/BarWithReturn.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/components/itemCard.dart';

class SellerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarWithReturn(context, 'Seller Profile'),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Section: Profile Information
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: CustomColors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Icon for Settings (if needed)
                        // Profile Picture
                        CircleAvatar(
                          radius: 35,
                          // Add seller profile picture here
                        ),
                        // Add padding between the image and the name
                        SizedBox(width: 20),
                        // Name and Phone Number of the Seller
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Seller Name',
                              style: TextStyle(
                                color: CustomColors.textPrimary,
                                fontSize: TextSizes.title - 6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'minoucha@gmail.com',
                              style: TextStyle(
                                color: CustomColors.textPrimary,
                                fontSize: TextSizes.subtitle - 6,
                              ),
                            ),
                            Text(
                              'Phone Number: 123-456-7890',
                              style: TextStyle(
                                color: CustomColors.textPrimary,
                                fontSize: TextSizes.subtitle - 6,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),

              // Section two

              // Divider Line
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    // Seller Name also sells text
                    Text(
                      "sellerName's Products",
                      style: TextStyle(
                        color: CustomColors.textPrimary,
                        fontSize: TextSizes.subtitle,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: CustomColors.grey,
                      height: 10, // Adjust the height of the line
                      thickness: 2, // Adjust the thickness of the line
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              Center(
                child: Wrap(
                  spacing: 40, // Adjust the spacing as needed
                  runSpacing: 16,
                  children: [
                    ItemCard(),
                    ItemCard(),
                    ItemCard(),
                    

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
