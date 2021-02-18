import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/signupcontroller.dart';
import 'package:quickmessage/widgets/fancyCircular.dart';
import 'package:quickmessage/widgets/myLoading.dart';
import 'package:quickmessage/widgets/myTextField.dart';

class SignUp extends StatelessWidget  {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextField(userNameController,"UserName"),
                  MyTextField(emailController,"Email"),
                  MyTextField(passwordController,"Password"),
                  RaisedButton(
                      child: Text("CREATE NEW ACCOUNT"), onPressed: () {
                    controller.signUp(userNameController.text ,emailController.text, passwordController.text);
                  }),
                ],
              ),
              Obx(() => controller.isSignUp.value?MyLoading():Container()),
            ],
          ),
        ),
      ),
    );
  }
}
