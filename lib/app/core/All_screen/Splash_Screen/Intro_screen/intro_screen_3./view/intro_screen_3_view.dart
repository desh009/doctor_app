import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/helper/share_helper.dart';
import 'package:group_app/app/core/theme/app_colors.dart';
import 'package:group_app/app/core/widgets/custome_button.dart';
import 'package:group_app/config/screens/Login_disLoged_file_screen/Login_screen/view/Login_view.dart';

class IntroScreen3View extends StatelessWidget {
  const IntroScreen3View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFE8F5F1)],
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  top: -60,
                  left: -200,
                  child: Container(
                    width: 450,
                    height: 450,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0EBE7E),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 150),
                    width: 320,
                    height: 320,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/Ellipse 2154.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Find Trusted Doctors",
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.6,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: CustomElevatedButton(
                  text: "Get Started", // এখানে Named Parameter হিসেবে text দিন
                  onPressed: () {
                    // ১. ইন্ট্রো দেখা শেষ তা সেভ করুন
                    ShareHelper.isIntroCompleted = true;

                    // ২. নেভিগেশন (Get.off ব্যবহার করা ভালো যাতে ব্যাক করলে এখানে না আসে)
                    Get.off(
                      () =>  LoginScreenView(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  isLoading: false, // isLoading ফিক্সড করা হয়েছে
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                ShareHelper.isIntroCompleted = true;
                Get.off(() =>  LoginScreenView());
              },
              child: const Text(
                "Skip",
                style: TextStyle(fontFamily: 'Rubik', color: Colors.teal),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
