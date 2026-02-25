import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:group_app/app/core/helper/share_helper.dart';
import 'package:group_app/app/core/routes/app_pages.dart';
import 'package:group_app/app/firebase_fcm/fcm_service.dart';
import 'package:group_app/app/firebase_fcm/firebase_options.dart';
import 'package:group_app/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      print('Firebase already initialized');
    }
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  try {
    await FcmService().init();
    print(await FcmService().getFcmToken());
  } catch (e) {
    print('FCM initialization error: $e');
  }

  await ShareHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor App',
      
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('bn'),
      ],
      locale: Locale('bn'),
      
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}