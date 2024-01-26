import 'package:flutter/material.dart';
import 'package:shedmedd/components/BarWithReturn.dart';
import 'package:shedmedd/components/button.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/database/usersDB.dart';
import 'package:shedmedd/screens/Shop/Home.dart';
import 'package:shedmedd/controller/auth/auth_controller.dart';


class RateAppPage extends StatefulWidget {
  const RateAppPage({Key? key}) : super(key: key);

  @override
  _RateAppPageState createState() => _RateAppPageState();
}

class _RateAppPageState extends State<RateAppPage> {
  double rating = 0.0;
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarWithReturn(context, 'Rate this app'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you satisfied with ShedMedd services?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        rating = index + 1.0;
                      });
                    },
                    icon: Icon(
                      index < rating.floor() ? Icons.star : Icons.star_border,
                      color: Colors.yellow[700],
                      size: 40,
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              Text(
                _getRatingText(),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              Button(
                action: _submitRating,
                title: 'Submit',
                background: CustomColors.buttonSecondary,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitRating() async {
    // Get the current user ID
    String? userId = await authController.getCurrentUserId();

    if (userId != null) {
      // Update the user's rating in the database
      await UsersDatabase().updateUserRating(userId, rating);
    }

    // Show the thank you dialog
    _showThankYouDialogWithDelay();
  }

  void _showThankYouDialogWithDelay() async {
    await Future.delayed(Duration(seconds: 0));
    _showThankYouDialog();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Shop(currentIndex: 4)),
    );
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thank You!'),
          content: Text('Thank you for helping us to be better!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String _getRatingText() {
    if (rating == 1) {
      return 'I did not like the service';
    } else if (rating == 2) {
      return 'You should work on it';
    } else if (rating == 3) {
      return 'I like it but a lot is missing';
    } else if (rating == 4) {
      return 'Nice work';
    } else if (rating == 5) {
      return 'Great!';
    } else {
      return '';
    }
  }
}
