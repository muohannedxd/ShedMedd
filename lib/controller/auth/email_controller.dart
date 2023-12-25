import 'package:get/get.dart';

class EmailController extends GetxController {
  var email = RxString('');

  void setEmail(String emailName) {
    email.value = emailName;
    update();
  }
}
