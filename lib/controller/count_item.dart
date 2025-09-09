import 'package:get/get.dart';

class CountItemController extends GetxController {
  // Reactive quantity
  var quantity = 1.obs;

  // Increase quantity
  void increase() => quantity.value++;

  // Decrease quantity (minimum 1)
  void decrease() {
    if (quantity.value > 1) quantity.value--;
  }
}
