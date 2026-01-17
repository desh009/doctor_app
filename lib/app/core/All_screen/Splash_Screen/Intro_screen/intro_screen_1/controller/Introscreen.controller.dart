import 'package:get/get.dart';

class OnboardingController extends GetxController {
  // Example: page index for onboarding
  var currentPage = 0.obs;

  // Change page
  void setPage(int index) {
    currentPage.value = index;
  }

  // Button action
  void getStarted() {
    // ekhane navigation logic add korte paren
    print("Get Started Pressed");
    // Example: Get.to(() => HomeScreen());
  }

  void skip() {
    print("Skip Pressed");
    // Example: Get.to(() => HomeScreen());
  }
}
