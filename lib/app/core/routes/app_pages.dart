import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/Intro_screen/intro_screen_1/controller/binder/intro_screen_binder.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/Intro_screen/intro_screen_1/view/intro_screen_view.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/Intro_screen/intro_screen_2/binder/Intro_binder.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/Intro_screen/intro_screen_2/view/intro_2_view.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/Intro_screen/intro_screen_3./binder/intro_screen_3_binder.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/Intro_screen/intro_screen_3./view/intro_screen_3_view.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/binder/splash_binder.dart';
import 'package:group_app/app/core/All_screen/Splash_Screen/view/splash_view.dart';
import 'package:group_app/config/screens/Login_disLoged_file_screen/Login_screen/binder/login_binder.dart';
import 'package:group_app/config/screens/Login_disLoged_file_screen/Login_screen/view/Login_view.dart';
import 'package:group_app/config/screens/Login_disLoged_file_screen/Sign_up_Screen/sign_up_screen_binder.dart';
import 'package:group_app/config/screens/Login_disLoged_file_screen/Sign_up_Screen/sign_up_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => Intro2View(),
      binding: IntroBinder(),
    ),

    GetPage(
      name: _Paths.INTRO2,
      page: () => Intro2View(),
      binding: IntroBinder(),
    ),

    GetPage(
      name: _Paths.INTRO3,
      page: () => IntroScreen3View(),
      binding: IntroScreen3Binder(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpScreenView(),
      binding: SignUpBinding(),

      transition: Transition.rightToLeft, // ✅ এখানে দিন
      transitionDuration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ),

    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreenView(),
      binding: LoginBinding(),
    ),

    // binding: SignUpScreenBinding()),
    // GetPage(
    //   name: _Paths.MAIN_LAYOUT,
    //   page: () => MainLayoutView(),
    //   binding: MainLayoutBinding(),
    // ),
    // GetPage(
    //   name: _Paths.NOTIFICATION,
    //   page: () => const NotificationView(),
    //   binding: NotificationBinding(),
    // ),
    // GetPage(
    //   name: _Paths.HISTORY,
    //   page: () => const HistoryView(),
    //   binding: HistoryBinding(),
    // ),
    // GetPage(
    //   name: _Paths.SETTINGS,
    //   page: () => const SettingsView(),
    //   binding: SettingsBinding(),
    // ),
    // GetPage(
    //   name: _Paths.MY_ACCOUNT,
    //   page: () => const MyAccountView(),
    //   binding: MyAccountBinding(),
    // ),
    // GetPage(
    //   name: _Paths.TRIP_DETAILS,
    //   page: () => const TripDetailsView(),
    //   binding: TripDetailsBinding(),
    // ),
    // GetPage(
    //   name: _Paths.CAR_ASSIGNED,
    //   page: () => const CarAssignedView(),
    //   binding: CarAssignedBinding(),
    // ),
    // GetPage(
    //   name: _Paths.EMAIL_VALIDATION,
    //   page: () => const EmailValidationView(),
    //   binding: EmailValidationBinding(),
    // ),
    // GetPage(
    //   name: _Paths.FORGOT_PASSWORD,
    //   page: () => ForgotPasswordView(),
    //   binding: ForgotPasswordBinding(),
    // ),
    // GetPage(
    //   name: _Paths.CHANGE_PASSWORD,
    //   page: () => ChangePasswordView(),
    //   binding: ChangePasswordBinding(),
    // ),
  ];
}
