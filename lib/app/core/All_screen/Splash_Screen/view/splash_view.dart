// splash_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/reusable_content/sheed/sheed.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key}) {
    print('🔄 SplashScreen Constructor called');
    // Controller initialize
    Get.put(SplashController());
  }

  @override
  Widget build(BuildContext context) {
    print('🎨 SplashScreen build() called');
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomShadeBackground(
        child: Center(
          child: Container(
            height: 520,
            width: 520,
            child: Center(
              child: Image.asset(
                "assets/images/Logo.png",
                width: 210,
                height: 210,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}