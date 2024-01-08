import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shedmedd/controller/auth/email_controller.dart';
import 'package:shedmedd/screens/Authentification/password_resetting/forgot_password.dart';
import 'package:shedmedd/screens/Authentification/sign_up.dart';
import 'package:shedmedd/utilities/successfulSnackBar.dart';
import '../../constants/customColors.dart';
import '../../database/usersDB.dart';
import '../Shop/Home.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Color LogInButtonColor = Color(0xFF2D201C);
  bool obscurePassword = true;
  String errorMessage = '';
  String emailError = '';
  String passwordError = '';
  // Controllers for handling input values
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final EmailController _emailController = Get.put(EmailController());

  @override
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Shop(currentIndex: 0)),
          (route) => false,
        );
      },
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 32, top: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Log into",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("your account",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 32, right: 32, top: 48, bottom: 28),
              child: Column(
                children: [
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
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: CustomColors.buttonSecondary, width: 2.0),
                      ),
                      hintText: "Password",
                      errorText:
                          passwordError.isNotEmpty ? passwordError : null,
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 32, right: 32),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Navigate to the login page when "Log In" text is tapped
                  Get.to(ForgotPassword());
                },
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                    decoration: TextDecoration.underline,
                  ),
                ),
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
                onPressed: () async {
                  setState(() {
                    emailError =
                        emailController.text.isEmpty ? "Fill email field" : "";
                    passwordError = passwordController.text.isEmpty
                        ? "Fill password field"
                        : "";
                  });

                  if (emailError.isEmpty && passwordError.isEmpty) {
                    UsersDatabase()
                        .loginUser(
                      emailController: emailController,
                      passwordController: passwordController,
                    )
                        .then((result) {
                      if (result == 'Login successful!') {
                        // Navigate to the next screen or perform other actions for successful signup
                        // Clear all input fields
                        emailController.clear();
                        passwordController.clear();
                        Get.offAll(Shop(currentIndex: 0));
                        print('User successfully logged in');
                      } else {
                        setState(() {
                          switch (result) {
                            case 'Wrong email or password provided':
                              passwordError = result;
                              emailError = result;
                              errorMessage = '';
                              break;
                            case 'Error during login':
                              emailError = '';
                              passwordError = '';
                              errorMessage = result;
                              break;
                            default:
                              passwordError = '';
                              emailError = '';
                              errorMessage = '';
                          }
                        });
                      }
                    });
                  }
                },
                child: Text(
                  "LOG IN",
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
                  Text("Or log in with",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String? result =
                              await UsersDatabase().logInWithGoogle();

                          if (result == "Successfull log in with Google") {
                            // Handle successful login
                            print(result);
                            Get.offAll(Shop(currentIndex: 0));
                          } else {
                            // Handle login failure
                            print(result);
                            // Show a SnackBar with the error message
                            showSnackBar(
                                context,
                                'Failed to log in with Google. Please try again!',
                                CustomColors.redAlert);
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
                    "You don't have an account?",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the login page when "Log In" text is tapped
                      Get.offAll(SignUp());
                    },
                    child: Text(
                      "Sign Up",
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
      ),
    );
  }
}
