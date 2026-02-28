// select_time_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/All_screen/widgets/Sceens/Booking_doctors/controller/booking_controller.dart';
import 'package:group_app/app/core/theme/app_colors.dart';
import 'package:group_app/app/reusable_content/sheed/sheed.dart';

class SelectTimeScreen extends StatelessWidget {
  const SelectTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final SelectTimeController controller = Get.put(SelectTimeController());

    return Scaffold(
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
              onPressed: () => Get.back(),
            ),
          ),
        ),
        title: const Text(
          "Select Time",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: CustomShadeBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // 1. Doctor Info Card
              _buildDoctorBriefCard(controller),
              const SizedBox(height: 30),
            
              // 2. Date Selection Row
              _buildDateSelection(controller),
              const SizedBox(height: 40),
            
              // 3. Availability Info
              Obx(() => Text(
                controller.selectedDate.value,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 10),
              
              // Show loading indicator or slots
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }
                
                if (controller.availableSlots.isEmpty) {
                  return const Text(
                    "No slots available",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  );
                }
                
                return _buildTimeSlots(controller);
              }),
              
              const SizedBox(height: 30),
            
              // 4. Action Buttons
              Obx(() => controller.availableSlots.isEmpty
                ? _buildActionButton(
                    "Next availability on wed, 24 Feb",
                    AppColors.primaryColor,
                    Colors.white,
                    onTap: () => controller.changeDate('Tomorrow, 24 Feb'),
                  )
                : const SizedBox.shrink()
              ),
              
              Obx(() => controller.availableSlots.isEmpty
                ? Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "OR", 
                        style: TextStyle(
                          color: Colors.grey, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                : const SizedBox.shrink()
              ),
              
              _buildActionButton(
                "Contact Clinic",
                Colors.white,
                AppColors.primaryColor,
                isBorder: true,
                onTap: controller.contactClinic,
              ),
              
              const SizedBox(height: 20),
              
              // Book Now Button (only show if slot selected)
              Obx(() => controller.selectedSlot.value.isNotEmpty
                ? _buildActionButton(
                    "Book Appointment",
                    AppColors.primaryColor,
                    Colors.white,
                    onTap: controller.bookAppointment,
                  )
                : const SizedBox.shrink()
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Doctor Brief Card Builder
  Widget _buildDoctorBriefCard(SelectTimeController controller) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              // সরাসরি doctor map ব্যবহার করুন (value ছাড়া)
              controller.doctor['imageUrl'] ?? 
                "https://i.pravatar.cc/150?u=${controller.doctor['name']}",
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
                        // সরাসরি doctor map ব্যবহার করুন
                        controller.doctor['name'] ?? 'Doctor Name', 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Obx(() => IconButton(
                      icon: Icon(
                        controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                        color: controller.isFavorite.value ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                      onPressed: controller.toggleFavorite,
                    )),
                  ],
                ),
                Text(
                  // সরাসরি doctor map ব্যবহার করুন
                  controller.doctor['specialty'] ?? 'Specialist', 
                  style: const TextStyle(color: AppColors.primaryColor, fontSize: 12),
                ),
                Text(
                  // সরাসরি doctor map ব্যবহার করুন
                  controller.doctor['exp'] ?? '5 years experience', 
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    _buildStatItem(Icons.thumb_up, controller.doctor['like'] ?? '98%'),
                    const SizedBox(width: 15),
                    _buildStatItem(Icons.chat_bubble_outline, controller.doctor['stories'] ?? '150+'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for stat items
  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 12),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  // Time Slots Grid
  Widget _buildTimeSlots(SelectTimeController controller) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: controller.availableSlots.map((slot) {
        return Obx(() => ChoiceChip(
          label: Text(slot),
          selected: controller.selectedSlot.value == slot,
          onSelected: (selected) => controller.selectSlot(slot),
          selectedColor: AppColors.primaryColor.withOpacity(0.2),
          backgroundColor: Colors.white,
          labelStyle: TextStyle(
            color: controller.selectedSlot.value == slot 
              ? AppColors.primaryColor 
              : Colors.black,
            fontWeight: controller.selectedSlot.value == slot
              ? FontWeight.bold
              : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(
            color: controller.selectedSlot.value == slot
              ? AppColors.primaryColor
              : Colors.grey.withOpacity(0.3),
          ),
        ));
      }).toList(),
    );
  }

  // Date Selection Builder
  Widget _buildDateSelection(SelectTimeController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _dateItem(
          "Today, 23 Feb", 
          "No slots", 
          controller.selectedDate.value == 'Today, 23 Feb',
          onTap: () => controller.changeDate('Today, 23 Feb'),
        ),
        _dateItem(
          "Tomorrow, 24 Feb", 
          "9 slots", 
          controller.selectedDate.value == 'Tomorrow, 24 Feb',
          onTap: () => controller.changeDate('Tomorrow, 24 Feb'),
        ),
        _dateItem(
          "Thu, 25 Feb", 
          "10 slots", 
          controller.selectedDate.value == 'Thu, 25 Feb',
          onTap: () => controller.changeDate('Thu, 25 Feb'),
        ),
      ],
    );
  }

  Widget _dateItem(String day, String slots, bool isActive, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.28,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? AppColors.primaryColor : Colors.grey.withOpacity(0.1)
          ),
        ),
        child: Column(
          children: [
            Text(
              day, 
              textAlign: TextAlign.center, 
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 12, 
                color: isActive ? Colors.white : Colors.black
              ),
            ),
            const SizedBox(height: 5),
            Text(
              slots, 
              textAlign: TextAlign.center, 
              style: TextStyle(
                fontSize: 9, 
                color: isActive ? Colors.white70 : Colors.grey
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Action Button Builder
  Widget _buildActionButton(
    String text, 
    Color bgColor, 
    Color textColor, {
    bool isBorder = false, 
    VoidCallback? onTap
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isBorder 
              ? BorderSide(color: AppColors.primaryColor.withOpacity(0.2)) 
              : BorderSide.none,
          ),
        ),
        child: Text(
          text, 
          style: TextStyle(
            color: textColor, 
            fontWeight: FontWeight.bold, 
            fontSize: 14
          ),
        ),
      ),
    );
  }
}