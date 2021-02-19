import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/signupcontroller.dart';
import 'package:quickmessage/widgets/fancyCircular.dart';
import 'package:quickmessage/widgets/myLoading.dart';
import 'package:quickmessage/widgets/myTextField.dart';

class SignUp extends StatelessWidget {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 56),
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hi,",style: TextStyle(color: Colors.lightBlue[700], fontSize: 32,fontWeight: FontWeight.bold)),
                  Text("Signup to connect your friends",style: TextStyle(color: Colors.white),),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  myTextField(userNameController, "UserName"),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  myTextField(emailController, "Email"),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  myTextField(passwordController, "Password"),
                  Padding(padding: EdgeInsets.only(top: 32)),
                  myFlatButton(
                    onPressed: () {
                      controller.signUp(userNameController.text, emailController.text, passwordController.text);
                    },
                    content: "CREATE NEW ACCOUNT",
                  ),
                  // RaisedButton(
                  //     child: Text("CREATE NEW ACCOUNT"),
                  //     onPressed: () {
                  //       controller.signUp(userNameController.text, emailController.text, passwordController.text);
                  //     }),
                ],
              ),
              Obx(() => controller.isSignUp.value ? MyLoading() : Container()),
            ],
          ),
        ),
      ),
    );
  }
}
