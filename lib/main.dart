import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quickmessage/screens/splash.dart';
import 'package:quickmessage/utils/myTheme.dart';

import 'TestWidget.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final MyTheme myTheme = Get.put(MyTheme());

  @override
  Widget build(BuildContext context) {
    ///Init themeData


    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: myTheme.primaryColor,
    //   statusBarIconBrightness: myTheme.theme==ThemeMode.dark?Brightness.light:Brightness.dark,
    //   statusBarBrightness: myTheme.theme==ThemeMode.dark?Brightness.light:Brightness.dark,
    // ));

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        buttonColor: Colors.red,
        primaryColor: Colors.black,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
      // home: TestNotification(),
    );
  }
}

