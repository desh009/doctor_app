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
          
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Colors.black,
                      height: 1,
                    ),
                    children: [
                      TextSpan(
                        text: '   Welcome Back',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 15),
          
                // Subtitle
                const Text(
                  '     Sign in to continue your learning journey\n              and explore new opportunities',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    height: 1.6,
                  ),
                ),
          
                const SizedBox(height: 40),
          
                // Social Login Buttons
                Row(
                  children: [
                    // Google Button
                    Expanded(
                      child: GestureDetector(
                        onTap: controller.loginWithGoogle,
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
                              Image.asset(
                                'assets/images/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Google',
                                style: TextStyle(
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
                    ),
          
                    const SizedBox(width: 15),
          
                    // Facebook Button
                    Expanded(
                      child: GestureDetector(
                        onTap: controller.loginWithFacebook,
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
                              Container(
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
                                      fontFamily: 'Rubik',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Facebook',
                                style: TextStyle(
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
                    ),
                  ],
                ),
          
                const SizedBox(height: 40),
          
                // Email Field
                Obx(
                  () => SmoothAnimatedTextField(
                    controller: controller.emailController,
                    label: 'Email',
                    textInputAction: TextInputAction.next,
                    validator: controller.validateEmail,
                  ),
                ),
          
                const SizedBox(height: 20),
          
                // Password Field
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
          
                const SizedBox(height: 15),
          
                // Remember Me & Forgot Password Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      // Remember Me Checkbox
                      Obx(() => Row(
                        children: [
                          Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) => controller.toggleRememberMe(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Rubik',
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )),
                      
                      const Spacer(),
                      
                      // Forgot Password
                      GestureDetector(
                        onTap: controller.navigateToForgotPasswordScreen,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Rubik',
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 50),
          
                // Login Button
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomElevatedButton(
                      text: controller.isLoading.value ? 'Logging in...' : 'Login',
                      onPressed: controller.isFormValid.value && !controller.isLoading.value
                          ? controller.login
                          : null,
                      isLoading: controller.isLoading.value,
                    ),
                  ),
                ),
          
                const SizedBox(height: 16),
          
                // Don't have account? Sign Up
                Center(
                  child: GestureDetector(
                    onTap: controller.navigateToSignUp,
                    child: const Text(
                      'Don\'t have an account? Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        color: Colors.blue,
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
}