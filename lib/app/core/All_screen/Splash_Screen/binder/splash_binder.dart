// lib/app/core/All_screen/Splash_Screen/binder/splash_binder.dart
import 'package:get/get.dart';
import '../controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    print('🔗 SplashBinding: dependencies called');
    Get.lazyPut<SplashController>(
      () => SplashController(),
      fenix: true, // Optional: if you need to use it again
    );
  }
}