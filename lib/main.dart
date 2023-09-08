// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:tagxisuperuser/functions/functions.dart';
import 'package:tagxisuperuser/functions/notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:tagxisuperuser/pages/loadingPage/loadingpage.dart';
import 'pages/wallePage/add_money_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  checkInternetConnection();

  initMessaging();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    platform = Theme.of(context).platform;

    return GestureDetector(
        onTap: () {
          //remove keyboard on touching anywhere on the screen.
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: ValueListenableBuilder(
            valueListenable: valueNotifierHome.value,
            builder: (context, value, child) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'product.name',
                  theme: ThemeData(),
                  home: const LoadingPage());
            }));
  }
}
