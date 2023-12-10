import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/back_header_widget.dart';
import '../../constants/customColors.dart';
import '../../controller/post_item/conditon_controller.dart';
import 'post_an_new_item.dart';

class ConditionPage extends StatefulWidget {
  ConditionPage({Key? key}) : super(key: key);

  @override
  _ConditionPageState createState() => _ConditionPageState();
}

class _ConditionPageState extends State<ConditionPage> {
  String selectedCondition = '';
  final ConditionController conditionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          BackHeaderWidget(title: 'Condition'),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          ConditionDescription(
            condition: "New with tags",
            description: "A brand-new, unused item with tags.",
            isSelected: selectedCondition == "New with tags",
            onChanged: () {
              updateSelectedCondition("New with tags");
              conditionController.updateCondition("New with tags");
              Get.offAll(PostAnItem());
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          ConditionDescription(
            condition: "New without tags",
            description: "A brand-new, unused item.",
            isSelected: selectedCondition == "New without tags",
            onChanged: () {
              updateSelectedCondition("New without tags");
              conditionController.updateCondition("New without tags");
              Get.offAll(PostAnItem());
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          ConditionDescription(
            condition: "Very good",
            description: "A lightly used item, may have slight imperfections.",
            isSelected: selectedCondition == "Very good",
            onChanged: () {
              updateSelectedCondition("Very good");
              conditionController.updateCondition("Very good");
              Get.offAll(PostAnItem());
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          ConditionDescription(
            condition: "Good",
            description:
                "A used item that may show imperfections and signs of wear.",
            isSelected: selectedCondition == "Good",
            onChanged: () {
              updateSelectedCondition("Good");
              conditionController.updateCondition("Good");
              Get.offAll(PostAnItem());
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
          ConditionDescription(
            condition: "Satisfactory",
            description:
                "A frequently used item with imperfections and signs of wear.",
            isSelected: selectedCondition == "Satisfactory",
            onChanged: () {
              updateSelectedCondition("Satisfactory");
              conditionController.updateCondition("Satisfactory");
              Get.offAll(PostAnItem());
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: CustomColors.backgroundForPostItem,
          ),
        ],
      ),
    );
  }

  void updateSelectedCondition(String condition) {
    setState(() {
      selectedCondition = condition;
    });
  }
}

class ConditionDescription extends StatelessWidget {
  final String condition;
  final String description;
  final bool isSelected;
  final VoidCallback onChanged;

  ConditionDescription({
    super.key,
    required this.condition,
    required this.description,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
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
                    condition,
                    style: TextStyle(fontSize: 16, color: Color(0xFF33302E)),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16, color: Color(0xFF33302E)),
                  ),
                ],
              ),
            ),
            Checkbox(
              checkColor: Colors.white,
              activeColor: CustomColors.buttonSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (Set<MaterialState> states) {
                  return BorderSide(
                    width: 1,
                    color: states.contains(MaterialState.selected)
                        ? CustomColors.buttonSecondary
                        : Colors.black,
                  );
                },
              ),
              value: isSelected,
              onChanged: (value) {
                onChanged();
              },
            ),
          ],
        ),
      ),
    );
  }
}
