
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// enum MyThemeMode{DarkMode, LightMode}

class MyTheme extends GetxController {

  SharedPreferences prefs;
  ThemeMode theme ;

 Color buttonColor;
 Color textColor;
 Color hintTextColor;
 // Color buttonColor;
 // Color buttonColor;

  MyTheme(){
    // theme = ThemeMode.DarkMode;
    print("init myTheme");

    buttonColor = Colors.red;
  }

  initThemeData(ThemeMode mode){
    switch(mode){
      case ThemeMode.system:
        break;
      case ThemeMode.light:
        buttonColor = Colors.black87;
        break;
      case ThemeMode.dark:
        break;
    }
    update();
  }



  // init() async {
  //   prefs = await SharedPreferences.getInstance();
  // }
}