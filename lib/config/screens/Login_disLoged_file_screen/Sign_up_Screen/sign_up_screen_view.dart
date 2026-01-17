import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/theme/app_colors.dart';
import 'package:group_app/app/core/widgets/custome_button.dart';
import 'package:group_app/app/reusable_content/sheed/sheed.dart';
import 'package:group_app/config/Floating_label_text_field/view/floating_label_text_view.dart';
import 'package:group_app/config/screens/Login_disLoged_file_screen/Sign_up_Screen/sign_up_screen_controller.dart';

class SignUpScreenView extends GetView<SignUpController> {
  const SignUpScreenView({super.key});

  @override
  SignUpController get controller => Get.put(SignUpController());

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
                        text: '   Join us to start searching',
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
                  '     You can search course, apply course and find\n                scholarship for abroad studies',
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
                        onTap: controller.signUpWithGoogle,
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
                        onTap: controller.signUpWithFacebook,
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
          
                // Name Field
                Obx(
                  () => SmoothAnimatedTextField(
                    controller: controller.nameController.value,
                    label: 'Name', textInputAction: TextInputAction.next,
                    validator: controller.validateName,
                    onFieldSubmitted: (_) => controller.emailController.value.text.isNotEmpty ? FocusScope.of(context).nextFocus() : null,
                  ),
                ),
          
                const SizedBox(height: 20),
          
                // Email Field
                Obx(
                  () => SmoothAnimatedTextField(
                    controller: controller.emailController.value,
                    label: 'Email', textInputAction: TextInputAction.next,
                    validator: controller.validateEmail,
                  ),
                ),
          
                const SizedBox(height: 20),
          
                // Password Field
                Obx(
                  () => SmoothAnimatedTextField(
                    controller: controller.passwordController.value,
                    label: 'Password',
                    isPassword: true, textInputAction: TextInputAction.done,
                    validator: controller.validatePassword,
                    
                  ),
                ),
          
                const SizedBox(height: 20),
          
                // Confirm Password Field
                Obx(
                  () => SmoothAnimatedTextField(
                    
                    controller: controller.confirmPasswordController.value,
                    label: 'Confirm Password',
                    isPassword: true, textInputAction: TextInputAction.next,
                    validator: controller.validateConfirmPassword,
                  ),
                ),
          
                const SizedBox(height: 15),
          
                // Terms & Conditions Checkbox
                Obx(
                  () => Row(
                    children: [
                      Checkbox(
                        value: controller.isAgreed.value,
                        onChanged: (value) => controller.toggleAgreement(),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: controller.navigateToTerms,
                          child: const Text(
                            'I agree with the Terms of Service & Privacy Policy',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Rubik',
                              color: AppColors.myColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 50),
          
                // Sign Up Button
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomElevatedButton(
                      text: 'Sign Up',
                      onPressed: controller.isLoading.value ? null : controller.signUp,
                      isLoading: controller.isLoading.value,
                    ),
                  ),
                ),
          
                const SizedBox(height: 16),
          
                // Already have account? Login
                Center(
                  child: GestureDetector(
                    onTap: controller.navigateToLogin,
                    child: const Text(
                      'Have an account? Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        color: Colors.blue, // আপনার প্রাইমারি কালার
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
