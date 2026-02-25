import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:group_app/app/core/theme/app_colors.dart';
import 'package:group_app/app/reusable_content/sheed/sheed.dart';

class FindDoctorScreen extends StatelessWidget {
  const FindDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShadeBackground(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  leading: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey, size: 18),
        onPressed: () {
          Get.back(); // GetX দিয়ে ব্যাক করুন
          // অথবা Navigator.pop(context); // সাধারণ Flutter দিয়ে ব্যাক করুন
        },
      ),
    ),
  ),
  title: const Text("Find Doctors", 
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Dentist",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: Icon(Icons.close, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
      
            // Doctor List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildDoctorCard("Dr. Shruti Kedia", "Tooths Dentist", "7 Years experience", "87%", "69 Patient Stories", true),
                  _buildDoctorCard("Dr. Watamaniuk", "Tooths Dentist", "9 Years experience", "74%", "78 Patient Stories", false),
                  _buildDoctorCard("Dr. Crownover", "Tooths Dentist", "5 Years experience", "59%", "86 Patient Stories", true),
                  _buildDoctorCard("Dr. Balestra", "Tooths Dentist", "6 Years experience", "57%", "42 Patient Stories", false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Doctor Card Widget Builder
  Widget _buildDoctorCard(String name, String specialty, String exp, String like, String stories, bool isFavorite) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network("https://i.pravatar.cc/150?u=$name", height: 80, width: 80, fit: BoxFit.cover),
              ),
              const SizedBox(width: 15),
              // Doctor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Icon(isFavorite ? Icons.favorite : Icons.favorite_border, 
                             color: isFavorite ? Colors.red : Colors.grey, size: 20),
                      ],
                    ),
                    Text(specialty, style: const TextStyle(color: AppColors.primaryColor, fontSize: 12)),
                    const SizedBox(height: 5),
                    Text(exp, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    const SizedBox(height: 8),
                    // Stats (Like & Stories)
                    Row(
                      children: [
                        const Icon(Icons.circle, color: AppColors.primaryColor, size: 10),
                        const SizedBox(width: 4),
                        Text(like, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                        const SizedBox(width: 15),
                        const Icon(Icons.circle, color: AppColors.primaryColor, size: 10),
                        const SizedBox(width: 4),
                        Text(stories, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Availability & Book Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Next Available", style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
                  Text("10:00 AM tomorrow", style: TextStyle(color: Colors.grey[600], fontSize: 11)),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                ),
                child: const Text("Book Now", style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}