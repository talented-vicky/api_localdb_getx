import 'package:get/get.dart';

class ViewStateCtrl extends GetxController {
  RxBool visb = false.obs;

  void changeVisb() {
    visb.value = true;
  }
}
