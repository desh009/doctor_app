import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart'; // ✅ GetX import করুন
import 'package:group_app/app/core/helper/share_helper.dart';
import 'package:group_app/app/core/routes/app_pages.dart'; // ✅ AppPages import
import 'package:group_app/l10n/app_localizations.dart';

void main()  async {
WidgetsFlutterBinding.ensureInitialized();

await ShareHelper.init();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // ✅ MaterialApp এর পরিবর্তে GetMaterialApp
      debugShowCheckedModeBanner: false,
      title: 'Doctor App',
      
      // ✅ Localization
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
      
      // ✅ GetX Routing Configuration
      initialRoute: AppPages.INITIAL, // '/splash'
      getPages: AppPages.routes, // আপনার routes list
      
      // ✅ Optional: Custom transition
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 300),
 // home: SplashScreen(), // Remove this line
    );
  }
}