import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/loginController.dart';
import 'package:quickmessage/widgets/myLoading.dart';
import 'package:quickmessage/widgets/myTextField.dart';

class Login extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final LoginController controller = Get.put(LoginController());

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
                  MyTextField(emailController, "Email"),
                  MyTextField(passwordController, "Password"),
                  RaisedButton(
                      child: Text("LOGIN"),
                      onPressed: () => controller.login(
                          emailController.text, passwordController.text)),
                  RaisedButton(
                    child: Text("SIGNUP"),
                    onPressed: () => controller.signUp(),
                  )
                ],
              ),
              Obx(() => controller.isLogin.value?MyLoading():Container())
            ],
          ),
        ),
      ),
    );
  }
}
