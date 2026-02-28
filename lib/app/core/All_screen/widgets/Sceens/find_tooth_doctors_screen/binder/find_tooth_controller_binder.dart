import 'package:get/get.dart';
import 'package:group_app/app/core/All_screen/widgets/Sceens/find_tooth_doctors_screen/controller/find_tooth_controller_view.dart';
// Controller import korun path onujayi

class FindDoctorBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindDoctorController>(() => FindDoctorController());
  }
}