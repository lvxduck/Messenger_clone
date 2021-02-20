import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickmessage/controllers/profileController.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController(Get.arguments));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          PopupMenuButton<String>(
            onSelected: (s) {
              switch (s) {
                case 'Open chat head':
                  {}
                  break;
                case 'Delete Conversation':
                  {
                    controller.deleteRoom();
                  }
                  break;
                default:
                  {
                    print("hMMMM");
                  }
              }
            },
            icon: Icon(Icons.more_vert),
            color: Colors.white,
            itemBuilder: (BuildContext context) {
              return {'Open chat head', 'Delete Conversation'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Container(
          //  padding: EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(controller.room.urlPicture),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 110, left: 110),
                    alignment: AlignmentDirectional.center,
                    child: Icon(
                      Icons.circle,
                      color: Colors.black87,
                      size: 46,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 110, left: 110),
                    alignment: AlignmentDirectional.center,
                    child: Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 32,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: AlignmentDirectional.center,
                height: 90,
                child: Text(
                  controller.room.name,
                  style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
                ),
              ),
              itemProfile(content: "Theme", icon: Icons.color_lens, onPressed: () => controller.settingTheme()),
              itemProfile(content: "Emoji", icon: Icons.emoji_emotions, onPressed: () => controller.settingEmoji()),
              itemProfile(content: "Nicknames"),
              leadText(content: "More Actions"),
              itemProfile(content: "View Photos & Videos", icon: Icons.image),
              itemProfile(content: "Search in Conversation", icon: Icons.search),
              leadText(content: "Privacy"),
              itemProfile(content: "Notification", icon: Icons.search),
              itemProfile(content: "Ignore Messages", icon: Icons.notifications_off),
              itemProfile(content: "Block", icon: Icons.block),
            ],
          ),
        ),
      ),
    );
  }

  Widget leadText({String content}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 21),
      alignment: AlignmentDirectional.centerStart,
      height: 50,
      child: Text(
        content,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }

  Widget itemProfile({String content, IconData icon, onPressed}) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 21),
      onPressed: onPressed,
      splashColor: Colors.white12,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            content,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          if (icon != null)
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Icon(Icons.circle, color: Colors.white24, size: 38),
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          // Icon(
          //   icon,
          //   color: Colors.white,
          //   size: 26,
          // ),
        ],
      ),
    );
  }
}
