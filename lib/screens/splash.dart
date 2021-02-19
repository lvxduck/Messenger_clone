import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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
      backgroundColor: Colors.black87,
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding: EdgeInsets.only(top: 30)),
            Column(
              children: [
                Text("QuickMessage", style: TextStyle(color: Colors.lightBlue[700], fontSize: 32, fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.only(top: 8)),
                Text("Auto clear your messages", style: TextStyle(color: Colors.white)),
              ],
            ),
            Column(
              children: [
                Text("From", style: TextStyle(color: Colors.white, fontSize: 18)),
                Padding(padding: EdgeInsets.only(top: 8)),
                Text("XDUCK", style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.only(top: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
