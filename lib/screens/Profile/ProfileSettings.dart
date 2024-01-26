import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shedmedd/components/BarWithReturn.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/controller/auth/auth_controller.dart';
import 'package:shedmedd/controller/Profile/profileController.dart';
import 'package:shedmedd/database/usersDB.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isSavingChanges = false;
  String userProfilePic = "assets/images/logo_small_icon_only_inverted.png";

  void _initializeUserData() async {
    final AuthController authController = AuthController();
    String? userId = await authController.getCurrentUserId();
    Map<String, dynamic> userData =
        await ProfileController().getOneUserProfile(userId!);

    setState(() {
      nameController.text = userData['name'] ?? '';
      genderController.text = userData['gender'] ?? '';
      phoneController.text = userData['phone'] ?? '';
      addressController.text = userData['address'] ?? '';
      userProfilePic = userData['profile_pic'] ??
          "assets/images/logo_small_icon_only_inverted.png";
    });
  }

  Future<void> _saveChanges(BuildContext context) async {
    try {
      setState(() {
        isSavingChanges = true;
      });

      final AuthController authController = AuthController();
      String? userId = await authController.getCurrentUserId();

      Map<String, String> updatedUserData = {
        'name': nameController.text,
        'gender': genderController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'profile_pic': userProfilePic,
      };

      await UsersDatabase().updateUserData(userId, updatedUserData);

      Navigator.pop(context, true); // Pass true to indicate changes were saved
    } catch (e) {
      print('Error saving changes: $e');
    } finally {
      setState(() {
        isSavingChanges = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        userProfilePic = pickedFile.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

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
            Stack(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      userProfilePic,
                      width: 96,
                      height: 96,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
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
            _buildInfoModificationRow('Full Name', nameController),
            _buildInfoModificationRow('Gender', genderController),
            _buildInfoModificationPhone('Phone', phoneController),
            _buildInfoModificationRow('Address', addressController),
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

  Widget _buildInfoModificationPhone(String label, TextEditingController controller) {
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

Widget _buildInfoModificationRow(
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

}
