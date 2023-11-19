import 'package:flutter/material.dart';

import 'log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Color signUpButtonColor = Color(0xFF2D201C);
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
                SizedBox(height: 16,),
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
                  decoration: InputDecoration(hintText: "Your name"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Email address"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Password"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Confirm password"),
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
                onPressed: () {},
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
          ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
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
