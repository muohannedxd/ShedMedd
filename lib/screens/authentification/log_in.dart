import 'package:flutter/material.dart';
import 'package:shedmedd/screens/authentification/sign_up.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Color LogInButtonColor = Color(0xFF2D201C);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 32, top: 93),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Log into",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                  decoration: InputDecoration(hintText: "Email address"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Password"),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 24, right: 32),
            alignment: Alignment.centerRight,
            child: Text("Forgot password?", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),),
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
                  "LOG IN",
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
                SizedBox(height: 28,),
                Text("Or log in with", style: TextStyle(fontSize: 12, color: Colors.grey )),
                SizedBox(height: 28,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                    borderRadius: BorderRadius.circular(42),
                    child: Container(
                      width: 42, // Set the desired width
                      height: 42, // Set the desired height
                      child: 
                      Image.asset(
                        "assets/images/google_icon.png" ,
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                    ClipRRect(
                    borderRadius: BorderRadius.circular(42),
                    child: Container(
                      width: 42, // Set the desired width
                      height: 42, // Set the desired height
                      child: 
                      Image.asset(
                        "assets/images/facebook_icon.png" ,
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 32,)

              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You don't have an account?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                SizedBox(width: 7,),
                GestureDetector(
                  onTap: () {
                    // Navigate to the login page when "Log In" text is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
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
    );
  }
}
