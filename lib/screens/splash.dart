import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/utils/myTheme.dart';

import 'home.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  checkUserLogin () async {
    await Future.delayed(Duration(seconds: 1));
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        Get.to(Login());
      } else {
        print('User is signed in!');
        Get.to(Home());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTheme>(
      builder: (myTheme) => Scaffold(
        backgroundColor: myTheme.primaryColor,
        body: Container(
          alignment: AlignmentDirectional.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(padding: EdgeInsets.only(top: 30)),
              Column(
                children: [
                  Text("QuickMessage",
                      style: TextStyle(color: Colors.lightBlue[700], fontSize: 32, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  Text("Auto clear your messages", style: TextStyle(color: myTheme.textColor)),
                ],
              ),
              Column(
                children: [
                  Text("From", style: TextStyle(color: myTheme.textColor, fontSize: 18)),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  Text("XDUCK", style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.only(top: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
