import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/chatController.dart';
import 'package:quickmessage/utils/myTheme.dart';
import 'package:quickmessage/widgets/bottomBarChat.dart';
import 'package:quickmessage/widgets/listMessage.dart';
import 'package:quickmessage/widgets/myLoading.dart';

class Chat extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController(Get.arguments));
    return GetBuilder<MyTheme>(
      builder: (myTheme) => Scaffold(
        appBar: AppBar(
          backgroundColor: myTheme.primaryColor,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          leading: FlatButton(
            child: Icon(
              Icons.arrow_back,
              color: myTheme.textColor,
            ),
            onPressed: () {
              chatController.backToHome();
            },
          ),
          // elevation: 0,
          title: Text(
            chatController.room.value.name,
            style: TextStyle(color: myTheme.textColor),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.call,
                color: myTheme.textColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.video_call,
                color: myTheme.textColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.info,
                color: myTheme.textColor,
              ),
              onPressed: () {
                chatController.openRoomChatProfile();
              },
            ),
          ],
        ),
        backgroundColor: myTheme.primaryColor,
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
                          chatController.room.value.urlPicture,
                          myTheme.theme == ThemeMode.dark),
                ),
              ),
              BottomBarChat(
                onSubmit: (content) {
                  chatController.pushMessage(textEditingController);
                },
                controller: textEditingController,
                isDarkMode: myTheme.theme == ThemeMode.dark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
