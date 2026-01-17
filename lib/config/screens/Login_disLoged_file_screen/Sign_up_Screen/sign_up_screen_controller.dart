import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/helper/share_helper.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;
  
  final isAgreed = false.obs;
  final isLoading = false.obs;
  final isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    _setupControllerListeners();
  }

  void _setupControllerListeners() {
    nameController.value.addListener(_validateForm);
    emailController.value.addListener(_validateForm);
    passwordController.value.addListener(_validateForm);
    confirmPasswordController.value.addListener(_validateForm);
  }

  void _validateForm() {
    final name = nameController.value.text.trim();
    final email = emailController.value.text.trim();
    final password = passwordController.value.text.trim();
    final confirmPassword = confirmPasswordController.value.text.trim();

    // Helper ক্লাস ব্যবহার করলে কোড আরও ক্লিন হয়
    bool isEmailValid = GetUtils.isEmail(email); 
    bool isPasswordValid = password.length >= 6;
    bool isNameValid = name.isNotEmpty;
    bool isConfirmMatch = password == confirmPassword && password.isNotEmpty;

    isFormValid.value = isNameValid && isEmailValid && isPasswordValid && isConfirmMatch && isAgreed.value;
  }

  // --- ভ্যালিডেটরস ---
  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your name';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(value)) return 'Enter a valid email address';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.value.text) return 'Passwords do not match';
    return null;
  }

  void toggleAgreement() {
    isAgreed.value = !isAgreed.value;
    _validateForm();
  }

  // --- সাইন আপ লজিক ---
  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;
    
    if (!isAgreed.value) {
      Get.snackbar('Terms', 'Please agree to the terms', 
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      // ১. এখানে এপিআই কল হবে (সিমুলেশন)
      await Future.delayed(const Duration(seconds: 2));

      // ২. সাইন-আপ সফল হলে ডাটা ShareHelper এ সেভ করা
      Map<String, dynamic> userMap = {
        'id': 'user_123', // এপিআই থেকে প্রাপ্ত আইডি
        'name': nameController.value.text.trim(),
        'email': emailController.value.text.trim(),
      };
      
      ShareHelper.userData = userMap;
      ShareHelper.authToken = "dummy_token_from_server"; // টোকেন সেভ করা
      
      // ৩. সাকসেস মেসেজ ও নেভিগেশন
      Get.snackbar('Success', 'Account created successfully!', 
          backgroundColor: Colors.green, colorText: Colors.white);
      
      // হোম পেজে নিয়ে যাওয়া
      Get.offAllNamed('/home'); 

    } catch (e) {
      Get.snackbar('Error', 'Failed to sign up: $e', 
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void signUpWithGoogle() => print('Google Sign Up');
  void signUpWithFacebook() => print('Facebook Sign Up');
  void navigateToLogin() => Get.toNamed('/login');
  void navigateToTerms() => Get.toNamed('/terms');

  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    passwordController.value.dispose();
    confirmPasswordController.value.dispose();
    super.onClose();
  }
}