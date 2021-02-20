import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/homeController.dart';
import 'package:quickmessage/models/message.dart';
import 'package:quickmessage/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickmessage/screens/profile.dart';

class ChatController extends GetxController{

  Rx<Room> room = Room().obs;
  final uid = FirebaseAuth.instance.currentUser.uid;

  ChatController(Room room){
    print("inti chat room" + room.toString());
    this.room.value = room;
  }

  void backToHome(){
    Get.find<HomeController>().currentUser.update((val) { });
    Get.back();
  }

  pushMessage(TextEditingController textEdit) async {
    String content = textEdit.text;
    int time = DateTime.now().microsecondsSinceEpoch;
    print(time);
    await FirebaseFirestore.instance.collection("rooms").doc(room.value.id).collection("messages").add({
      "content": content,
      "time": time,
      "uid": uid
    }).then((value) => {
      room.update((val) {
        val.messages.add(Message(content: content, time: time, uid: uid));
      }),
      textEdit.text = "",
    }).catchError((error) => {
      print('Failed to send message'+ error.toString()),
      Get.rawSnackbar(title: "ERROR", message: "Failed to send message", snackPosition: SnackPosition.TOP),
    });
  }

  void openRoomChatProfile(){
    Get.to(Profile(),arguments: room.value);
  }

}