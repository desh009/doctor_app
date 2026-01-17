import 'package:get/get.dart';
import 'package:group_app/config/screens/Login_disLoged_file_screen/Login_screen/controller/Login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    // LoginController lazy load করে রাখবে
    Get.lazyPut<LoginController>(
      () => LoginController(),
      fenix: true, // যদি পেজ destroy এবং পরে আবার create হয়, তাহলে পুনরায় instantiate করবে
    );
  }
}