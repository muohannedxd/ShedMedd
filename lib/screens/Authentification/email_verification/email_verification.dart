import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/database/usersDB.dart';
import '../../../controller/auth/email_controller.dart';
import '../../Shop/Home.dart';
import '../log_in.dart';

class VerificationEmail extends StatefulWidget {
  const VerificationEmail({super.key});

  @override
  State<VerificationEmail> createState() => _VerificationEmailState();
}

class _VerificationEmailState extends State<VerificationEmail> {
  Color VerificationEmailButtonColor = Color(0xFF2D201C);
  final EmailController _emailController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 32, right: 32, top: 196),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verify your email address",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text.rich(
                  TextSpan(
                    text: "We emailed you a link to ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "ProductSans/FontsFree-Net-ProductSans-Light",
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: _emailController.email.value,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            ".\nKindly click on the link provided to sign in to your account.\nIn case you haven't received the email, please click on",
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      await UsersDatabase().sendEmailVerification();
                      // Check if the user has already verified their email
                      bool? isEmailVerified =
                          await _checkEmailVerificationStatus();
                      if (isEmailVerified == true) {
                        // If the email is already verified, show the slider
                        _showRegistrationSlider();
                      } else {
                        // If the email is not yet verified, you may show a message to the user
                        print(
                            'Please check your email to verify your account.');
                      }
                    } catch (e) {
                      // Handle the case where verification fails (e.g., show an error message)
                      print('Error sending verification email: $e');
                    }
                  },
                  child: Text(
                    "Resend",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Color(0xFFB9B9B9)),
                        fixedSize:
                            MaterialStateProperty.all<Size>(Size(147, 51)),
                        shape: MaterialStateProperty.all<OutlinedBorder?>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                26.5), // Adjust the radius for sharpness
                          ),
                        ),
                      ),
                      onPressed: () {
                        UsersDatabase().logoutUser();
                        Get.offAll(LogIn());
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _checkEmailVerificationStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      user = FirebaseAuth.instance.currentUser;
      return user?.emailVerified;
    }
    return false;
  }

  void _showRegistrationSlider() {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32,
                ),
                // Add your Image widget here
                Image.asset(
                  'assets/images/password_successfully_changed.png',
                  width: 110.0, // Adjust the width as needed
                  height: 110.0, // Adjust the height as needed
                  // You can use other properties like fit, alignment, etc.
                ),
                SizedBox(height: 20.0), // Adjust spacing as needed
                Text(
                  "You have been successfully registered in ShedMedd!",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0), // Adjust spacing as needed
                Text(
                  "Welcome! Discover now!",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.0), // Adjust spacing as needed
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(Colors.black),
                        fixedSize:
                            MaterialStateProperty.all<Size>(Size(315, 60)),
                        shape: MaterialStateProperty.all<OutlinedBorder?>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Adjust the radius for sharpness
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.offAll(Shop(currentIndex: 0));
                        //if the user clicked here make him registered,
                        //else if he clicked elsewhere and made the slider to disappear he has to log in to the account he created
                      },
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
}
