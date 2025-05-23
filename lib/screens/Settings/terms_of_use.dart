import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';

import '../../components/floating_button.dart';
import '../../utilities/returnAction.dart';

class TermsOfUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child:
                FloatingButton(action: returnToPreviousPage, title: 'Terms Of Use'),
          ),
            // Big Text and Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ShedMedd',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10), // Adjust the spacing
                Image.asset(
                  'assets/images/logo_small_icon_only_inverted.png', // Replace with your logo asset
                  width: 50, // Set the desired width
                  height: 50, // Set the desired height
                ),
              ],
            ),
            SizedBox(height: 20), // Add spacing

            // Shaded Box with Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoText('ShedMedd is committed to fostering a safe and respectful environment for all users.'),
                    SizedBox(height: 15),
                    _buildInfoText('Our platform exclusively supports halal and legal items. Any engagement in unlawful activities may result in legal consequences'),
                    SizedBox(height: 15),
                    _buildInfoText('While interacting with other users, it is imperative to maintain a high level of respect. Any form of disrespect or engaging in immoral discussions may lead to law enforcement intervention.'),
                    SizedBox(height: 15),
                    _buildInfoText('All posted items should be in good condition to ensure a positive experience for buyers.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: CustomColors.textPrimary,
        fontSize: 18,
      ),
    );
  }
}
