import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/loginController.dart';
import 'package:quickmessage/utils/myTheme.dart';
import 'package:quickmessage/widgets/myLoading.dart';
import 'package:quickmessage/widgets/myTextField.dart';

class Login extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTheme>(
      builder: (myTheme) => Scaffold(
        backgroundColor: myTheme.primaryColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 56),
          child: Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 120)),
                        Text("Hi,",
                            style: TextStyle(color: Colors.lightBlue[700], fontSize: 32, fontWeight: FontWeight.bold)),
                        Text("Login to connect your friends", style: TextStyle(color: myTheme.textColor)),
                      ],
                    ),
                    Column(
                      children: [
                        myTextField(emailController, "Email", myTheme.theme==ThemeMode.dark),
                        Padding(padding: EdgeInsets.only(top: 16)),
                        myTextField(passwordController, "Password", myTheme.theme==ThemeMode.dark),
                        Padding(padding: EdgeInsets.only(top: 16)),
                        myFlatButton(
                          onPressed: () => controller.login(emailController.text, passwordController.text),
                          content: "LOGIN",
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, top: 32),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "New user?",
                            style: TextStyle(color: myTheme.textColor, fontSize: 18),
                          ),
                          FlatButton(
                            onPressed: () {
                              controller.signUp();
                            },
                            child: Text(
                              "Signup now",
                              style: TextStyle(color: Colors.lightBlue[700], fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Obx(() => controller.isLogin.value ? MyLoading() : Container())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
