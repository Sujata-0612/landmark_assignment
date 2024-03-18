import 'package:get/get.dart';

class NewsDetailsController extends GetxController {

  int index = 0;
  @override
  void onInit() {
    index = Get.arguments[0];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
