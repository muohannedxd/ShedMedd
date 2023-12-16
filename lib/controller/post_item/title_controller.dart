import 'package:get/get.dart';

class TitleController extends GetxController {
  var title = RxString('');

  void updateTitle(String newTitle) {
    title.value = newTitle;
  }
}
