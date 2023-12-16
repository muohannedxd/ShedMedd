import 'package:get/get.dart';

class DescriptionController extends GetxController {
  var description = RxString('');

  void updateDescription(String newDescription) {
    description.value = newDescription;
  }
}
