
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  var isSignUp = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void signUp(String name ,String email, String password) async {
    /// Create new account
    isSignUp.value = true;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      await fireStore.collection("users").doc(userCredential.user.uid).set({
        'name': name,
        'picture': 'http://',
        'rooms': []
      });
      Get.snackbar('HI','SIGNUP SUCCESS');
      Get.back();   //Back to login screen
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('HI','The password provided is too weak');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('HI','The account already exists for that email');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    isSignUp.value = false;

    // ///Testing code
    // print("start");
    // isSignUp.value=true;
    // await Future.delayed(Duration(seconds: 2));
    // print("done");
    // isSignUp.value=false;
    // Get.back(closeOverlays: true);
    // Get.snackbar('HI','SIGNUP SUCCESS');
  }
}