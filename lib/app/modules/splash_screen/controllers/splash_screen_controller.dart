import 'package:get/get.dart';
import 'package:landmark_assignment/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> redirectToHome() async {
    await Future.delayed(
      const Duration(milliseconds: 1200),
      () => Get.offAllNamed(Routes.HOME),
    );
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
