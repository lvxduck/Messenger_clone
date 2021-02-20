import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quickmessage/models/room.dart';
import 'package:quickmessage/models/user.dart';

class ProfileController extends GetxController {
  Room room;
  bool isLoading = false;

  ProfileController(this.room);

  void selectImageProfile() {
    print("selectImageProfile");
  }

  void deleteRoom() async {
    print("Delete room");
    isLoading = true;

    ///Delete userChat room
    await FirebaseFirestore.instance
        .collection('users')
        .doc(room.userChatUid)
        .collection('rooms')
        .doc(room.id)
        .delete()
        .catchError((e) => {
              Get.rawSnackbar(
                  title: "Ops", message: "Can't delete this conversation", snackPosition: SnackPosition.TOP),
            });

    ///Delete currentUser room
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('rooms')
        .doc(room.id)
        .delete()
        .catchError((e) => {
              Get.rawSnackbar(
                  title: "Ops", message: "Can't delete this conversation", snackPosition: SnackPosition.TOP),
            });

    ///Delete room in rooms collection
    await FirebaseFirestore.instance.collection('rooms').doc(room.id).delete().catchError((e) => {
          Get.rawSnackbar(title: "Ops", message: "Can't delete this conversation", snackPosition: SnackPosition.TOP),
        });
  }

  void settingTheme() {
    print("settingTheme");
  }

  void settingEmoji() {}

  void viewPhotoAndVideo() {}

  void nickName() {}

  void ignoreMessage() {}
}
