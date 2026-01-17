import 'package:get/get.dart';
import 'package:group_app/config/screens/Login_disLoged_file_screen/Sign_up_Screen/sign_up_screen_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}