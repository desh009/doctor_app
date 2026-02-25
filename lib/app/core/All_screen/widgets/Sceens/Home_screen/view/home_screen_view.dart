import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/All_screen/widgets/Sceens/Home_screen/controller/nav_cotroller/nav_controller.dart';
import 'package:group_app/app/core/theme/app_colors.dart';
// Apnar path onujayi import korun
// import 'package:group_app/app/core/theme/app_colors.dart'; 

class DoctorHomepage extends StatelessWidget {
  DoctorHomepage({super.key});

  final NavController navControl = Get.put(NavController());

  // Page List for Navigation
  final List<Widget> _pages = [
    const HomeViewContent(), // Niche dewa holo
    const Center(child: Text("Favorite Page")),
    const Center(child: Text("Book Page")),
    const Center(child: Text("Chat Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => _pages[navControl.selectedIndex.value]),
      
      // Custom Floating Bottom Navigation
      bottomNavigationBar: Obx(() => Container(
        height: 70,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, -5))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navItem(Icons.home, 0, isHome: true),
            _navItem(Icons.favorite, 1),
            _navItem(Icons.menu_book_rounded, 2),
            _navItem(Icons.chat_bubble_rounded, 3),
          ],
        ),
      )),
    );
  }

  Widget _navItem(IconData icon, int index, {bool isHome = false}) {
    bool isActive = navControl.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => navControl.changeIndex(index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isHome && isActive ? AppColors.primaryColor : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive ? (isHome ? Colors.white : AppColors.primaryColor) : AppColors.grey_sio,
          size: 26,
        ),
      ),
    );
  }
}

// --- Main Content of Home ---
class HomeViewContent extends StatelessWidget {
  const HomeViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header Section
          _buildHeader(),
          const SizedBox(height: 50),

          // 2. Live Doctors
          _sectionTitle("Live Doctors"),
          _buildLiveDoctors(),

          // 3. Categories
          _buildCategories(),

          // 4. Popular Doctors
          _sectionTitle("Popular Doctor", showSeeAll: true),
          _buildPopularDoctors(),

          // 5. Feature Doctors
          _sectionTitle("Feature Doctor", showSeeAll: true),
          _buildFeatureDoctors(),
          
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          ),
          padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi Handwerker!", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  Text("Find Your Doctor", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              CircleAvatar(radius: 25, backgroundColor: Colors.white.withOpacity(0.3)),
            ],
          ),
        ),
        Positioned(
          bottom: -25, left: 20, right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]),
            child: const TextField(
              decoration: InputDecoration(hintText: "Search.....", hintStyle: TextStyle(color: AppColors.grey_sio),
                  prefixIcon: Icon(Icons.search, color: AppColors.grey_sio), border: InputBorder.none),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title, {bool showSeeAll = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (showSeeAll) const Text("See all >", style: TextStyle(color: AppColors.grey_sio, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildLiveDoctors() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          width: 130,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(image: NetworkImage("https://picsum.photos/200"), fit: BoxFit.cover),
          ),
          child: const Center(child: Icon(Icons.play_circle_fill, color: Colors.white70, size: 40)),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final List<Map<String, dynamic>> cats = [
      {"icon": Icons.home, "color": Colors.indigoAccent},
      {"icon": Icons.favorite, "color": AppColors.primaryColor},
      {"icon": Icons.visibility, "color": Colors.orangeAccent},
      {"icon": Icons.accessibility_new, "color": Colors.redAccent},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: cats.map((c) => Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: c['color'], borderRadius: BorderRadius.circular(15)),
          child: Icon(c['icon'] as IconData, color: Colors.white),
        )).toList(),
      ),
    );
  }

  Widget _buildPopularDoctors() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: 2,
        itemBuilder: (context, index) => Container(
          width: 180,
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
          child: Column(
            children: [
              ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network("https://picsum.photos/201", height: 130, width: double.infinity, fit: BoxFit.cover)),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Dr. Fillerup Grab", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Medicine Specialist", style: TextStyle(color: AppColors.grey_sio, fontSize: 11)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureDoctors() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          width: 110,
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]),
          child: Column(
            children: [
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(Icons.favorite_border, size: 14, color: AppColors.grey_sio),
                Row(children: [Icon(Icons.star, color: Colors.orange, size: 12), Text("3.7", style: TextStyle(fontSize: 10))])
              ]),
              const CircleAvatar(radius: 20, backgroundImage: NetworkImage("https://picsum.photos/100")),
              const SizedBox(height: 5),
              const Text("Dr. Crick", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text("\$ 25.00/hr", style: TextStyle(color: Colors.green[600], fontSize: 9)),
            ],
          ),
        ),
      ),
    );
  }
}