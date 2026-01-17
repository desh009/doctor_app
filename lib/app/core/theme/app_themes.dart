// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:probashi_taxi_driver/app/core/theme/app_colors.dart';

// class AppThemes {
//   static final ThemeData light = ThemeData.light().copyWith(
//     colorScheme: const ColorScheme.light(
//       primary: AppColors.primary,
//       secondary: AppColors.secondary,
//       surface: AppColors.white,
//       background: AppColors.white,
//       error: AppColors.red,
//       onPrimary: AppColors.white,
//       onSecondary: AppColors.white,
//       onSurface: AppColors.black,
//       onBackground: AppColors.black,
//       onError: AppColors.white,
//       brightness: Brightness.light,
//     ),
//     brightness: Brightness.light,
//     primaryColor: AppColors.primary,
//     primaryColorDark: AppColors.primary,
//     primaryColorLight: AppColors.primary,
//     scaffoldBackgroundColor: AppColors.background,
//     iconTheme: const IconThemeData(color: AppColors.icon),
//     dividerColor: AppColors.grayDark,
//     appBarTheme: AppBarTheme(
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           // Status bar color
//           statusBarColor: AppColors.white,

//           // Status bar brightness (optional)
//           statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
//           statusBarBrightness: Brightness.light, // For iOS (dark icons)
//         ),
//         elevation: 0,
//         color: AppColors.primary,
//         iconTheme: const IconThemeData(color: AppColors.black),
//         titleTextStyle: GoogleFonts.poppins(
//           textStyle: TextStyle(
//               color: AppColors.black,
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w600),
//         ),),
//     bottomSheetTheme: const BottomSheetThemeData(
//       backgroundColor: Colors.white,
//     ),
//     inputDecorationTheme: const InputDecorationTheme(
//       border: OutlineInputBorder(
//         borderSide: BorderSide(color: AppColors.primary),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: AppColors.grayDark),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: AppColors.primary),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: AppColors.red),
//       ),
//       disabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: AppColors.grayDark),
//       ),
//     ),
//     cardColor: AppColors.white,
//     cardTheme: CardThemeData(
//       shadowColor: AppColors.grayBackground.withOpacity(0.8),
//       color: AppColors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//     ),
//     textTheme: TextTheme(
//       displayLarge: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.black,
//             fontSize: 36.sp,
//             height: 1.5,
//             fontWeight: FontWeight.w600),
//       ),
//       displayMedium: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.black,
//             fontSize: 26.sp,
//             fontWeight: FontWeight.bold),
//       ),
//       displaySmall: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.black,
//             fontSize: 22.sp,
//             fontWeight: FontWeight.bold),
//       ),
//       titleLarge: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.black,
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w600),
//       ),
//       titleMedium: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.black,
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600),
//       ),
//       titleSmall: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.black,
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w600),
//       ),
//       bodyLarge: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.black,
//             fontSize: 16.sp,
//             fontWeight: FontWeight.normal),
//       ),
//       bodyMedium: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.black,
//             fontSize: 14.sp,
//             fontWeight: FontWeight.normal),
//       ),
//       bodySmall: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.grayDark,
//             fontSize: 12.sp,
//             fontWeight: FontWeight.normal),
//       ),
//       labelLarge: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.black,
//             fontSize: 12.spMax,
//             fontWeight: FontWeight.normal),
//       ),
//       labelMedium: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.black,
//             fontSize: 10.spMax,
//             fontWeight: FontWeight.normal),
//       ),
//       labelSmall: GoogleFonts.poppins(
//         textStyle: TextStyle(
//             color: AppColors.black,
//             fontSize: 8.spMax,
//             fontWeight: FontWeight.normal),
//       ),
//     ),
//   );
// }
