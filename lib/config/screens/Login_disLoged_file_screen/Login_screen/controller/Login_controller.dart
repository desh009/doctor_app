import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/helper/helper.dart';
import 'package:group_app/app/core/helper/share_helper.dart';
import 'package:group_app/app/core/routes/app_pages.dart';
import 'package:group_app/app/core/theme/app_colors.dart';
import 'package:group_app/app/core/widgets/custome_button.dart';
import 'package:group_app/config/Floating_label_text_field/view/floating_label_text_view.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // TextEditingControllers
  late TextEditingController emailController;
  late TextEditingController passwordController;

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

    // OTP কন্ট্রোলার ইনিশিয়ালাইজ
    otpControllers = List.generate(4, (index) => TextEditingController());
    otpFocusNodes = List.generate(4, (index) => FocusNode());

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
      Get.snackbar(
        "Error",
        "Login failed: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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

  void showForgotPasswordBottmSheet() {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(Get.context!).size.height * 0.5,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: .circular(30)),
        ),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
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
              'Forgot Password ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter your email for verification, we will send 4 digit code to your email ',
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
                Get.back(); // প্রথম বটমশীট বন্ধ করুন
                fourdigitcodeforResetPassword();
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

  void resetpasswordbottomsheet() {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(Get.context!).size.height * 0.5,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: .circular(30)),
        ),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Center(
              child: Container(
                width: 90,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey_sio,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 25),

            const Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik',
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              ' Set the new password for your account so you can login and access all the features',

              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey_sio,
                fontFamily: "Rubik",
              ),
            ),

            const SizedBox(height: 20),
            SmoothAnimatedTextField(
              label: 'New Password',
              isPassword: true,
              textInputAction: TextInputAction.done,
              validator: validatePassword,
              controller: passwordController,
            ),
          ],
        ),
      ),
    );
  }

  void fourdigitcodeforResetPassword() {
    // OTP কন্ট্রোলার রিসেট করুন
    for (var controller in otpControllers) {
      controller.clear();
    }
    
    // প্রথম ফোকাস নোডে ফোকাস দিন
    Future.delayed(Duration(milliseconds: 300), () {
      otpFocusNodes[0].requestFocus();
    });

    Get.bottomSheet(
      Container(
        height: MediaQuery.of(Get.context!).size.height * 0.6,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle/Bar
            Center(
              child: Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Enter 4 Digits Code",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter the 4 digits code that you received on your email.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 40),

            // পিন ইনপুট রো (Row) - নতুন মেথড ব্যবহার
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 4; i++)
                  _otpBox(i),
              ],
            ),

            const SizedBox(height: 40),

            // Continue বাটন
            CustomElevatedButton(
              text: 'Continue',
              onPressed: () {
                // OTP ভেরিফিকেশন করুন
                String otp = otpControllers.map((c) => c.text).join('');
                if (otp.length == 4) {
                  Get.back(); // OTP বটমশীট বন্ধ করুন
                  resetpasswordbottomsheet(); // পাসওয়ার্ড রিসেট বটমশীট খুলুন
                } else {
                  Get.snackbar(
                    "Error",
                    "Please enter 4 digit code",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              isLoading: false,
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _otpBox(int index) {
    return SizedBox(
      height: 70,
      width: 65,
      child: TextField(
        controller: otpControllers[index],
        focusNode: otpFocusNodes[index],
        autofocus: index == 0,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textInputAction: index == 3 ? TextInputAction.done : TextInputAction.next,
        maxLength: 1,
        enableInteractiveSelection: false,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0EBE7E),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 3) {
              // পরের বক্সে ফোকাস নিয়ে যাও
              Future.delayed(Duration(milliseconds: 10), () {
                otpFocusNodes[index + 1].requestFocus();
              });
            } else {
              // শেষ বক্সে হলে কিবোর্ড বন্ধ করো
              FocusScope.of(Get.context!).unfocus();
            }
          }
          
          if (value.isEmpty && index > 0) {
            // আগের বক্সে ফোকাস নিয়ে যাও
            Future.delayed(Duration(milliseconds: 10), () {
              otpFocusNodes[index - 1].requestFocus();
            });
          }
        },
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Color(0xFF0EBE7E)),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    
    // OTP কন্ট্রোলার ও ফোকাস নোড ডিসপোজ
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    
    super.onClose();
  }
}