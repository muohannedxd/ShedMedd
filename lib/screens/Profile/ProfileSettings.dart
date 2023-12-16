import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shedmedd/components/BarWithReturn.dart';
import 'ImageUtility.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  String? imagePath;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarWithReturn(context, 'Edit Your Account'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: _buildProfileImage(),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(

                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _showImagePicker(context);
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        size: 30,
                        
                        color: const Color.fromARGB(255, 107, 105, 105),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            _buildNameRow('First Name', 'Last Name'),
            SizedBox(height: 15),
            _buildInfoModificationRow('Email   ', emailController),
            _buildInfoModificationRow('Gender', genderController),
            _buildInfoModificationRow('Phone  ', phoneController),
            _buildInfoModificationRow('Address', addressController),
            SizedBox(height: 50),
            Container(
              width: 203,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  _saveChanges(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff343434),
                  padding: EdgeInsets.symmetric(horizontal: 20),
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

  Widget _buildProfileImage() {
    return imagePath != null
        ? Image.file(File(imagePath!))
        : Image.asset("assets/images/logo_small_icon_only_inverted.png");
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
                    focusColor: Colors.blue, // Change this to your preferred color
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
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
            SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter your $label',
                  focusColor: Colors.blue, // Change this to your preferred color
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
    Navigator.pushReplacementNamed(context, '/profile');
  }

  Future<void> _showImagePicker(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose an option"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'camera');
              },
              child: Text("Prendre une photo"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'gallery');
              },
              child: Text("Choisir de la galerie"),
            ),
          ],
        );
      },
    );

    if (result != null) {
      String? selectedImagePath;
      if (result == 'camera') {
        selectedImagePath = await ImageUtility.pickImageFromCamera();
      } else if (result == 'gallery') {
        selectedImagePath = await ImageUtility.pickImageFromGallery();
      }

      if (selectedImagePath != null) {
        setState(() {
          imagePath = selectedImagePath;
        });
      }
    }
  }
}
