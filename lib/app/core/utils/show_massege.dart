// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:group_app/app/core/theme/app_colors.dart';


// SnackbarController errorMessage({
//   String? message,
//   String? title,
//   String? action,
//   Function? onPressed,
//   bool? isDismissible,
// }) {
//   return Get.snackbar(
//     "",
//     "",
//     backgroundColor: AppColors.white,
//     titleText: Text(title ?? appLanguage().error, style: Get.textTheme.titleSmall!.copyWith(color: AppColors.red)),
//     messageText: Text(message ?? appLanguage().something_went_wrong, style: Get.textTheme.bodySmall),
//     onTap: (snack) {
//       if (onPressed != null) {
//         onPressed();
//       } else {
//         Get.back();
//       }
//     },
//     isDismissible: isDismissible ?? true,
//     duration: const Duration(seconds: 4),
//   );
// }


// SnackbarController successMessage({
//   String? message,
//   String? title,
//   String? action,
//   Function? onPressed,
//   bool? isDismissible,
// }) {
//   return Get.snackbar(
//     "",
//     "",
//     backgroundColor: AppColors.white,
//     titleText: Text(title ?? appLanguage().successful, style: Get.textTheme.titleSmall!.copyWith(color: AppColors.green)),
//     messageText: Text(message ?? appLanguage().something_went_wrong, style: Get.textTheme.bodySmall),
//     onTap: (snack) {
//       if (onPressed != null) {
//         onPressed();
//       } else {
//         Get.back();
//       }
//     },
//     isDismissible: isDismissible ?? true,
//     duration: const Duration(seconds: 4),
//   );
// }

// SnackbarController warningMessage({
//   String? message,
//   String? title,
//   String? action,
//   Function? onPressed,
//   bool? isDismissible,
// }) {
//   return Get.snackbar(
//     "",
//     "",
//     backgroundColor: AppColors.white,
//     titleText: Text(title ?? appLanguage().warning, style: Get.textTheme.titleSmall!.copyWith(color: AppColors.yellow)),
//     messageText: Text(message ?? appLanguage().something_went_wrong, style: Get.textTheme.bodySmall),
//     onTap: (snack) {
//       if (onPressed != null) {
//         onPressed();
//       } else {
//         Get.back();
//       }
//     },
//     isDismissible: isDismissible ?? true,
//     duration: const Duration(seconds: 4),
//   );
// }
