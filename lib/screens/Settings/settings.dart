import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/screens/Settings/Aboutus.dart';
import 'package:shedmedd/screens/Settings/terms_of_use.dart';
import 'package:shedmedd/components/BarWithReturn.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int selectedBoxIndex = -1; // Index of the selected box, -1 means none selected
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarWithReturn(context, 'Settings'),
      
      backgroundColor: CustomColors.bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          SizedBox(height: 20),
          _buildSettingsItem(Icons.language, 'Language', 0),
          _buildSettingsItem(Icons.description, 'Terms of Use', 1),
          _buildSettingsItem(Icons.privacy_tip, 'About us', 2),
          _buildSettingsItem(Icons.report, 'Delete My Account', 3),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String text, int index) {
    return GestureDetector(
      onTap: () {
        // Handle box click
        if (text == 'Terms of Use') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TermsOfUse()),
          );
        } else if (text == 'About us') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutUs()),
          );
        } else if (text == 'Delete My Account') {
          // Navigate to the screen where you confirm the account deletion
          _showDeleteAccountConfirmationDialog();
        } else if (text == 'Language') {
              _showLanguageSelectionDialog();
            } else {
          setState(() {
            selectedBoxIndex = index;
            _startTimer();
          });
        }
        // Additional handling, if needed
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selectedBoxIndex == index
              ? Color.fromARGB(255, 137, 137, 137) // Dark grey when selected
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(255, 213, 210, 210), // Grey border color
            width: 1.0, // Border width
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: CustomColors.textPrimary),
                SizedBox(width: 15),
                Text(
                  text,
                  style: TextStyle(
                    color: CustomColors.textPrimary,
                    fontSize: TextSizes.subtitle,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: CustomColors.textGrey),
          ],
        ),
      ),
    );
  }

void _showLanguageSelectionDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String selectedLanguage = 'English'; // Set the default language

      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9, // Set the desired width
          child: SimpleDialog(
            title: Text('Select Language'),
            children: [
              _buildLanguageTile('English', selectedLanguage == 'English'),
              _buildLanguageTile('French', selectedLanguage == 'French'),
              // Add more languages as needed
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildLanguageTile(String language, bool isSelected) {
  return ListTile(
    title: Text(
      language,
      style: TextStyle(
        color: isSelected ? Color.fromARGB(255, 116, 24, 12) : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    ),
    onTap: () {
      setState(() {
        
      });
      Navigator.of(context).pop();
    },
  );
}

  void _startTimer() {
    _timer = Timer(Duration(milliseconds: 200), () {
      setState(() {
        selectedBoxIndex = -1; // Reset to none selected
      });
    });
  }

  void _showDeleteAccountConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Delete Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete your account?',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Perform delete account logic here
                // ...

                // After deleting
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red, // Set color to red for emphasis
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Dispose of the timer when the widget is disposed
    super.dispose();
  }
}
