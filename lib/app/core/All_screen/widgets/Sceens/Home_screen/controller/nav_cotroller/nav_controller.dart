import 'package:get/get.dart';

class NavController extends GetxController {
  var selectedIndex = 0.obs; // Reactive index

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}