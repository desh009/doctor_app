import 'package:get/get.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/Intro_screen/intro_screen_1/controller/Introscreen.controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    // Controller inject করা হচ্ছে
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
