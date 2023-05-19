import 'package:get/get.dart';

class IncStateCtrl extends GetxController {
  final inc = 0.obs;

  void increment() {
    inc.value++;
  }
}
