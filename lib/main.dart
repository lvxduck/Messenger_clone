import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/screens/signup.dart';

import 'TestWidget.dart';
import 'screens/chat.dart';
import 'screens/home.dart';
import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }

//   Widget checkLogin() {
//     FirebaseAuth.instance.authStateChanges().listen((User user) {
//       if (user == null) {
//         print('User is currently signed out!');
//         return Login();
//       } else {
//         print('User is signed in!');
//         return Home();
//       }
//     });
//     //return Home();
//   }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        Get.to(Login());
      } else {
        print('User is signed in!');
        Get.to(Home());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: 200,
        // width: 200,
        color: Colors.red,
      ),
    );
  }
}
