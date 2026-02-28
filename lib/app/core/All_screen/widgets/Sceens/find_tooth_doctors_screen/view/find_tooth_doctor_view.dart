import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/All_screen/widgets/Sceens/Booking_doctors/binder/booking_binder.dart';
import 'package:group_app/app/core/All_screen/widgets/Sceens/Booking_doctors/view/booking_view.dart';
import 'package:group_app/app/core/All_screen/widgets/Sceens/find_tooth_doctors_screen/controller/find_tooth_controller_view.dart';
import 'package:group_app/app/core/theme/app_colors.dart';
import 'package:group_app/app/reusable_content/sheed/sheed.dart';

class FindDoctorScreen extends StatelessWidget {
  final String? initialCategory;

  const FindDoctorScreen({super.key, this.initialCategory});

  @override
  Widget build(BuildContext context) {
    // Controller initialize kora
    final FindDoctorController controller = Get.put(FindDoctorController());

    // Initial category thakle seta set kora
    if (initialCategory != null && initialCategory!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.setCategory(initialCategory!);
      });
    }

    return CustomShadeBackground(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(
          0.9,
        ), // Background transparency
        appBar: _buildAppBar(controller),
        body: Column(
          children: [
            _buildSearchBar(controller),

            // Category list (Dentist, Cardiologist etc)
            _buildCategoryChips(controller),

            Expanded(
              child: Obx(() {
                if (controller.filteredDoctors.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.filteredDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = controller.filteredDoctors[index];

                    // Original list theke index khuje ber kora favorite toggle korar jonno
                    final originalIndex = controller.allDoctors.indexWhere(
                      (d) => d['name'] == doctor['name'],
                    );

                    return _buildDoctorCard(
                      name: doctor['name'] ?? '',
                      specialty: doctor['specialty'] ?? '',
                      exp: doctor['exp'] ?? '',
                      like: doctor['like'] ?? '',
                      stories: doctor['stories'] ?? '',
                      isFavorite: doctor['isFavorite'] ?? false,
                      nextAvailable: doctor['nextAvailable'] ?? '',
                      imageUrl: doctor['image'] ?? '',
                      onFavoriteTap: () =>
                          controller.toggleFavorite(originalIndex),
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

  // --- Search Bar Builder ---
  Widget _buildSearchBar(FindDoctorController controller) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: TextField(
          onChanged: (value) => controller.updateSearch(value),
          decoration: InputDecoration(
            hintText: "Search by doctor name or specialty",
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
            suffixIcon: Obx(
              () => controller.searchText.value.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: controller.clearSearch,
                    )
                  : const SizedBox.shrink(),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  // --- Category Chips Section ---
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
          return Obx(() {
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
                backgroundColor: Colors.white,
                selectedColor: AppColors.primaryColor.withOpacity(0.2),
                checkmarkColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.primaryColor : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          });
        },
      ),
    );
  }

  // --- Doctor Card Builder ---
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
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 80,
                    width: 80,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 15),
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
                    Text(
                      specialty,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      exp,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(height: 8),
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
                  Text(
                    nextAvailable,
                    style: TextStyle(color: Colors.grey[600], fontSize: 11),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(
                    
                    () => const SelectTimeScreen(),
                    arguments: {
                      'name': name,
                      'specialty': specialty,
                      'exp': exp,
                      'like': like,
                      'stories': stories,
                      'imageUrl': imageUrl,
                      'isFavorite': isFavorite,
                    },
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

  // --- App Bar ---
  PreferredSizeWidget _buildAppBar(FindDoctorController controller) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
        onPressed: () => Get.back(),
      ),
      title: Obx(
        () => Text(
          controller.selectedCategory.value?.isEmpty ?? true
              ? "Find Doctors"
              : "${controller.selectedCategory.value}",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // --- Helper Methods ---
  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 12),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'No doctors found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
