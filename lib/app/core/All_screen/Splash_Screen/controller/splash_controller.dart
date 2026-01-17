import 'dart:async';
import 'package:get/get.dart';
import 'package:group_app/app/core/routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Timer(const Duration(seconds: 3), () {
      // Simple and clean
      Get.offAllNamed(Routes.INTRO);
    });
  }
}