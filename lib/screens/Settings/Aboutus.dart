import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';

import '../../components/floating_button.dart';
import '../../utilities/returnAction.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child:
                FloatingButton(action: returnToPreviousPage, title: 'About Us'),
          ),
            // ShedMedd Logo and Text
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
            SizedBox(height: 20),
            // Platform Information Box
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
                    _buildInfoText('ShedMedd is a platform designed by 3rd-year ENSIA students for a mobile development project.'),
                    SizedBox(height: 15),
                    _buildInfoText('Contributors: Imene Ait Abdellah, Lina Boualem, and Mohanned Kadache.'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Contact Information Box
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
                    _buildInfoText('For any questions, please contact us via:'),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.email, color: CustomColors.textPrimary),
                        SizedBox(width: 5),
                        _buildInfoText('contact@shedmedd.com'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.language, color: CustomColors.textPrimary),
                        SizedBox(width: 5),
                        _buildInfoText('ensia: www.ensia.dz'),
                      ],
                    ),
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
