import 'package:flutter/material.dart';
import 'package:shedmedd/components/BarWithReturn.dart';
import 'package:shedmedd/constants/customColors.dart';

import '../Shop/Home.dart';


class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarWithReturn(context, 'Profile Settings', returnPage: '/profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),

            // Figma-designed profile picture layout
            Stack(
              children: [
                // Profile picture container
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    "assets/images/logo_small_icon_only_inverted.png",
                    width: 96,
                    height: 96,
                  ),
                ),

                // Camera icon positioned at the bottom right
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4), // Adjust padding as needed
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Light grey background color
                        borderRadius: BorderRadius.circular(20), // Adjust the border radius as needed
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: const Color.fromARGB(255, 107, 105, 105),
                      ),
                    ),
                  ),

              ],
            ),

            // Rest of your code...
              SizedBox(height: 50),
            _buildNameRow('First Name', 'Last Name'),
             SizedBox(height: 15),
            _buildInfoModificationRow('Email', emailController),
            _buildInfoModificationRow('Gender', genderController),
            _buildInfoModificationRow('Phone', phoneController),
            _buildInfoModificationRow('Address', addressController),

            SizedBox(height: 25),

           Container(
  width: 203,
  height: 48,
  child: ElevatedButton(
    onPressed: () {
      _saveChanges(context);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xff343434),
      padding: EdgeInsets.symmetric(horizontal: 16), // Adjust padding as needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    child: Text(
      'Save Changes',
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ),
),

          ],
        ),
      ),
    );
  }

 Widget _buildNameRow(String label1, String label2) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  hintText: 'Enter your $label1',
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label2,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  hintText: 'Enter your $label2',
                  focusColor: CustomColors.buttonSecondary,
                ),
              ),
            ],
            
          ),
        ),
      ],
    ),
  );
}


 Widget _buildInfoModificationRow(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Container(
      width: double.infinity, // Set the width to occupy the available space
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 30),
          Expanded(
            child: Container(
              // Set the width for the TextField
              width: double.infinity,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter your $label',
                  focusColor: CustomColors.buttonSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


void _saveChanges(BuildContext context) {
    // Implement your save changes logic here

    // Navigate to the profile page after saving changes
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Shop(currentIndex: 4)),
    );
  }

}
