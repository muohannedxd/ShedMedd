import 'package:flutter/material.dart';
import 'package:shedmedd/constants/customColors.dart';

class CategoryChooser extends StatefulWidget {
  const CategoryChooser({
    super.key,
  });

  @override
  State<CategoryChooser> createState() => _CategoryChooserState();
}

class _CategoryChooserState extends State<CategoryChooser> {
  List<bool> chosen = [true, false, false];

  void setChosen(index) {
    for (int i = 0; i < chosen.length; i++) {
      chosen[i] = false;
    }
    setState(() {
      chosen[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    setChosen(0);
                  },
                  child: CircleAvatar(
                    backgroundColor: chosen[0] == true
                        ? CustomColors.textSecondary
                        : CustomColors.grey.withOpacity(0.3),
                    child: Icon(Icons.female_outlined,
                        size: 36,
                        color: chosen[0] == true
                            ? CustomColors.white
                            : CustomColors.textPrimary.withOpacity(0.3)),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Women',
              style: TextStyle(
                  color: chosen[0] == true
                      ? CustomColors.textPrimary
                      : CustomColors.textPrimary.withOpacity(0.3)),
            )
          ],
        ),
        SizedBox(
          width: 40,
        ),
        Column(
          children: [
            Container(
              width: 50,
              height: 50,
              child: GestureDetector(
                onTap: () {
                  setChosen(1);
                },
                child: CircleAvatar(
                  backgroundColor: chosen[1] == true
                      ? CustomColors.textSecondary
                      : CustomColors.grey.withOpacity(0.3),
                  child: Icon(Icons.male_outlined,
                      size: 36,
                      color: chosen[1] == true
                          ? CustomColors.white
                          : CustomColors.textPrimary.withOpacity(0.3)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Men',
              style: TextStyle(
                  color: chosen[1] == true
                      ? CustomColors.textPrimary
                      : CustomColors.textPrimary.withOpacity(0.3)),
            )
          ],
        ),
        SizedBox(
          width: 40,
        ),
        Column(
          children: [
            Container(
              width: 50,
              height: 50,
              child: GestureDetector(
                onTap: () {
                  setChosen(2);
                },
                child: CircleAvatar(
                  backgroundColor: chosen[2] == true
                      ? CustomColors.textSecondary
                      : CustomColors.grey.withOpacity(0.3),
                  child: Icon(Icons.child_care_outlined,
                      size: 36,
                      color: chosen[2] == true
                          ? CustomColors.white
                          : CustomColors.textPrimary.withOpacity(0.3)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Children',
              style: TextStyle(
                  color: chosen[2] == true
                      ? CustomColors.textPrimary
                      : CustomColors.textPrimary.withOpacity(0.3)),
            )
          ],
        ),
      ],
    );
  }
}
