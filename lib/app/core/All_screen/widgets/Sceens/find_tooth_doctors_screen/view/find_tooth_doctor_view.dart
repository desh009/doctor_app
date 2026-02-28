import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/All_screen/widgets/Sceens/find_tooth_doctors_screen/controller/find_tooth_controller_view.dart';
import 'package:group_app/app/core/theme/app_colors.dart';
import 'package:group_app/app/reusable_content/sheed/sheed.dart';

class FindDoctorScreen extends StatelessWidget {
  final String? initialCategory;
  
  const FindDoctorScreen({super.key, this.initialCategory});

  @override
  Widget build(BuildContext context) {
    final FindDoctorController controller = Get.put(FindDoctorController());
    
    // যদি initialCategory দেওয়া থাকে, তাহলে সেটি সেট করুন
    if (initialCategory != null && initialCategory!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.setCategory(initialCategory!);
      });
    }
    
    return CustomShadeBackground(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: _buildAppBar(controller),
        body: Column(
          children: [
            _buildSearchBar(controller),
            
            // ক্যাটাগরি চিপস (যদি সব ডাক্তার দেখাতে চান)
            _buildCategoryChips(controller),
            
            Expanded(
              child: Obx(() {
                if (controller.filteredDoctors.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No doctors found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try searching with a different name\nor select another category',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.filteredDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = controller.filteredDoctors[index];
                    final originalIndex = controller.allDoctors.indexWhere(
                      (d) => d['name'] == doctor['name']
                    );
                    
                    return _buildDoctorCard(
                      name: doctor['name'],
                      specialty: doctor['specialty'],
                      exp: doctor['exp'],
                      like: doctor['like'],
                      stories: doctor['stories'],
                      isFavorite: doctor['isFavorite'],
                      nextAvailable: doctor['nextAvailable'],
                      imageUrl: doctor['image'],
                      onFavoriteTap: () => controller.toggleFavorite(originalIndex),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ক্যাটাগরি চিপস সেকশন
  Widget _buildCategoryChips(FindDoctorController controller) {
    final categories = [
      'All',
      'Dentist',
      'Cardiologist',
      'Eye Specialist',
      'Physiotherapist',
      'General Physician',
    ];
    
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == 'All' 
              ? controller.selectedCategory.value?.isEmpty ?? true
              : controller.selectedCategory.value == category;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                if (category == 'All') {
                  controller.showAllCategories();
                } else {
                  controller.setCategory(category);
                }
              },
              backgroundColor: Colors.grey[100],
              selectedColor: AppColors.primaryColor.withOpacity(0.2),
              checkmarkColor: AppColors.primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primaryColor : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  // App Bar Builder
  PreferredSizeWidget _buildAppBar(FindDoctorController controller) {
    return AppBar(
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
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.grey,
              size: 18,
            ),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      title: Obx(() => Text(
        controller.selectedCategory.value?.isEmpty ?? true
            ? "Find Doctors"
            : "${controller.selectedCategory.value}",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      )),
      actions: [
        if (controller.selectedCategory.value?.isNotEmpty ?? false)
          TextButton(
            onPressed: controller.showAllCategories,
            child: const Text(
              'Clear Filter',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
      ],
    );
  }

  // Search Bar Builder
  Widget _buildSearchBar(FindDoctorController controller) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          onChanged: (value) => controller.updateSearch(value),
          decoration: InputDecoration(
            hintText: "Search by doctor name or specialty",
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
            suffixIcon: Obx(() => controller.searchText.value.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                    onPressed: controller.clearSearch,
                  )
                : const SizedBox.shrink()),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
  
  // Doctor Card Builder (আপডেটেড)
  Widget _buildDoctorCard({
    required String name,
    required String specialty,
    required String exp,
    required String like,
    required String stories,
    required bool isFavorite,
    required String nextAvailable,
    required String imageUrl,
    required VoidCallback onFavoriteTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 80,
                      width: 80,
                      color: Colors.grey[200],
                      child: const Icon(Icons.person, color: Colors.grey),
                    );
                  },
                ),
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
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: onFavoriteTap,
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      specialty,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exp,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(height: 8),
                    
                    // Stats (Like & Stories)
                    Row(
                      children: [
                        _buildStatItem(Icons.thumb_up, like),
                        const SizedBox(width: 15),
                        _buildStatItem(Icons.chat_bubble_outline, stories),
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
                  const Text(
                    "Next Available",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    nextAvailable,
                    style: TextStyle(color: Colors.grey[600], fontSize: 11),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    "Booking",
                    "Booking for $name",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method for stat items
  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: 12,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}