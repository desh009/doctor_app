import 'package:get/get.dart';
import 'package:group_app/app/core/All_screen/widgets/Sceens/Home_screen/controller/home_screen_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}