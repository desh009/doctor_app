import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // বটম নেভিগেশনের জন্য সিলেক্টেড ইনডেক্স
  var selectedIndex = 0.obs;
  
  // বটম নেভিগেশন আইটেম পরিবর্তন
  void changePage(int index) {
    selectedIndex.value = index;
  }

  // সার্চ টেক্সট কন্ট্রোলার
  final searchController = TextEditingController();
  
  // সার্চ ফাংশন
  void onSearch(String value) {
    // সার্চ লজিক এখানে
    print('Searching: $value');
  }

  // সার্চ ক্লিয়ার
  void clearSearch() {
    searchController.clear();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}