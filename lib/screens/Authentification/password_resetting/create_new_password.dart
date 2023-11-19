import 'package:flutter/material.dart';
import 'package:shedmedd/screens/Authentification/password_resetting/forgot_password.dart';
import 'package:shedmedd/screens/Authentification/sign_up.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

void _showConfirmationSlider() {
  // Show the bottom sheet when the button is pressed
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (builder) {
      return Container(
        height: 360.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(70.0),
              topRight: const Radius.circular(70.0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 32,),
              // Add your Image widget here
              Image.asset(
                'assets/images/password_successfully_changed.png',
                width: 110.0, // Adjust the width as needed
                height: 110.0, // Adjust the height as needed
                // You can use other properties like fit, alignment, etc.
              ),
              SizedBox(height: 20.0), // Adjust spacing as needed
              Text("Your password has been changed",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,),),
              SizedBox(height: 16.0), // Adjust spacing as needed
              Text("Welcome back! Discover now!",style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,),),
              SizedBox(height: 24.0), // Adjust spacing as needed
              Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.black),
                  fixedSize: MaterialStateProperty.all<Size>(Size(315, 60)),
                  shape: MaterialStateProperty.all<OutlinedBorder?>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30), // Adjust the radius for sharpness
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Browse home",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
          ),
            ],
          ),
        ),
      );
    },
  );
}


  Color CreateNewPasswordButtonColor = Color(0xFF2D201C);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 24, top: 32),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 24,
              ),
              onPressed: () {
                // Navigate back when the button is pressed
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 32, right: 32, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create new password",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Your new password must be different from previously used password",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "ProductSans/FontsFree-Net-ProductSans-Light",
                      height: 1.5),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 32, right: 32, top: 48, bottom: 28),
            child: Column(
              children: [
                TextField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    hintText: "New password",
                    suffix: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    hintText: "Confirm password",
                    suffix: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 92,
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Color(0xFFB9B9B9)),
                  fixedSize: MaterialStateProperty.all<Size>(Size(147, 51)),
                  shape: MaterialStateProperty.all<OutlinedBorder?>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          26.5), // Adjust the radius for sharpness
                    ),
                  ),
                ),
                onPressed: () {
                  _showConfirmationSlider();
                },
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
