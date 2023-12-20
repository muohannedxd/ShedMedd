import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/screens/Shop/Home.dart';
import '../../../database/usersDB.dart';

import 'log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Color signUpButtonColor = Color(0xFF2D201C);
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String errorMessage = '';
  String nameError = '';
  String emailError = '';
  String passwordError = '';
  String confirmPasswordError = '';
  // Controllers for handling input values
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 32, top: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("your account",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 32, right: 32, top: 48, bottom: 28),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Your name",
                    errorText: nameError.isNotEmpty ? nameError : null,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email address",
                    errorText: emailError.isNotEmpty ? emailError : null,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    errorText: passwordError.isNotEmpty ? passwordError : null,
                    suffixIcon: IconButton(
                      iconSize: 16,
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: obscurePassword,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    errorText: confirmPasswordError.isNotEmpty
                        ? confirmPasswordError
                        : null,
                    suffixIcon: IconButton(
                      iconSize: 16,
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: obscureConfirmPassword,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color?>(Color(0xFF2D201C)),
                fixedSize: MaterialStateProperty.all<Size>(Size(147, 51)),
                shape: MaterialStateProperty.all<OutlinedBorder?>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        26.5), // Adjust the radius for sharpness
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  nameError =
                      nameController.text.isEmpty ? "Fill name field" : "";
                  emailError =
                      emailController.text.isEmpty ? "Fill email field" : "";
                  passwordError = passwordController.text.isEmpty
                      ? "Fill password field"
                      : "";
                  confirmPasswordError = confirmPasswordController.text.isEmpty
                      ? "Fill confirm password field"
                      : "";
                });

                if (nameError.isEmpty &&
                    emailError.isEmpty &&
                    passwordError.isEmpty &&
                    confirmPasswordError.isEmpty) {
                  UsersDatabase()
                      .signUpUser(
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  )
                      .then((result) {
                    if (result == 'Sign up successful!') {
                      // Navigate to the next screen or perform other actions for successful signup
                      _showRegistrationSlider();
                      // Clear all input fields
                      nameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();

                      print('User successfully registered');
                    } else {
                      // Display error messages below the corresponding TextFields
                      setState(() {
                        switch (result) {
                          case 'Passwords do not match':
                            confirmPasswordError = result;
                            passwordError = '';
                            emailError = '';
                            errorMessage = '';
                            break;
                          case 'The password provided is too weak':
                            passwordError = result;
                            confirmPasswordError = '';
                            emailError = '';
                            errorMessage = '';
                            break;
                          case 'An account already exists for that email':
                            emailError = result;
                            passwordError = '';
                            confirmPasswordError = '';
                            errorMessage = '';
                            break;

                          case 'Error during signup':
                            errorMessage = result;
                            emailError = '';
                            passwordError = '';
                            break;
                          // Add other cases as needed for specific error messages
                          default:
                            // Generic error message
                            // Handle other error messages here
                            passwordError = '';
                            confirmPasswordError = '';
                            emailError = '';
                            errorMessage = '';
                        }
                      });
                    }
                  });
                }
              },
              child: Text(
                "SIGN UP",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          errorMessage.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SizedBox.shrink(),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 28,
                ),
                Text("Or sign up with",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(
                  height: 28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(42),
                      child: Container(
                        width: 42, // Set the desired width
                        height: 42, // Set the desired height
                        child: Image.asset(
                          "assets/images/google_icon.png",
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(42),
                      child: Container(
                        width: 42, // Set the desired width
                        height: 42, // Set the desired height
                        child: Image.asset(
                          "assets/images/facebook_icon.png",
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Or already have an account?",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 7,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the login page when "Log In" text is tapped
                    Get.offAll(LogIn());
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
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
