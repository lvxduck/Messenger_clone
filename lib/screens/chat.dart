import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/chatController.dart';
import 'package:quickmessage/widgets/bottomBarChat.dart';
import 'package:quickmessage/widgets/listMessage.dart';
import 'package:quickmessage/widgets/myLoading.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController(Get.arguments));
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
        title: Text(chatController.room.value.name),
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
            onPressed: () {
              chatController.openRoomChatProfile();
            },
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: Container(
        //spadding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => chatController.room == null
                    ? MyLoading()
                    : ListMessage(
                        chatController.room.value.messages,
                        FirebaseAuth.instance.currentUser.uid,
                        chatController.room.value.userChatUid,
                        chatController.room.value.urlPicture),
              ),
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
