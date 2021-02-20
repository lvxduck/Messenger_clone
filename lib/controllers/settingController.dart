import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/homeController.dart';
import 'package:quickmessage/models/user.dart';
import 'package:quickmessage/screens/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SettingController extends GetxController {
  CurrentUser currentUser;
  File image;
  bool isChange = false;
  bool isUpDating = false;

  final _picker = ImagePicker();

  SettingController(currentUser) {
    print('Init SettingController');
    print(currentUser.toString());
    this.currentUser = currentUser;
  }

  void selectImage() {
    print("selectImage");
    _getImage();

    // AppBar appBar = AppBar();
    // appBar.re
  }

  void updateData(String name) async {
    isUpDating = true;
    update();
    print("Updating");
    CollectionReference collectionUser = FirebaseFirestore.instance.collection("users");
    if (name == "") name = currentUser.name;
    if (image != null) {
      print("Updating with image and name");
      File file = File(image.path);
      try {
        await FirebaseStorage.instance.ref('image_profile/${currentUser.uid}.png').putFile(file).then((val) => {
              val.ref.getDownloadURL().then((fileURL) => {
                    collectionUser.doc(FirebaseAuth.instance.currentUser.uid).update({
                      'name': name,
                      'picture': fileURL,
                    }).then((value) => {
                          print("Done updating"),
                          isUpDating = false,
                          update(),
                          currentUser.name = name,
                          currentUser.urlPicture = fileURL,
                          Get.find<HomeController>().currentUser.update((val) {}),
                        })
                  })
            });
      } catch (e) {
        print(e.toString());
      }
    } else {
      print("Updating with name");
      await collectionUser.doc(FirebaseAuth.instance.currentUser.uid).update({
        'name': name,
      }).then((value) => {
            print("Done updating"),
            currentUser.name = name,
            Get.find<HomeController>().currentUser.update((val) {}),
            isUpDating = false,
            update(),
          });
    }
  }

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

  Future _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      print("FILE IMAGE: " + image.path.toString());
      isChange = true;
      update();
    } else {
      print('No image selected.');
    }
  }

// Future<void> uploadFile(String filePath) async {
//   File file = File(filePath);
//
//   try {
//     await firebase_storage.FirebaseStorage.instance
//         .ref('image_profile/${currentUser.uid}.png')
//         .putFile(file);
//   } catch (e) {
//     // e.g, e.code == 'canceled'
//     print(e.toString());
//   }
// }
}
