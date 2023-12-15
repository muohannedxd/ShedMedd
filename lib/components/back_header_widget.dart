import 'package:flutter/material.dart';

class BackHeaderWidget extends StatelessWidget {
  final String title;

  BackHeaderWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 24, top: 32),
      child: Row(
        children: [
          Material(
            elevation: 1,
            shape: CircleBorder(),
            color: Colors.white,
            child: Container(
              width: 36,
              height: 36,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 15,
                ),
                onPressed: () {
                  // Navigate back when the button is pressed
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          SizedBox(
            width: 100,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
