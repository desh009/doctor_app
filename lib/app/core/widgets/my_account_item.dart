// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:group_app/app/core/theme/app_colors.dart';

// import 'custom_text_field.dart';

// class MyAccountItem extends StatelessWidget {
//   final TextEditingController? controller;
//   final String? label;
//   final String? hint;
//   final String? Function(String?)? validator;
//   const MyAccountItem({super.key, this.controller, this.label, this.hint, this.validator});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(label??"", style: Get.textTheme.bodyMedium),
//         Expanded(
//           child: CustomTextField(
//             controller: controller,
//             textAlign: TextAlign.end,
//             hint: hint,
//             style: Get.textTheme.bodyMedium!.copyWith(color: AppColors.grayDark),
//             validator: validator,
//             border: InputBorder.none,
//             focusedBorder: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             errorBorder: InputBorder.none,
//             disabledBorder: InputBorder.none,
//           ),
//         ),
//         const Icon(
//           Icons.arrow_forward_ios,
//           color: AppColors.grayDark,
//           size: 16,
//         ),
//       ],
//     );
//   }
// }
