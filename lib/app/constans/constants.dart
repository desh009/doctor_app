import 'package:intl/intl.dart';

class AppConstant {
  // Existing
  static const String authToken = "authToken";
  static const String user = "user";
  static const String intro = "intro";
  
  // New for Doctor App
  static const String userType = "userType";
  static const String doctorData = "doctorData";
  static const String patientData = "patientData";
  static const String medicalSettings = "medicalSettings";
  static const String consultationFee = "consultationFee";
  static const String appointmentDuration = "appointmentDuration";
  static const String bufferTime = "bufferTime";
  static const String emergencyContacts = "emergencyContacts";
  static const String medicalRecords = "medicalRecords";
  static const String notificationSettings = "notificationSettings";
  static const String introCompleted = "introCompleted";
  static const String language = "language";
  static const String theme = "theme";


    static DateFormat defaultDateFormat = DateFormat('yyyy-MM-dd');
  static DateFormat displayDateFormat = DateFormat('dd MMM yyyy');
  static DateFormat timeFormat = DateFormat('hh:mm a');
  static DateFormat dateTimeFormat = DateFormat('dd MMM yyyy hh:mm a');
  
}