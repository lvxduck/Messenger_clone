import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'file:///C:/Users/OS/AndroidStudioProjects/quickmessage/lib/screens/home.dart';
import 'package:quickmessage/screens/signup.dart';

class LoginController extends GetxController{
  var isLogin = false.obs;

  @override
  onInit(){
    super.onInit();
  }

  void login(String email, String password) async {
    print("LOGIN"+email+password);
    isLogin.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      Get.to(Home());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Hi','No user found for that email');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Hi','Wrong password provided for that user');
        print('Wrong password provided for that user.');
      }else{
        Get.snackbar('Hi'+email,e.toString());
        print('Error'+e.toString());
      }
    }
    isLogin.value = false;
  }

  void signUp(){
    Get.to(SignUp());
  }

}