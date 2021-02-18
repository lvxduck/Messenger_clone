import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quickmessage/models/message.dart';
import 'package:quickmessage/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickmessage/screens/profile.dart';

class ChatController extends GetxController{

  Rx<Room> room = Room().obs;
  final uid = FirebaseAuth.instance.currentUser.uid;

  ChatController(Room room){
    print("inti chat room" + room.toString());
    // this.room.update((val) {
    //   val.id = room.id;
    //   val.userChatUid = room.userChatUid;
    //   val.urlPicture = room.urlPicture;
    //   val.name = room.name;
    //   val.messages = room.messages;
    // });
    this.room.value = room;
  }

  pushMessage(String content) async {
    int time = DateTime.now().microsecondsSinceEpoch;
    print(time);
    await FirebaseFirestore.instance.collection("rooms").doc(room.value.id).collection("messages").add({
      "content": content,
      "time": time,
      "uid": uid
    }).then((value) => {
      room.update((val) {
        val.messages.add(Message(content: content, time: time, uid: uid));
      })
    }).catchError((error) => {
      print('Failed to send message'+ error.toString()),
      Get.snackbar("ERROR", "Failed to send message"),
    });
  }

  void openRoomChatProfile(){
    Get.to(Profile(),arguments: room.value);
  }

}