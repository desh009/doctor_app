// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:get/get.dart';
// import 'package:probashi_taxi_driver/app/modules/auth/views/login_form.dart';
// import 'package:probashi_taxi_driver/app/modules/auth/views/signup_form.dart';
// import 'package:probashi_taxi_driver/app/widgets/app_background.dart';
// import 'package:probashi_taxi_driver/app/widgets/custome_button.dart';
// import 'package:probashi_taxi_driver/main.dart';

// import '../../../core/constans/assets.dart';
// import '../../../core/theme/app_colors.dart';
// import '../controllers/auth_controller.dart';

// class AuthView extends GetView<AuthController> {
//   const AuthView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(
//         init: controller,
//         builder: (context) {
//           return Scaffold(
//             body: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 AppBackground(
//                   height: controller.tabController.index==1 ? .36.sh : .45.sh,
//                   child: Container(
//                     height: controller.tabController.index==1 ? .36.sh : .45.sh,
//                     alignment: Alignment.bottomCenter,
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Center(
//                             child: Image.asset(
//                               AppAssets.logo,
//                               height: 110.r,
//                               width: 110.r,
//                             ),
//                           ),
//                         ),
//                         Card(
//                           color: AppColors.white,
//                           margin: EdgeInsets.zero,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10.r),
//                               topRight: Radius.circular(10.r),
//                             ),
//                           ),
//                           child: TabBar(
//                             controller: controller.tabController,
//                             indicatorColor: AppColors.primary,
//                             indicatorSize: TabBarIndicatorSize.label,
//                             labelPadding: EdgeInsets.only(bottom: 4,top: 16.r),
//                             tabs: [
//                               Text(
//                                 appLanguage().login,
//                                 style: Get.textTheme.titleLarge,
//                               ),
//                               Text(
//                                 appLanguage().signup,
//                                 style: Get.textTheme.titleLarge,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.r),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         width: Get.width,
//                         child: Card(
//                           margin: EdgeInsets.zero,
//                           color: AppColors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               bottomRight: Radius.circular(10.r),
//                               bottomLeft: Radius.circular(10.r),
//                             ),
//                           ),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(16.r),
//                                 child: AnimatedSwitcher(
//                                   duration: const Duration(milliseconds: 300),
//                                   child: controller.tabController.index == 0
//                                       ? LoginForm()
//                                       : SignUpForm(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       30.verticalSpace,
//                       /*CustomButton(
//                         color: AppColors.green,
//                         text: appLanguage().connect_with_hatsApp,
//                         onPressed: () {},
//                       ),

//                       30.verticalSpace,*/

//                     ],
//                   ),
//                 ),

//               ],
//             ),
//           );
//         });
//   }
// }
