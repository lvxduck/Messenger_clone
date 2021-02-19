import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickmessage/controllers/settingController.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {

  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Me"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    // backgroundImage: NetworkImage(controller.room.urlPicture),
                    backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlNyI5Bbsl1vq1BQjH9XA-Z4j0Kkk0cEpAnA&usqp=CAU",
                    ),
                  ),
                  Container(
                    width: 120,
                    margin: EdgeInsets.only(top: 20),
                    height: 30,
                    color: Colors.black38,
                    child: Icon(
                      Icons.photo_camera,
                      color: Colors.white70,
                    ),
                  )
                ],
              ),
              Container(
                alignment: AlignmentDirectional.center,
                padding: EdgeInsets.only(right: 32),
                height: 90,
                width: 260,
                // color: Colors.red,
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
                  // cursorColor: Colors.,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Le duc",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
                    isDense: true,
                    icon: Icon(Icons.edit, color: Colors.white,),
                  ),
                ),
                // child: Text(
                //   "Hehe boi",
                //   style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
                // ),
              ),
              settingItem(
                  content: "Dark Mode", icon: Icons.brightness_2_sharp, color: Colors.white30, switchVal: true),
              settingItem(content: "Switch Account", icon: Icons.switch_account, color: Colors.purple),
              settingItem(content: "Message Requests", icon: Icons.message, color: Colors.blue),
              settingItem(content: "Log out", icon: Icons.logout, color: Colors.green, onPressed:()=>controller.logOut()),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingItem({String content, @required IconData icon, @required Color color, bool switchVal, onPressed}) {
    return FlatButton(
      padding: EdgeInsets.only(left: 16, right: 8, top: 9, bottom: 9),
      onPressed: onPressed,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (icon != null)
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Icon(Icons.circle, color: color, size: 40),
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          Padding(padding: EdgeInsets.only(left: 14)),
          Expanded(
            child: Text(
              content,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          if (switchVal != null)
            Switch(
              value: true,
              activeColor: Colors.white,
              // activeColor: Colors.blue,
              inactiveThumbColor: Colors.yellow,
              onChanged: (val) {},
            )
        ],
      ),
    );
  }
}
