import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// enum MyThemeMode{DarkMode, LightMode}

class MyTheme extends GetxController {
  SharedPreferences prefs;
  ThemeMode theme;

  Color primaryColor;
  Color primaryOverlayColor;
  Color buttonColor;
  Color textColor;
  Color hintTextColor;

  Color textFieldColor;

  // TextStyle
  // Color buttonColor;
  // Color buttonColor;

  _initThemeData(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        break;
      case ThemeMode.light:
        primaryColor = Colors.white;
        buttonColor = Colors.black54;
        textColor = Colors.black;
        hintTextColor = Colors.black38;
        primaryOverlayColor = Colors.white38;
        textFieldColor = Colors.black12;
        break;
      case ThemeMode.dark:
        primaryColor = Colors.black87;
        buttonColor = Colors.white54;
        textColor = Colors.white;
        hintTextColor = Colors.white30;
        primaryOverlayColor = Colors.black38;
        textFieldColor = Colors.white12;
        break;
    }
    update();
  }

  MyTheme() {
    // theme = ThemeMode.DarkMode;
    print("init myTheme");
    init();

    buttonColor = Colors.red;
  }

  void switchTheme() {
    if (theme == ThemeMode.light) {
      theme = ThemeMode.dark;
      prefs.setInt("theme", 1);
    } else {
      prefs.setInt("theme", 0);
      theme = ThemeMode.light;
    }
    print("switch to ${theme.toString()}");
    _initThemeData(theme);
  }


  init() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("theme") == 0 || prefs.getInt("theme") == null) {
      theme = ThemeMode.light;
    } else {
      theme = ThemeMode.dark;
    }
    print("Init theme: " + theme.toString());
    _initThemeData(theme);
  }
}
