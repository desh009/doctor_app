import 'dart:convert';
import 'package:get/get.dart';
import 'package:group_app/app/constans/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareHelper {
  static SharedPreferences? _prefs;
  




  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('SharedPreferences not initialized. Call ShareHelper.init() first');
    }

    return _prefs!;
  }

  // ==================== AUTHENTICATION ====================
  
  static String get authToken {
    return prefs.getString(AppConstant.authToken) ?? '';
  }

  static set authToken(String token) {
    prefs.setString(AppConstant.authToken, token);
  }

  static bool get isLoggedIn {
    return authToken.isNotEmpty;
  }

  static String get userType {
    return prefs.getString(AppConstant.userType) ?? '';
  }

  static set userType(String type) {
    prefs.setString(AppConstant.userType, type);
  }

  // ==================== USER DATA ====================
  
  static Map<String, dynamic> get userData {
    try {
      final data = prefs.getString('user_data');
      return data != null ? json.decode(data) : {};
    } catch (e) {
      return {};
    }
  }

  static set userData(Map<String, dynamic> data) {
    prefs.setString('user_data', json.encode(data));
  }

  static String get userName {
    return userData['name']?.toString() ?? '';
  }

  static String get userEmail {
    return userData['email']?.toString() ?? '';
  }

  static String get userId {
    return userData['id']?.toString() ?? '';
  }

  // ==================== REMEMBER ME ====================
  
  static bool get rememberMe {
    return prefs.getBool('remember_me') ?? false;
  }

  static set rememberMe(bool value) {
    prefs.setBool('remember_me', value);
  }

  static String get savedEmail {
    return prefs.getString('saved_email') ?? '';
  }



  static set savedEmail(String email) {
    prefs.setString('saved_email', email);
  }

  static String get savedPassword {
    return prefs.getString('saved_password') ?? '';
  }

  static set savedPassword(String password) {
    prefs.setString('saved_password', password);
  }

  // ==================== DOCTOR DATA (যখন Model তৈরি করবেন) ====================
  
  /*
  // Doctor Model তৈরি হলে uncomment করুন
  
  static void setDoctor(Doctor doctor) {
    prefs.setString(AppConstant.doctorData, json.encode(doctor.toJson()));
  }

  static Doctor? getDoctor() {
    if (prefs.containsKey(AppConstant.doctorData)) {
      try {
        final data = prefs.getString(AppConstant.doctorData);
        return Doctor.fromJson(json.decode(data!));
      } catch (e) {
        return null;
      }
    }
    return null;
  }
  */

  // ==================== PATIENT DATA (যখন Model তৈরি করবেন) ====================
  
  /*
  // Patient Model তৈরি হলে uncomment করুন
  
  static void setPatient(Patient patient) {
    prefs.setString(AppConstant.patientData, json.encode(patient.toJson()));
  }

  static Patient? getPatient() {
    if (prefs.containsKey(AppConstant.patientData)) {
      try {
        final data = prefs.getString(AppConstant.patientData);
        return Patient.fromJson(json.decode(data!));
      } catch (e) {
        return null;
      }
    }
    return null;
  }
  */

  // ==================== MEDICAL SETTINGS ====================
  
  static void setMedicalSettings({
    bool? allowEmergencyCalls,
    bool? onlineConsultation,
    int? maxPatientsPerDay,
    String? consultationStartTime,
    String? consultationEndTime,
    List<String>? availableDays,
  }) {
    final settings = {
      'allowEmergencyCalls': allowEmergencyCalls ?? true,
      'onlineConsultation': onlineConsultation ?? true,
      'maxPatientsPerDay': maxPatientsPerDay ?? 20,
      'consultationStartTime': consultationStartTime ?? '09:00 AM',
      'consultationEndTime': consultationEndTime ?? '09:00 PM',
      'availableDays': availableDays ?? ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    };
    prefs.setString(AppConstant.medicalSettings, json.encode(settings));
  }

  static Map<String, dynamic> get medicalSettings {
    final defaultSettings = {
      'allowEmergencyCalls': true,
      'onlineConsultation': true,
      'maxPatientsPerDay': 20,
      'consultationStartTime': '09:00 AM',
      'consultationEndTime': '09:00 PM',
      'availableDays': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    };
    
    try {
      final data = prefs.getString(AppConstant.medicalSettings);
      return data != null ? json.decode(data) : defaultSettings;
    } catch (e) {
      return defaultSettings;
    }
  }

  // ==================== CONSULTATION FEE ====================
  
  static double get consultationFee {
    return prefs.getDouble(AppConstant.consultationFee) ?? 500.0;
  }

  static set consultationFee(double fee) {
    prefs.setDouble(AppConstant.consultationFee, fee);
  }

  // ==================== APPOINTMENT PREFERENCES ====================
  
  static int get appointmentDuration {
    return prefs.getInt(AppConstant.appointmentDuration) ?? 30;
  }

  static set appointmentDuration(int minutes) {
    prefs.setInt(AppConstant.appointmentDuration, minutes);
  }

  static int get bufferTime {
    return prefs.getInt(AppConstant.bufferTime) ?? 10;
  }

  static set bufferTime(int minutes) {
    prefs.setInt(AppConstant.bufferTime, minutes);
  }

  // ==================== EMERGENCY CONTACTS ====================
  
  static List<String> get emergencyContacts {
    return prefs.getStringList(AppConstant.emergencyContacts) ?? [];
  }

  static set emergencyContacts(List<String> contacts) {
    prefs.setStringList(AppConstant.emergencyContacts, contacts);
  }

  static void addEmergencyContact(String contact) {
    final contacts = emergencyContacts;
    if (!contacts.contains(contact)) {
      contacts.add(contact);
      emergencyContacts = contacts;
    }
  }

  // ==================== MEDICAL HISTORY ====================
  
  static List<Map<String, dynamic>> get medicalRecords {
    try {
      final data = prefs.getString(AppConstant.medicalRecords);
      if (data != null) {
        final List<dynamic> decoded = json.decode(data);
        return decoded.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      print('Error getting medical records: $e');
    }
    return [];
  }

  /*
  // MedicalRecord Model তৈরি হলে uncomment করুন
  
  static void saveMedicalRecord(MedicalRecord record) {
    final records = medicalRecords;
    records.add(record.toJson());
    prefs.setString(AppConstant.medicalRecords, json.encode(records));
  }
  */

  // ==================== NOTIFICATION SETTINGS ====================
  
  static void setNotificationSettings({
    bool? appointmentReminder,
    bool? prescriptionAlerts,
    bool? emergencyAlerts,
    bool? labResultAlerts,
  }) {
    final settings = {
      'appointmentReminder': appointmentReminder ?? true,
      'prescriptionAlerts': prescriptionAlerts ?? true,
      'emergencyAlerts': emergencyAlerts ?? true,
      'labResultAlerts': labResultAlerts ?? true,
    };
    prefs.setString(AppConstant.notificationSettings, json.encode(settings));
  }

  static Map<String, bool> get notificationSettings {
    final defaultSettings = {
      'appointmentReminder': true,
      'prescriptionAlerts': true,
      'emergencyAlerts': true,
      'labResultAlerts': true,
    };
    
    try {
      final data = prefs.getString(AppConstant.notificationSettings);
      return data != null ? Map<String, bool>.from(json.decode(data)) : defaultSettings;
    } catch (e) {
      return defaultSettings;
    }
  }

  // ==================== ONBOARDING ====================
  
  static bool get isIntroCompleted {
    return prefs.getBool(AppConstant.introCompleted) ?? false;
  }

  static set isIntroCompleted(bool value) {
    prefs.setBool(AppConstant.introCompleted, value);
  }

  // ==================== LOGOUT ====================
  
  static void logout() {
    // ✅ FIXED: AppConstant ব্যবহার করুন
    prefs.remove(AppConstant.authToken);
    prefs.remove(AppConstant.userType);
    prefs.remove(AppConstant.doctorData);
    prefs.remove(AppConstant.patientData);
    prefs.remove('user_data');
    
    Get.offAllNamed('/login');
  }

  // ==================== CLEAR METHODS ====================
  
  static void clearAuthData() {
    prefs.remove(AppConstant.authToken);
    prefs.remove(AppConstant.userType);
    prefs.remove(AppConstant.doctorData);
    prefs.remove(AppConstant.patientData);
    prefs.remove('user_data');
  }

  static void clearUserCredentials() {
    prefs.remove('saved_email');
    prefs.remove('saved_password');
    prefs.remove('remember_me');
  }

  static void clearAll() {
    prefs.clear();
  }

  // ==================== UTILITY METHODS ====================
  
  static bool hasKey(String key) {
    return prefs.containsKey(key);
  }

  static dynamic getValue(String key) {
    return prefs.get(key);
  }

  static void setValue(String key, dynamic value) {
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else if (value is Map) {
      prefs.setString(key, json.encode(value));
    }
  }

  static void removeKey(String key) {
    prefs.remove(key);
  }

  // ==================== HELPER METHODS ====================
  
  static bool get isDoctor => userType == 'doctor';
  static bool get isPatient => userType == 'patient';
  
  static Future<void> saveLoginCredentials({
    required String email,
    required String password,
    bool remember = false,
  }) async {
    if (remember) {
      savedEmail = email;
      savedPassword = password;
      rememberMe = true;
    } else {
      clearUserCredentials();
    }
  }
  
  static void loadSavedCredentials({
    required Function(String) setEmail,
    required Function(String) setPassword,
    required Function(bool) setRememberMe,
  }) {
    if (rememberMe) {
      setEmail(savedEmail);
      setPassword(savedPassword);
      setRememberMe(true);
    }
  }
}