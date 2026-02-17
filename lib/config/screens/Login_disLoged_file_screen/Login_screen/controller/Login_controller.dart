import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/helper/helper.dart';
import 'package:group_app/app/core/helper/share_helper.dart';
import 'package:group_app/app/core/routes/app_pages.dart';
import 'package:group_app/app/core/theme/app_colors.dart';
import 'package:group_app/app/core/widgets/custome_button.dart';
import 'package:group_app/config/Floating_label_text_field/view/floating_label_text_view.dart';
import 'package:group_app/config/Otp_verfication_sheet/otp_verification_sheet.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  var isFormValid = false.obs;

  // OTP এর জন্য ভেরিয়েবল
  late List<TextEditingController> otpControllers;
  late List<FocusNode> otpFocusNodes;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    // OTP কন্ট্রোলার ইনিশিয়ালাইজ
    otpControllers = List.generate(4, (index) => TextEditingController());
    otpFocusNodes = List.generate(4, (index) => FocusNode());

    _loadSavedCredentials();
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  void _loadSavedCredentials() {
    if (ShareHelper.rememberMe) {
      emailController.text = ShareHelper.savedEmail;
      passwordController.text = ShareHelper.savedPassword;
      rememberMe.value = true;
    }
  }

  void _validateForm() {
    bool emailValid = Helper.isEmailValid(emailController.text.trim());
    bool passwordValid = passwordController.text.length >= 6;
    isFormValid.value = emailValid && passwordValid;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

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

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (rememberMe.value) {
        ShareHelper.saveLoginCredentials(
          email: emailController.text.trim(),
          password: passwordController.text,
          remember: true,
        );
      } else {
        ShareHelper.clearUserCredentials();
      }

      ShareHelper.authToken = "sample_token_123";
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        "Error",
        "Login failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void loginWithGoogle() => print("Google Login clicked");
  void loginWithFacebook() => print("Facebook Login clicked");

  void navigateToSignUp() {
    Get.toNamed(Routes.SIGN_UP);
  }

  void showForgotPasswordBottmSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey_sio,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter your email for verification, we will send 4 digit code to your email',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontFamily: 'Rubik',
              ),
            ),
            const SizedBox(height: 30),
            SmoothAnimatedTextField(
              label: 'Email',
              textInputAction: TextInputAction.done,
              validator: validateEmail,
              controller: emailController,
            ),
            const SizedBox(height: 60),
            CustomElevatedButton(
              text: 'Continue',
              onPressed: () {
                Get.back();
                fourdigitcodeforResetPassword(context);
              },
              isLoading: false,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // ✅ OTP বক্সের UI আলাদা widget এ সরিয়ে নিন অথবা StatefulWidget তৈরি করুন
  void fourdigitcodeforResetPassword(BuildContext context) {
    for (var controller in otpControllers) {
      controller.clear();
    }
    
    Future.delayed(const Duration(milliseconds: 300), () {
      otpFocusNodes[0].requestFocus();
    });

    // OTP UI এর জন্য আলাদা StatefulWidget তৈরি করুন
    Get.bottomSheet(
      OTPVerificationSheet(
        controllers: otpControllers,
        focusNodes: otpFocusNodes,
        onComplete: (otp) {
          if (otp.length == 4) {
            Get.back();
            // resetpasswordbottomsheet(context);
          }
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}