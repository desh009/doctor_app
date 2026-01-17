// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:group_app/app/core/routes/app_pages.dart';

// import '../../../../main.dart';

// class AuthController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   late TabController tabController;

//   RxBool isAgree = false.obs;
//   AuthRepository authRepository = AuthRepository();
//   RxBool loginIsLoading = false.obs;
//   RxBool regIsLoading = false.obs;
//   RxBool isPageLoading = false.obs;

//   RxBool obscureTextLoginPassword = true.obs;
//   RxBool obscureTextRegPassword = true.obs;
//   RxBool obscureTextRegComPassword = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     tabController = TabController(length: 2, vsync: this);
//     tabController.addListener(() {
//       update();
//     });
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     authRepository.close();
//   }

//   Future requestLogin({required Map<String, String> body,required Function() callback}) async {
//     loginIsLoading(true);
//     await authRepository.requestLogin(body: body).then((value) {
//       loginIsLoading(false);
//       update();
//       if(value != null){
//         callback();
//         LoginResponse loginResponse = value as LoginResponse;
//         if(loginResponse.data?.user?.emailVerified == null || loginResponse.data?.user?.emailVerified == 0){
//           Get.offAllNamed(Routes.EMAIL_VALIDATION);
//         }else{
//           Get.offAllNamed(Routes.MAIN_LAYOUT);
//         }
//       }
//     });

//   }

//   Future<void> requestSignUp({required Map<String, String> body, required Null Function() callback}) async {
//     try{
//       regIsLoading(true);
//       ApiResponse? response = await authRepository.requestSignUp(body: body);
//       regIsLoading(false);
//       update();
//       if(response?.success ?? false){
//         callback();
//         successMessage(message: response?.message ?? "");
//         requestLogin(body: {
//           'email': body['email']!,
//           'password': body['password']!
//         }, callback: (){} );
//       }else{
//         errorMessage(message: response?.message ?? "");
//       }
//     }catch(e){
//       debugPrint(e.toString());
//     }
//   }
// }
