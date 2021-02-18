import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/chatController.dart';
import 'package:quickmessage/controllers/homeController.dart';
import 'package:quickmessage/models/message.dart';
import 'package:quickmessage/models/room.dart';
import 'package:quickmessage/widgets/bottomBarChat.dart';
import 'package:quickmessage/widgets/listMessage.dart';
import 'package:quickmessage/widgets/myLoading.dart';

// class Chat extends StatefulWidget {
//   @override
//   _ChatState createState() => _ChatState();
// }
//
// class _ChatState extends State<Chat> {
class Chat extends StatelessWidget {
  // final Room room = Get.arguments;
  // final ChatController chatController = Get.put(ChatController(Get.arguments));

  @override
  Widget build(BuildContext context) {
    // print("hehehe"+Get.arguments.toString());
    final ChatController chatController =
        Get.put(ChatController(Get.arguments));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("CodeButchers"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.call,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.video_call,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => chatController.room == null
                  ? MyLoading()
                  : ListMessage(
                      chatController.room.value.messages,
                      FirebaseAuth.instance.currentUser.uid,
                      chatController.room.value.userChatUid)),
            ),
            BottomBarChat(
              onSubmit: (content) {
                chatController.pushMessage(content);
              },
            ),
          ],
        ),
      ),
    );
  }
}