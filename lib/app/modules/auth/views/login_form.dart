// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:probashi_taxi_driver/app/core/theme/app_colors.dart';
// import 'package:probashi_taxi_driver/app/widgets/custom_text_field.dart';
// import 'package:probashi_taxi_driver/app/widgets/custome_button.dart';

// import '../../../../main.dart';
// import '../../../core/utils/show_massege.dart';
// import '../../../routes/app_pages.dart';
// import '../controllers/auth_controller.dart';

// class LoginForm extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

//   LoginForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AuthController>();
//     return Form(
//       key: fromKey,
//       child: Column(
//         children: [
//           CustomTextField(
//             controller: emailController,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return appLanguage().is_required(appLanguage().email);
//               }
//               return null;
//             },
//             hint: appLanguage().email,
//             label: appLanguage().email,
//           ),
//           10.verticalSpace,
//           Obx(
//             () => CustomTextField(
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return appLanguage().is_required(appLanguage().password);
//                 }
//                 return null;
//               },
//               obscureText: controller.obscureTextLoginPassword.value,
//               obscureVisible: () {
//                 controller.obscureTextLoginPassword.value =
//                     !controller.obscureTextLoginPassword.value;
//               },
//               controller: passwordController,
//               hint: appLanguage().password,
//               label: appLanguage().password,
//             ),
//           ),
//           20.verticalSpace,
//           Obx(
//             () => CustomButton(
//                 text: appLanguage().login,
//                 isLoading: controller.loginIsLoading.value,
//                 onPressed: () {
//                   if (!fromKey.currentState!.validate()) {
//                     return;
//                   }
//                   controller.requestLogin(
//                     body: {
//                       "email": emailController.text,
//                       "password": passwordController.text
//                     },
//                     callback: () {
//                       emailController.clear();
//                       passwordController.clear();
//                       controller.update();
//                     },
//                   );
//                 }),
//           ),
//           10.verticalSpace,
//           TextButton(
//             onPressed: () {
//               Get.toNamed(Routes.FORGOT_PASSWORD);
//             },
//             child: Text(
//               appLanguage().forgot_password,
//               style:
//                   Get.textTheme.bodyMedium!.copyWith(color: AppColors.primary),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
