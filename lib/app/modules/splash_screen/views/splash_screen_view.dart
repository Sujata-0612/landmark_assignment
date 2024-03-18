import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:landmark_assignment/app/consts/asset_consts.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    controller.redirectToHome();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          AssetConsts.newsAnimation,
          height: 500,
          width: 500,
          repeat: true,
          reverse: false,
        ),
      ),
    );
  }
}
