import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/theme/app_colors.dart';
import 'package:group_app/app/core/widgets/custome_button.dart';
import 'package:group_app/app/reusable_content/sheed/sheed.dart';
import 'package:group_app/config/Floating_label_text_field/view/floating_label_text_view.dart';
import 'package:group_app/config/screens/Login_disLoged_file_screen/Login_screen/controller/Login_controller.dart';

class LoginScreenView extends GetView<LoginController> {
  const LoginScreenView({super.key});

  @override
  LoginController get controller => Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return CustomShadeBackground(
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),

                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    '            Welcome Back',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  '         Sign in to continue your learning journey\n                  and explore new opportunities',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 40),

                // --- Social Login Buttons (Same as before) ---
                Row(
                  children: [
                    _buildSocialButton(
                      'Google',
                      'assets/images/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                      controller.loginWithGoogle,
                    ),
                    const SizedBox(width: 15),
                    _buildSocialButton(
                      'Facebook',
                      null,
                      controller.loginWithFacebook,
                      isFacebook: true,
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // ১. Email Field (Obx রিমুভ করা হয়েছে কারণ controller.obs না হলে এরর দিবে)
                SmoothAnimatedTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  textInputAction: TextInputAction.next,
                  validator: controller.validateEmail,
                ),

                const SizedBox(height: 20),

                // ২. Password Field (Obx শুধুমাত্র পাসওয়ার্ড শো/হাইডের জন্য রাখা হয়েছে)
                Obx(
                  () => SmoothAnimatedTextField(
                    controller: controller.passwordController,
                    label: 'Password',
                    isPassword: !controller.isPasswordVisible.value,
                    textInputAction: TextInputAction.done,
                    validator: controller.validatePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ৪. Login Button (সম্পূর্ণ ফিক্সড)
                Obx(
                  () => CustomElevatedButton(
                    text: 'Login',
                    onPressed:
                        (controller.isFormValid.value &&
                            !controller.isLoading.value)
                        ? controller.login
                        : null,
                    isLoading: controller.isLoading.value,
                  ),
                ),
                const SizedBox(height: 20),

                // ৩. Remember Me & Forgot Password
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    GestureDetector(
                      onTap: controller.showForgotPasswordBottmSheet,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 116),

                Center(
                  child: GestureDetector(
                    onTap: controller.navigateToSignUp,
                    child: const Text(
                      'Don\'t have an account? Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // সোশ্যাল বাটনের জন্য একটি ছোট হেল্পার মেথড
  Widget _buildSocialButton(
    String label,
    String? iconPath,
    VoidCallback onTap, {
    bool isFacebook = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isFacebook
                  ? Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1877F2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'f',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : Image.asset(iconPath!, height: 24, width: 24),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
