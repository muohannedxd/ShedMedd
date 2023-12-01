
import 'package:flutter/material.dart';
import 'package:shedmedd/components/BarWithReturn.dart';
import 'package:shedmedd/screens/Profile/Profile.dart';

class RateAppPage extends StatefulWidget {
  const RateAppPage({Key? key}) : super(key: key);

  @override
  _RateAppPageState createState() => _RateAppPageState();
}

class _RateAppPageState extends State<RateAppPage> {
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarWithReturn(context, 'Rate this app'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display a big text asking user satisfaction
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
            // Display stars for rating
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
                    index < rating.floor()
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.yellow,
                    size: 40, // Set custom size for stars
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            // Display rating text based on the selected rating
            Text(
              _getRatingText(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            // Add a button to submit the rating or perform further actions
            ElevatedButton(
              onPressed: () {
                _submitRating();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[200], // Set button background color
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Submit!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitRating() {
    _showThankYouDialogWithDelay();
  }

  void _showThankYouDialogWithDelay() async {
    await Future.delayed(Duration(seconds: 0)); // Delay for 2 seconds

    // Show the thank you dialog
    _showThankYouDialog();

    // Navigate to the profile page after showing the dialog
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Profile()),
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
                Navigator.of(context).pop(); // Close the thank you dialog
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
      return ''; // Handle other cases if needed
    }
  }
}
