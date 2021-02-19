import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/screens/login.dart';

class SettingController extends GetxController {
  void logOut() {
    Get.dialog(
      AlertDialog(
        title: Text("LOGOUT"),
        contentPadding: EdgeInsets.only(left: 24, right: 24, top: 16),
        content: Text("Are you sure?"),
        actions: [
          FlatButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "No",
              style: TextStyle(fontSize: 20),
            ),
          ),
          FlatButton(
            onPressed: () {
              // Get.reset();
              // Get.to(Login());
              Get.offAll(Login());
            },
            child: Text(
              "Yes",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
