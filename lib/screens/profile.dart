import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickmessage/controllers/profileController.dart';
// import 'package:quickmessage/widgets/itemProfile.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileController controller =
        Get.put(ProfileController(Get.arguments));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          PopupMenuButton<String>(
            onSelected: (s) {},
            icon: Icon(Icons.more_vert),
            color: Colors.white,
            itemBuilder: (BuildContext context) {
              return {'Open chat head', 'Delete Conversation'}
                  .map((String choice) {
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
          padding: EdgeInsets.symmetric(horizontal: 21),
          child: Column(
         //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlNyI5Bbsl1vq1BQjH9XA-Z4j0Kkk0cEpAnA&usqp=CAU",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 110, left: 110),
                    alignment: AlignmentDirectional.center,
                    child: Icon(Icons.circle, color: Colors.black87,size: 46,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 110, left: 110),
                    alignment: AlignmentDirectional.center,
                    child: Icon(Icons.circle, color: Colors.green,size: 32,),
                  ),
                ],
              ),
              Container(
                alignment: AlignmentDirectional.center,
                height: 90,
                child: Text(
                  controller.room.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w500),
                ),
              ),
              itemProfile(
                  content: "Theme",
                  icon: Icons.color_lens,
                  onPressed: () => controller.settingTheme()),
              itemProfile(
                  content: "Emoji",
                  icon: Icons.emoji_emotions,
                  onPressed: () => controller.settingEmoji()),
              itemProfile(content: "Nicknames"),
              Container(
                  alignment: AlignmentDirectional.centerStart,
                  height: 50,
                  child: Text("More Actions",
                      style: TextStyle(color: Colors.white54))),
              itemProfile(content: "View Photos & Videos", icon: Icons.image),
              itemProfile(
                  content: "Search in Conversation", icon: Icons.search),
              Container(
                  alignment: AlignmentDirectional.centerStart,
                  height: 50,
                  child:
                      Text("Privacy", style: TextStyle(color: Colors.white54))),
              itemProfile(content: "Notification", icon: Icons.search),
              itemProfile(
                  content: "Ignore Messages", icon: Icons.notifications_off),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProfile({ String content, IconData icon, onPressed,}){
    return FlatButton(
      padding: EdgeInsets.all(0),
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
          if(icon!=null)Icon(icon, color: Colors.white,size: 26,),
        ],
      ),
    );
  }


}
