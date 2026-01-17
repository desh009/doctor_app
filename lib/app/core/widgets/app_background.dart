// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:group_app/app/constans/assets.dart';
// import 'package:group_app/app/core/theme/app_colors.dart';


// class AppBackground extends StatelessWidget {
//   final Widget child;
//   final double? height;

//   const AppBackground({super.key, required this.child, this.height});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           color: AppColors.primary,
//           width: Get.width,
//           height: height ?? Get.height,
//           child: Column(
//             children: [
//               const Expanded(
//                 child: SizedBox(),
//               ),
//               SizedBox(
//                 width: Get.width,
//                 child: SvgPicture.asset(
//                   AppAssets.splashBottom,
//                   height: 140.h,
//                   width: Get.width,
//                   fit: BoxFit.cover,
//                 ),
//               )
//             ],
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: child,
//         )
//       ],
//     );
//   }
// }
