import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/Intro_screen/intro_screen_3./view/intro_screen_3_view.dart';
import 'package:group_app/app/core/theme/app_colors.dart';
import 'package:group_app/app/reusable_content/sheed/sheed.dart';

class Intro2View extends StatelessWidget {
  const Intro2View({super.key});

  @override
  Widget build(BuildContext context) {
    // স্ক্রিনের সাইজ নেওয়ার জন্য
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: 
    Container(
          width: double.infinity,
          height: double.infinity,
          // পুরো স্ক্রিনের হালকা গ্রাডিয়েন্ট ব্যাকগ্রাউন্ড
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xFFE8F5F1), // নিচের দিকে হালকা মিন্ট কালার
              ],
            ),
          ),
          child: Column(
            children: [
              // উপরের ইমেজ এবং কার্ভ সেকশন
         Stack(
          children: [
            // ১. পিছনের বড় সবুজ গোল শেপ
            Positioned(
        top: -60, // উপরের দিকে অনেকটা বাইরে তুলে দেওয়া
        right: -200, // বাম দিকে অনেকটা বাইরে সরিয়ে দেওয়া
        child: Container(
          width: 450, // স্ক্রিনের চেয়েও বড় সাইজ
          height: 450,
          decoration: BoxDecoration(
            color: const Color(0xFF0EBE7E), // আপনার ছবির গ্রিন কালার
            shape: BoxShape.circle,
          ),
        ),
            ),
            Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 150), // উপর থেকে নিচে নামানোর জন্য
          width: 320, // ইমেজের সাইজ ছবির মতো বড় করা হয়েছে
          height: 320,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage("assets/images/Ellipse 154.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
            ),
          ],
        ),
        
              SizedBox(height: 40),
        
              // টাইটেল
              Text(
                "Find Trusted Doctors",
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
        
              SizedBox(height: 15),
        
              // ডেসক্রিপশন
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    color: AppColors.myColor,
                    height: 1.6,
                  ),
                ),
              ),
        
              Spacer(),
        
              // Get Started বাটন
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0EBE7E),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      
                      Get.to(() => IntroScreen3View(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut
                      );
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
        
              // Skip বাটন
              TextButton(
                onPressed: () {},
                child: Text(
                  "Skip",
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: AppColors.myColor),
                ),
              ),
        
              SizedBox(height: 30),
            ],
          ),
        ),
      
    );
  }
}