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
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      GetBuilder<SignUpController>(
                        builder: (_) => ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: _.image == null
                              ? Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/quickmessage-9e7be.appspot.com/o/default_avatars%2Fno_avatar.png?alt=media&token=fce0b40e-da3f-4bc1-8bd8-2549676b1836",
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          )
                              : Image.file(
                            _.image,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          controller.selectAvatarFrGallery();
                        },
                        child: Container(
                          width: 120,
                          margin: EdgeInsets.only(top: 20),
                          height: 30,
                          color: Colors.black38,
                          child: Icon(
                            Icons.photo_camera,
                            color: Colors.white70,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 32)),
                  myTextField(userNameController, "UserName"),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  myTextField(emailController, "Email"),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  myTextField(passwordController, "Password"),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  myFlatButton(
                    onPressed: () {
                      controller.signUp(userNameController.text, emailController.text, passwordController.text);
                    },
                    content: "CREATE NEW ACCOUNT",
                  ),
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
