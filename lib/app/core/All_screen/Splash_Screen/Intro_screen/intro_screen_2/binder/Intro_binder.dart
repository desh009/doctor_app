import 'package:get/get.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/Intro_screen/intro_screen_2/controller/intro_controller.dart';

class IntroBinder extends Bindings {
  @override
  void dependencies() {
    // Controller inject করা হচ্ছে
    Get.lazyPut<IntroController>(() => IntroController());
  }
}
