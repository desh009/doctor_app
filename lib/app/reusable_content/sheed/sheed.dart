import 'package:flutter/material.dart';
import 'dart:ui'; // ImageFilter এর জন্য প্রয়োজন

class CustomShadeBackground extends StatelessWidget {
  final Widget child;
  static const Color skyBlue = Color(0xFF61CEFF);

  const CustomShadeBackground({super.key, required this.child});
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ১. বাম পাশে উপরে হালকা নীল শেড
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: skyBlue.withOpacity(0.15), // খুব হালকা নীল
                shape: BoxShape.circle,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80), // ব্লাড ইফেক্ট
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          // ২. ডান পাশে নিচে হালকা নীল শেড
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: skyBlue.withOpacity(0.2), // নিচের শেডটা একটু গাঢ়
                shape: BoxShape.circle,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          // ৩. মেইন কন্টেন্ট
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}