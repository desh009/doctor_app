// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:probashi_taxi_driver/app/core/utils/show_massege.dart';
// import 'package:probashi_taxi_driver/app/widgets/custom_text_field.dart';
// import 'package:probashi_taxi_driver/app/widgets/custome_button.dart';

// import '../../../../main.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../routes/app_pages.dart';
// import '../controllers/auth_controller.dart';

// class SignUpForm extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

//   SignUpForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AuthController>();
//     return Form(
//       key: fromKey,
//       child: Column(
//         children: [
//           CustomTextField(
//             controller: nameController,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return appLanguage().is_required(appLanguage().name);
//               }
//               return null;
//             },
//             hint: appLanguage().name,
//             label: appLanguage().name,
//           ),
//           10.verticalSpace,
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
//               obscureText: controller.obscureTextRegPassword.value,
//               obscureVisible: () {
//                 controller.obscureTextRegPassword.value =
//                     !controller.obscureTextRegPassword.value;
//               },
//               controller: passwordController,
//               hint: appLanguage().password,
//               label: appLanguage().password,
//             ),
//           ),
//           10.verticalSpace,
//           Obx(
//             () => CustomTextField(
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return appLanguage()
//                       .is_required(appLanguage().confirm_password);
//                 } else if (value != passwordController.text) {
//                   return appLanguage().confirm_password_not_match;
//                 }
//                 return null;
//               },
//               obscureText: controller.obscureTextRegComPassword.value,
//               obscureVisible: () {
//                 controller.obscureTextRegComPassword.value =
//                     !controller.obscureTextRegComPassword.value;
//               },
//               controller: confirmPasswordController,
//               hint: appLanguage().confirm_password,
//               label: appLanguage().confirm_password,
//             ),
//           ),
//           10.verticalSpace,
//           Obx(
//             () => CheckboxListTile(
//               fillColor: MaterialStateProperty.all(
//                   controller.isAgree.value ? AppColors.primary : AppColors.background),
//               controlAffinity: ListTileControlAffinity.leading,
//               value: controller.isAgree.value,
//               onChanged: (value) {
//                 controller.isAgree.value = value!;
//               },
//               title: Text(
//                 appLanguage().i_agree_with_the_terms_and_conditions,
//                 style: Get.textTheme.bodyMedium,
//               ),
//             ),
//           ),
//           20.verticalSpace,
//           Obx(
//             () => CustomButton(
//                 isLoading: controller.regIsLoading.value,
//                 text: appLanguage().signup,
//                 onPressed: () {
//                   if (!fromKey.currentState!.validate()) {
//                     return;
//                   }
//                   if (!controller.isAgree.value) {
//                     errorMessage(
//                         message: appLanguage().terms_and_conditions_msg);
//                     return;
//                   }
//                   controller.requestSignUp(
//                     body: {
//                       "name": nameController.text,
//                       "email": emailController.text,
//                       "password": passwordController.text,
//                       "confirm_password": confirmPasswordController.text
//                     },
//                     callback: () {
//                       nameController.clear();
//                       emailController.clear();
//                       passwordController.clear();
//                       confirmPasswordController.clear();
//                       controller.update();
//                     },
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
