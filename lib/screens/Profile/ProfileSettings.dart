import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shedmedd/components/BarWithReturn.dart';
import 'package:shedmedd/components/customCircularProg.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/controller/auth/auth_controller.dart';
import 'package:shedmedd/controller/Profile/profileController.dart';
import 'package:shedmedd/database/usersDB.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

import '../../components/floating_button.dart';
import '../../utilities/returnAction.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController nameController = TextEditingController();
  String selectedGender = '';
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isSavingChanges = false;
  String userProfilePic = "assets/images/logo_small_icon_only_inverted.png";
  String userName = ' ';
  String initials = '';
  Uint8List? _image;

  void _initializeUserData() async {
    final AuthController authController = AuthController();
    String? userId = await authController.getCurrentUserId();
    Map<String, dynamic> userData =
        await ProfileController().getOneUserProfile(userId!);

    setState(() {
      nameController.text = userData['name'] ?? '';
      selectedGender = userData['gender'] ?? ''; // Initialize gender
      phoneController.text = userData['phone'] ?? '';
      addressController.text = userData['address'] ?? '';
      _image = userData['profile_pic'] ?? " ";
      userName = userData['name'] ?? '';
      initials = userName.toUpperCase().substring(0, 2);
    });
  }

  Future<void> _saveChanges(BuildContext context) async {
    try {
      setState(() {
        isSavingChanges = true;
      });

      final AuthController authController = AuthController();
      String? userId = await authController.getCurrentUserId();

      String imageUrl = await _uploadImageToStorage(userId!, _image);

      Map<String, String> updatedUserData = {
        'name': nameController.text ?? userName,
        'gender': selectedGender,
        'phone': phoneController.text,
        'address': addressController.text,
        'profile_pic': imageUrl,
      };

      await UsersDatabase().updateUserData(userId, updatedUserData);

      // Clear text fields
      nameController.clear();
      phoneController.clear();
      addressController.clear();

      Navigator.pop(context, true); // Pass true to indicate changes were saved
    } catch (e) {
      print('Error saving changes: $e');
    } finally {
      setState(() {
        isSavingChanges = false;
      });
    }
  }

  Future<String> _uploadImageToStorage(String userId, Uint8List? image) async {
    if (image == null) {
      return userProfilePic; // No image to upload, return the existing URL
    }

    try {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/users/$userId/${path.basename(DateTime.now().toString())}.jpg');
      firebase_storage.UploadTask uploadTask = storageRef.putData(image);
      await uploadTask.whenComplete(() {});
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return userProfilePic; // Return the existing URL in case of an error
    }
  }

  Future<Uint8List?> _pickImageFromGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return await pickedFile.readAsBytes();
    }

    print('No image is selected');
    return null;
  }

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: FloatingButton(
                  action: returnToPreviousPage, title: 'Profile Settings'),
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    Uint8List? img = await _pickImageFromGallery(context);
                    if (img != null) {
                      setState(() {
                        userProfilePic = ''; // Assign a blank value to prevent the old image from being displayed
                        _image = img;
                      });
                    }
                  },
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: _image != null
                          ? Image.memory(
                              _image!,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            )
                          : CachedNetworkImage(
                              key: Key(DateTime.now().millisecondsSinceEpoch.toString()), // Unique key
                              imageUrl: userProfilePic,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                              progressIndicatorBuilder: (context, url, progress) =>
                                  Center(child: CustomCircularProgress()),
                              errorWidget: (context, url, error) =>
                                  Center(child: Text(initials)),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      Uint8List? img = await _pickImageFromGallery(context);
                      if (img != null) {
                        setState(() {
                          userProfilePic = ''; // Assign a blank value to prevent the old image from being displayed
                          _image = img;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
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
            _buildInfoModificationRow('Full Name', TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter your Full Name',
                focusColor: CustomColors.buttonSecondary,
              ),
            )),
            SizedBox(height: 20),
            _buildGenderSelection(), // Include gender selection
            _buildInfoModificationPhone('Phone', phoneController),
            _buildInfoModificationRow('Address', TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: 'Enter your Address',
                focusColor: CustomColors.buttonSecondary,
              ),
            )),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: isSavingChanges ? null : () => _saveChanges(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff343434),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: isSavingChanges
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return _buildInfoModificationRow(
      'Gender',
      Row(
        children: [
          SizedBox(width: 20),
          _buildGenderOption('Male', Icons.male),
          SizedBox(width: 30),
          _buildGenderOption('Female', Icons.female),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedGender == gender
                ? CustomColors.buttonSecondary
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: Colors.black), // Smaller size
            SizedBox(height: 5),
            Text(gender, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoModificationPhone(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        width: double.infinity,
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
                width: double.infinity,
                child: TextField(
                  controller: controller,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.phone,
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

  Widget _buildInfoModificationRow(String label, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        width: double.infinity,
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
                width: double.infinity,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
