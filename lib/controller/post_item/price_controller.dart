import 'package:get/get.dart';

class PriceController extends GetxController {
  var price = RxString('');

  void updatePrice(String newPrice) {
    price.value = newPrice;
  }
}
