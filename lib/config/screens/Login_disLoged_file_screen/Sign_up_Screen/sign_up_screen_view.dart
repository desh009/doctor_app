import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                                const SizedBox(height: 100),

                const Text(
                  '   Join us to start searching',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 15),
                const Text(
                  '     You can search course, apply course and find\n                scholarship for abroad studies',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    color: Colors.black54,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 40),

                // Social Buttons Section... (আগের মতোই থাকবে)
                const SizedBox(height: 40),

                // ১. Name Field (Obx রিমুভ করা হয়েছে)
                SmoothAnimatedTextField(
                  controller: controller.nameController.value,
                  label: 'Name',
                  textInputAction: TextInputAction.next,
                  validator: controller.validateName,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),

                const SizedBox(height: 20),

                // ২. Email Field (Obx রিমুভ করা হয়েছে)
                SmoothAnimatedTextField(
                  controller: controller.emailController.value,
                  label: 'Email',
                  textInputAction: TextInputAction.next,
                  validator: controller.validateEmail,
                ),

                const SizedBox(height: 20),

                // ৩. Password Field (Obx রিমুভ করা হয়েছে)
                SmoothAnimatedTextField(
                  controller: controller.passwordController.value,
                  label: 'Password',
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  validator: controller.validatePassword,
                ),

                const SizedBox(height: 20),

                // ৪. Confirm Password Field (Obx রিমুভ করা হয়েছে)
                SmoothAnimatedTextField(
                  controller: controller.confirmPasswordController.value,
                  label: 'Confirm Password',
                  isPassword: true,
                  textInputAction: TextInputAction.next,
                  validator: controller.validateConfirmPassword,
                ),

                const SizedBox(height: 15),

                // ৫. Terms & Conditions (Obx লাগবে কারণ এখানে value চেঞ্জ হয়)
                Obx(
                  () => Row(
                    children: [
                      Checkbox(
                        value: controller.isAgreed.value,
                        onChanged: (value) => controller.toggleAgreement(),
                      ),
                      const Expanded(
                        child: Text(
                          'I agree with the Terms of Service & Privacy Policy',
                          style: TextStyle(fontSize: 14, fontFamily: 'Rubik'),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // ৬. Sign Up Button (সম্পূর্ণ ফিক্সড লজিক)
                Obx(
                  () => CustomElevatedButton(
                    text: 'Sign Up',
                    isLoading: controller.isLoading.value,
                    onPressed: () => controller.signUp(),
                  ),
                ),
                const SizedBox(height: 16),

                Center(
                  child: GestureDetector(
                    onTap: controller.navigateToLogin,
                    child: const Text(
                      'Have an account? Login',
                      style: TextStyle(
                        fontSize: 16,
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
