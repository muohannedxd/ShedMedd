import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shedmedd/controller/auth/email_controller.dart';
import 'package:shedmedd/screens/Authentification/email_verification/email_verification.dart';
import 'package:shedmedd/screens/Shop/Home.dart';
import '../../../database/usersDB.dart';

import '../../constants/customColors.dart';
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

  final EmailController _emailController = Get.put(EmailController());
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
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: CustomColors.buttonSecondary, width: 2.0),
                    ),
                    hintText: "Your name",
                    errorText: nameError.isNotEmpty ? nameError : null,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController = TextEditingController(
                    text: _emailController.email.value,
                  ),
                  onChanged: (email) {
                    _emailController.setEmail(email);
                  },
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: CustomColors.buttonSecondary, width: 2.0),
                    ),
                    hintText: "Email address",
                    errorText: emailError.isNotEmpty ? emailError : null,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: CustomColors.buttonSecondary, width: 2.0),
                    ),
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
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: CustomColors.buttonSecondary, width: 2.0),
                    ),
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
                      .signUpAndSendVerificationEmail(
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  )
                      .then((result) {
                    if (result == 'Sign up successful!') {
                      // Clear all input fields
                      nameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();

                      Get.to(VerificationEmail());

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
                    GestureDetector(
                      onTap: () async {
                        try {
                          // Call the signUpWithGoogle function
                          String? result =
                              await UsersDatabase().signUpWithGoogle();

                          // Check the result and show appropriate messages or perform other actions
                          if (result == "Successful signing up with Google") {
                            // Successful sign-up
                            print("User signed up with Google successfully");
                            Get.offAll(Shop(currentIndex: 0));
                            // You can navigate to another screen, show a success message, etc.
                          } else {
                            // Error during sign-up
                            print("Error signing up with Google");
                            // Show a SnackBar with the error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Failed to sign up with Google. Please try again."),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        } catch (error) {
                          // Handle unexpected errors
                          print("Unexpected error: $error");
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(42),
                        child: Container(
                          width: 42,
                          height: 42,
                          child: SvgPicture.asset(
                            "assets/icons/google_icon.svg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Call your function for Facebook icon click
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(42),
                        child: Container(
                          width: 42,
                          height: 42,
                          child: SvgPicture.asset(
                            "assets/icons/facebook_icon.svg",
                            fit: BoxFit.cover,
                          ),
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
}
