import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/helper/helper.dart';
import 'package:group_app/app/core/helper/share_helper.dart';
import 'package:group_app/app/core/routes/app_pages.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // TextEditingControllers
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  var isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    // ১. আগে থেকে সেভ করা credentials থাকলে লোড করা
    _loadSavedCredentials();

    // ২. রিয়েল-টাইম ভ্যালিডেশন লিসেনার
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  // --- মেথড: সেভ করা ডাটা লোড করা ---
  void _loadSavedCredentials() {
    if (ShareHelper.rememberMe) {
      emailController.text = ShareHelper.savedEmail;
      passwordController.text = ShareHelper.savedPassword;
      rememberMe.value = true;
    }
  }

  // --- মেথড: ফর্ম ভ্যালিডেশন চেক ---
  void _validateForm() {
    bool emailValid = Helper.isEmailValid(emailController.text.trim());
    bool passwordValid = passwordController.text.length >= 6;
    isFormValid.value = emailValid && passwordValid;
  }

  // --- মেথড: পাসওয়ার্ড শো/হাইড ---
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // --- মেথড: রিমেম্বার মি সুইচ ---
  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  // --- ভ্যালিডেটরস (UI এর জন্য) ---
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!Helper.isEmailValid(value)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  // --- মেইন লগইন লজিক ---
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    
    try {
      // এখানে আপনার API Call হবে
      // Example: var response = await authService.login(email, pass);
      
      await Future.delayed(const Duration(seconds: 2)); // সিমুলেশন

      // লগইন সফল হলে SharedPreferences এ ডাটা সেভ
      if (rememberMe.value) {
        ShareHelper.saveLoginCredentials(
          email: emailController.text.trim(),
          password: passwordController.text,
          remember: true,
        );
      } else {
        ShareHelper.clearUserCredentials();
      }

      // টোকেন সেভ করা (উদাহরণ)
      ShareHelper.authToken = "sample_token_123";
      
      Get.offAllNamed('/home'); // হোম পেজে নিয়ে যাওয়া
      
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // --- সোশ্যাল লগইন ---
  void loginWithGoogle() => print("Google Login clicked");
  void loginWithFacebook() => print("Facebook Login clicked");

  // --- নেভিগেশন ---
// controller এর ভেতর
void navigateToSignUp() {
  Get.toNamed(Routes.SIGN_UP); // এটি সরাসরি '/sign-up' কে কল করবে
} 

 void navigateToForgotPasswordScreen() => Get.toNamed('/forgot-password');

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}