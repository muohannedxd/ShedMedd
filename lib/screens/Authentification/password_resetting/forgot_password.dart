import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shedmedd/screens/Authentification/password_resetting/verification_code.dart';

import '../../../components/floating_button.dart';
import '../../../config/returnAction.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Color ForgotPasswordButtonColor = Color(0xFF2D201C);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FloatingButton(action: returnToPreviousPage,),
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "ProductSans/FontsFree-Net-ProductSans-Light", height: 1.5),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 32, right: 32, top: 64, bottom: 28),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    hintText: "enter your email here",
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          right: 8.0), // Adjust the padding as needed
                      child: Icon(
                        Icons.email_outlined,
                        size: 20,
                      ), // Replace with your desired icon
                    ),
                  ),
                  onSubmitted: (String value) {
                    Get.to( VerificationCode());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
