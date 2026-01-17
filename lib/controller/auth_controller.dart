import 'dart:ui';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Basic auth state (তার মতো)
  var isLoggedIn = false.obs;
  VoidCallback? pendingAction;
  
  // Doctor-specific additions (শুধু doctor app এর জন্য)
  var doctorName = ''.obs;
  var specialization = ''.obs;
  var isAvailable = true.obs; // Consultation available
  var consultationFee = 500.obs;
  
  // ==================== BASIC AUTH ====================
  
  void login(String name, String special) {
    isLoggedIn.value = true;
    doctorName.value = name;
    specialization.value = special;
    
    pendingAction?.call(); // pending কাজ execute হবে
    pendingAction = null;
  }
  
  void logout() {
    isLoggedIn.value = false;
    doctorName.value = '';
    specialization.value = '';
    isAvailable.value = false;
    consultationFee.value = 0;
  }
  
  // ==================== DOCTOR-SPECIFIC ====================
  
  void updateAvailability(bool available) {
    isAvailable.value = available;
  }
  
  void setConsultationFee(int fee) {
    consultationFee.value = fee;
  }
  
  void updateSpecialization(String newSpecialization) {
    specialization.value = newSpecialization;
  }
}