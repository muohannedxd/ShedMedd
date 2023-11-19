import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/screens/Authentification/password_resetting/create_new_password.dart';
import 'package:shedmedd/screens/Authentification/sign_up.dart';
import 'package:flutterotpfield/flutterotpfield.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({super.key});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  Color VerificationCodeButtonColor = Color(0xFF2D201C);
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
                  "verification code",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "Please enter the verification code we sent to your email address",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "ProductSans/FontsFree-Net-ProductSans-Light", height: 1.5),
                    )
              ],
            ),
          ),
          SizedBox(height: 58,),
          Center(
            child: FlutterOtpField(
              inputFieldLength: 4,
              inputFieldHeight: 58,
              inputFieldWidth: 58,
              otpWidgetHeight: 58,
              spaceBetweenFields: 12,
              inputDecoration: InputDecoration(
                  constraints: const BoxConstraints(maxHeight: 58),
                  fillColor: Colors.transparent,
                  filled: true,
                  counterText: "",
                  hintStyle: const TextStyle(
                      color: Color(0xff656565),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xff969696), width: 1.0),
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xff969696), width: 1.0),
                      borderRadius: BorderRadius.circular(30))),
              onValueChange: (String value) {
                print("otp changed $value");
              },
              onCompleted: (String value) {
                print("otp  $value");
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewPassword()));
              },
          
            ),
            ),
            SizedBox(height:48),
            Container(
              margin: EdgeInsets.only(left: 32),
              child: Text("Resend in 00:10", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200, fontFamily: "ProductSans/FontsFree-Net-ProductSans-Light"),))
        ],
      ),
    );
  }
}
