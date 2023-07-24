import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play/home_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 5000));
    // Get.to(PageTransition(
    //     child: HomeScreen(),
    //     type: PageTransitionType.fade,
    //     alignment: Alignment.bottomCenter));
    Get.to(HomeScreen());
  }
}
