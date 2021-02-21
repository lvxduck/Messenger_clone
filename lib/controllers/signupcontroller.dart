import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController {
  var isSignUp = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String defaultAvatar =
      "https://firebasestorage.googleapis.com/v0/b/quickmessage-9e7be.appspot.com/o/default_avatars%2Fno_avatar.png?alt=media&token=fce0b40e-da3f-4bc1-8bd8-2549676b1836";

  File image;

  final _picker = ImagePicker();

  void signUp(String name, String email, String password) async {
    if (name == "") {
      Get.rawSnackbar(title: "Ops", message: "Please enter your name", snackPosition: SnackPosition.TOP);
      return;
    }

    /// Create new account
    isSignUp.value = true;

    try {
      ///Create with firebaseAuth
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      if (image != null) {
        /// Push user Avatar to fireStorage
        try {
          await FirebaseStorage.instance
              .ref('image_profile/${userCredential.user.uid}.png')
              .putFile(image)
              .then((val) => {
                    val.ref.getDownloadURL().then((fileURL) => {
                          /// Store userData in fireStore
                          fireStore
                              .collection("users")
                              .doc(userCredential.user.uid)
                              .set({'name': name, 'picture': fileURL})
                        })
                  });
        } catch (e) {
          print(e.toString());
        }
      } else {
        /// Use an exit default avatar
        await fireStore
            .collection("users")
            .doc(userCredential.user.uid)
            .set({'name': name, 'picture': defaultAvatar});
      }
    } on FirebaseAuthException catch (e) {
      isSignUp.value = false;
      if (e.code == 'weak-password') {
        Get.rawSnackbar(title: "Ops", message: "The password provided is too weak", snackPosition: SnackPosition.TOP);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.rawSnackbar(
            title: "Ops", message: "The account already exists for that email", snackPosition: SnackPosition.TOP);
        print('The account already exists for that email.');
      } else {
        Get.rawSnackbar(title: "Ops", message: e.message, snackPosition: SnackPosition.TOP);
        print("Ops" + e.message);
      }
    } catch (e) {
      isSignUp.value = false;
      print(e);
    }
  }

  void selectAvatarFrGallery() {
    _getImage();
  }

  Future _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      print("FILE IMAGE: " + image.path.toString());
      update();
    } else {
      print('No image selected.');
    }
  }
}
