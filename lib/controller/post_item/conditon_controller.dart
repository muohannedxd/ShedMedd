import 'package:get/get.dart';

class ConditionController extends GetxController {
  String condition = "";

  void updateCondition(String conditionName) {
    condition = conditionName;
    update();
  }

 void resetCondition() {
    condition = "";
    update();
  }
}
