import 'package:flutter/material.dart';

import '../../constants/customColors.dart';

class ConditionChooser extends StatelessWidget {
  const ConditionChooser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 24, top: 32),
            child: Row(
              children: [
                Material(
                  elevation: 4, // Set the elevation value as needed
                  shape: CircleBorder(),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 24,
                    ),
                    onPressed: () {
                      // Navigate back when the button is pressed
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                    width:
                        78), // Adjust the spacing between icon and text as needed
                Text(
                  'ConditionChooser', // Add the desired text here
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          ConditionChooserDescription(
              ConditionChooser: "New with tags",
              description: "A brand-new, unused item with tags.",
              checked: false),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          ConditionChooserDescription(
              ConditionChooser: "New without tags",
              description: "A brand-new, unused item.",
              checked: false),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          ConditionChooserDescription(
              ConditionChooser: "Very good",
              description:
                  "A lightly used item, may have slight imperfections.",
              checked: false),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          ConditionChooserDescription(
              ConditionChooser: "Good",
              description:
                  "A used items that may show imperfections and signs of wear.",
              checked: false),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          ConditionChooserDescription(
              ConditionChooser: "Satisfactory",
              description:
                  "A frequently used item with imperfections and signs of wear.",
              checked: false),
              Divider(
          height: 0,
          thickness: 1,
          color: CustomColors.backgroundForPostItem,
          ),
        ],
      ),
    );
  }
}

class ConditionChooserDescription extends StatefulWidget {
  final String ConditionChooser;
  final String description;
  bool checked;
  ConditionChooserDescription(
      {super.key,
      required this.ConditionChooser,
      required this.description,
      required this.checked});

  @override
  State<ConditionChooserDescription> createState() => _ConditionChooserDescriptionState();
}

class _ConditionChooserDescriptionState extends State<ConditionChooserDescription> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.checked = !widget.checked;
        });
      },
      child: Container(
        alignment: Alignment.centerLeft,
        color: Colors.white,
        margin: EdgeInsets.only(left: 23, right: 23, top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.ConditionChooser,
                    style: TextStyle(fontSize: 16, color: Color(0xFF33302E)),
                  ),
                  Text(widget.description, style: TextStyle(fontSize: 16, color: Color(0xFF33302E))),
                ],
              ),
            ),
            Checkbox(
              checkColor: Colors.white,
              activeColor: CustomColors.buttonSecondary,
              shape: CircleBorder(),
              value: widget.checked,
              onChanged: (value) {
                setState(() {
                  widget.checked = !widget.checked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
