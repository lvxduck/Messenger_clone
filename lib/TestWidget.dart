import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/utils/myTheme.dart';

class TestNotification extends StatelessWidget {
  // final MyTheme myTheme = Get.find<MyTheme>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MyTheme>(
        builder: (_) => Container(
          alignment: AlignmentDirectional.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("NOTIFICATION"),
              FlatButton(
                onPressed: () {
                  print("press");
                  _.initThemeData(ThemeMode.dark);
                },
                color: _.buttonColor,
                child: Text("notifi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
