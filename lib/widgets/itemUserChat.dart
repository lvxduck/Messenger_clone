import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quickmessage/models/room.dart';
import 'package:intl/intl.dart';

Widget itemUserChat({Room room, onClick,int index}) {
  String name = room.name;
  String urlPicture = room.urlPicture;
  String recentMessage = room.messages.length == 0 ? "" : room.messages[room.messages.length - 1].content;
  String time = room.messages.length == 0
      ? ""
      : DateFormat.jm().format(DateTime.fromMicrosecondsSinceEpoch(room.messages[room.messages.length - 1].time));

  return FlatButton(
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    onPressed: onClick,
    splashColor: Colors.white10,
    child: Container(
      height: 60,
      padding: EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(urlPicture),
            backgroundColor: Colors.white24,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          recentMessage + "   ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color:index<3?Colors.white:Colors.white70),
                        ),
                      ),
                      Text(
                        time + "    ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget itemUserChatForSearch({String name, String urlPicture, bool isConnected, onClick}) {

  return FlatButton(
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    onPressed: onClick,
    splashColor: Colors.white10,
    child: Container(
      height: 50,
      padding: EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(urlPicture),
            backgroundColor: Colors.red,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Flexible(
                    child: Text(
                      isConnected?"Connected":"",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
