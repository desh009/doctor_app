import 'package:get/get.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/Intro_screen/intro_screen_3./controller/intro_screen_4_controller.dart';

class IntroScreen3Binder extends Bindings {
  @override
  void dependencies() {
    // Controller inject করা হচ্ছে
    Get.lazyPut<IntroScreen3Controller>(() => IntroScreen3Controller());
  }
}
