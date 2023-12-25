import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/database/usersDB.dart';
import 'package:shedmedd/screens/Authentification/log_in.dart';
import '../../../components/floating_button.dart';
import '../../../controller/auth/email_controller.dart';
import '../../../utilities/returnAction.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Color ForgotPasswordButtonColor = Color(0xFF2D201C);
  TextEditingController emailController = TextEditingController();
  final EmailController _emailController = Get.put(EmailController());

  String invalidEmailError = '';
  String userNotFountError = '';
  String errorSendingResetEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FloatingButton(
            action: returnToPreviousPage,
          ),
          Container(
            margin: EdgeInsets.only(left: 32, right: 32, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forgot password?",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter email associated with your account and we’ll send and email with instructions to reset your password",
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
            margin: EdgeInsets.only(left: 32, right: 32, top: 64, bottom: 28),
            child: Column(
              children: [
                TextField(
                  controller: emailController, // Pass the controller here
                  onChanged: (email) {
                    _emailController.setEmail(email);
                  },
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CustomColors.buttonSecondary, width: 2.0),
                    ),
                    hintText: "enter your email here",
                    errorText: errorSendingResetEmail.isNotEmpty
                        ? errorSendingResetEmail
                        : null,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: Icon(
                        Icons.email_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                  onSubmitted: (String value) {
                    UsersDatabase().resetPassword(value).then((result) {
                      if (result == null) {
                        _showLoginSlider();
                        emailController.clear();
                        print('Reset password email successfully sent');
                      } else {
                        setState(() {
                          errorSendingResetEmail = result;
                        });
                      }
                    }); // Use the value parameter
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLoginSlider() {
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
                  "Password reset link sent to your email!",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0), // Adjust spacing as needed
                Text(
                  "Welcome again!",
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
                        Get.offAll(LogIn());
                        //if the user clicked here make him registered,
                        //else if he clicked elsewhere and made the slider to disappear he has to log in to the account he created
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
        );
      },
    );
  }
}
