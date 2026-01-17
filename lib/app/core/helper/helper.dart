import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:group_app/app/constans/constants.dart';
import 'package:intl/intl.dart';


class Helper {
  // ==================== MEDICAL DATE/TIME PICKERS ====================

  /// Appointment date picker (শুধু ভবিষ্যতের তারিখ)
  static Future<String?> openAppointmentDatePicker({
    String initialDate = '',
    int daysInFuture = 365,
  }) async {
    DateTime selectedDate;
    try {
      selectedDate = initialDate.isNotEmpty
          ? DateTime.parse(initialDate)
          : DateTime.now();
    } catch (e) {
      selectedDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate,
      firstDate: DateTime.now(), // আজ থেকে শুরু
      lastDate: DateTime.now().add(Duration(days: daysInFuture)),
      locale: const Locale('en'),
    );

    if (picked != null && picked != selectedDate) {
      return AppConstant.defaultDateFormat.format(picked);
    } else {
      return null;
    }
  }

  /// Medical time slots generator (30 মিনিট interval)
  static List<String> generateTimeSlots({
    TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0),
    TimeOfDay endTime = const TimeOfDay(hour: 21, minute: 0),
    int intervalMinutes = 30,
  }) {
    List<String> slots = [];
    TimeOfDay current = startTime;

    while (current.hour < endTime.hour ||
        (current.hour == endTime.hour && current.minute < endTime.minute)) {
      slots.add(_formatTimeOfDay(current));
      current = _addMinutes(current, intervalMinutes);
    }

    return slots;
  }

  static TimeOfDay _addMinutes(TimeOfDay time, int minutes) {
    int totalMinutes = time.hour * 60 + time.minute + minutes;
    return TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
  }

  static String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dt);
  }

  static Future<String> openTimePicker({String? selectedTime}) async {
    TimeOfDay initialTime = selectedTime == null
        ? TimeOfDay.now()
        : _parseTimeString(selectedTime);

    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: initialTime,
    );

    if (picked != null) {
      return picked.format(Get.context!);
    } else {
      return '';
    }
  }

  static TimeOfDay _parseTimeString(String timeString) {
    try {
      final format = DateFormat('h:mm a');
      final dt = format.parse(timeString);
      return TimeOfDay(hour: dt.hour, minute: dt.minute);
    } catch (e) {
      return TimeOfDay.now();
    }
  }

  // ==================== DATE FORMATTERS ====================

  static String getMedicalDate(String date) {
    try {
      return DateFormat('dd MMM yyyy').format(DateTime.parse(date));
    } catch (e) {
      return date;
    }
  }

  static String getDateTime(String date) {
    try {
      return DateFormat('dd MMM yyyy hh:mm a').format(DateTime.parse(date));
    } catch (e) {
      return date;
    }
  }

  // ==================== MEDICAL VALIDATIONS ====================

  static bool isEmailValid(String email) {
    return GetUtils.isEmail(email);
  }

  static bool isPhoneValid(String phone) {
    return RegExp(
      r"(^([+]{1}[8]{2}|0088)?(01){1}[3-9]{1}\d{8})$",
    ).hasMatch(phone);
  }

  static bool isValidNID(String nid) {
    return RegExp(r'^[0-9]{10}$').hasMatch(nid) ||
        RegExp(r'^[0-9]{17}$').hasMatch(nid);
  }

  static bool isValidBirthCertificate(String bc) {
    return RegExp(r'^[0-9]{17}$').hasMatch(bc);
  }

  static bool isValidBloodGroup(String bloodGroup) {
    final validGroups = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
    return validGroups.contains(bloodGroup.toUpperCase());
  }

  static bool isValidPrescriptionID(String id) {
    return RegExp(r'^RX-[A-Z0-9]{8}$').hasMatch(id);
  }

  // ==================== MEDICAL STATUS COLORS ====================

  // static Color getAppointmentStatusColor(String status) {
  //   switch(status.toLowerCase()) {
  //     case "pending":
  //     case "scheduled":
  //       return AppColors.warning; // Orange
  //     case "confirmed":
  //     case "approved":
  //       return AppColors.success; // Green
  //     case "cancelled":
  //     case "rejected":
  //       return AppColors.error; // Red
  //     case "completed":
  //       return AppColors.info; // Blue
  //     case "emergency":
  //       return AppColors.emergency; // Deep Orange
  //     default:
  //       return AppColors.grey;
  //   }
  // }

  // static Color getPrescriptionStatusColor(String status) {
  //   switch(status.toLowerCase()) {
  //     case "active":
  //       return AppColors.success;
  //     case "expired":
  //       return AppColors.error;
  //     case "pending_review":
  //       return AppColors.warning;
  //     default:
  //       return AppColors.grey;
  //   }
  // }

  // static Color getPatientStatusColor(String status) {
  //   switch(status.toLowerCase()) {
  //     case "active":
  //       return AppColors.success;
  //     case "inactive":
  //       return AppColors.warning;
  //     case "critical":
  //       return AppColors.emergency;
  //     case "discharged":
  //       return AppColors.info;
  //     default:
  //       return AppColors.grey;
  //   }
  // }

  // ==================== MEDICAL CALCULATIONS ====================

  static int calculateAge(DateTime birthDate) {
    final current = DateTime.now();
    int age = current.year - birthDate.year;
    if (current.month < birthDate.month ||
        (current.month == birthDate.month && current.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  static String calculateBMI(double weightKg, double heightCm) {
    double heightM = heightCm / 100;
    double bmi = weightKg / (heightM * heightM);
    return bmi.toStringAsFixed(1);
  }

  static String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 24.9) return "Normal";
    if (bmi < 29.9) return "Overweight";
    return "Obese";
  }

  static String calculateNextDose(DateTime lastDose, int frequencyHours) {
    final nextDose = lastDose.add(Duration(hours: frequencyHours));
    return DateFormat('MMM dd, hh:mm a').format(nextDose);
  }

  // ==================== UTILITIES ====================

  static void textCopy({required String text}) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  static String formatMedicalRecordNumber(int number) {
    return 'MRN-${number.toString().padLeft(6, '0')}';
  }

  static String formatAppointmentID(int number) {
    return 'APT-${DateFormat('yyMMdd').format(DateTime.now())}-${number.toString().padLeft(3, '0')}';
  }

  // ==================== EMERGENCY HELPER ====================

  static Map<String, String> getEmergencyInfo(
    String bloodGroup,
    String allergies,
  ) {
    return {
      'blood_group': bloodGroup,
      'allergies': allergies,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  // ==================== MEDICAL FORMATTERS ====================

  static String formatPrescription(Map<String, dynamic> prescription) {
    return '''
Medication: ${prescription['medication']}
Dosage: ${prescription['dosage']}
Frequency: ${prescription['frequency']}
Duration: ${prescription['duration']}
Instructions: ${prescription['instructions']}
    ''';
  }

  static void showMedicalAlert(String title, String message) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: 'OK',
      onConfirm: Get.back,
    );
  }
}
