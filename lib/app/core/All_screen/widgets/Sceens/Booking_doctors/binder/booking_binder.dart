// select_time_binding.dart
import 'package:get/get.dart';
import 'package:group_app/app/core/All_screen/widgets/Sceens/Booking_doctors/controller/booking_controller.dart';

class SelectTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectTimeController>(() => SelectTimeController());
  }
}