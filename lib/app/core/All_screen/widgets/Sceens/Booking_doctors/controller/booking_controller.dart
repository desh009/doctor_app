// select_time_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectTimeController extends GetxController {
  // Observable variables
  var selectedDate = 'Today, 23 Feb'.obs;
  var selectedSlot = ''.obs;
  var availableSlots = <String>[].obs;
  var isLoading = false.obs;
  var isFavorite = false.obs; 
  
  // Doctor details from arguments
  final Map<String, dynamic> doctor = Get.arguments ?? {};

  @override
  void onInit() {
    super.onInit();
    fetchAvailableSlots(selectedDate.value);
  }
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    // You can also update this in your backend/local storage if needed

  }

  // Method to fetch available slots based on date
  void fetchAvailableSlots(String date) {
    isLoading.value = true;

    // Simulate API call
    Future.delayed(const Duration(milliseconds: 500), () {
      if (date.contains('Today')) {
        availableSlots.value = []; // No slots today
      } else if (date.contains('Tomorrow')) {
        availableSlots.value = [
          '09:00 AM',
          '10:00 AM',
          '11:00 AM',
          '02:00 PM',
          '03:00 PM',
          '04:00 PM',
        ];
      } else {
        availableSlots.value = [
          '09:30 AM',
          '10:30 AM',
          '11:30 AM',
          '02:30 PM',
          '03:30 PM',
          '04:30 PM',
          '05:30 PM',
        ];
      }
      isLoading.value = false;
    });
  }

  // Method to change selected date
  void changeDate(String date) {
    selectedDate.value = date;
    fetchAvailableSlots(date);
  }

  // Method to select time slot
  void selectSlot(String slot) {
    selectedSlot.value = slot;
  }

  // Method to book appointment
  void bookAppointment() {
    if (selectedSlot.value.isEmpty) {
      return;
    }

    // Process booking
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Booking'),
        content: Text(
          'Book appointment with ${doctor['name']} at ${selectedSlot.value} on ${selectedDate.value}?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Go back to previous screen
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  // Method to contact clinic
  void contactClinic() {
    // Implement contact functionality
    Get.defaultDialog(
      title: 'Contact Clinic',
      content: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Call'),
            onTap: () {
              Get.back();
              // Launch phone dialer
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Message'),
            onTap: () {
              Get.back();
              // Open messaging
            },
          ),
        ],
      ),
    );
  }
}
