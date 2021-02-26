import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quickmessage/models/room.dart';
import 'package:intl/intl.dart';

Widget itemUserChat({Room room, onClick, int index, bool isDarkMode}) {
  String name = room.name;
  String urlPicture = room.urlPicture;
  String recentMessage = room.messages.length == 0 ? "" : room.messages[room.messages.length - 1].content;
  String time = room.messages.length == 0
      ? ""
      : DateFormat.jm().format(DateTime.fromMicrosecondsSinceEpoch(room.messages[room.messages.length - 1].time));

  return FlatButton(
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    onPressed: onClick,
    splashColor: isDarkMode ? Colors.white10 : Colors.black12,
    child: Container(
      height: 60,
      padding: EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: CachedNetworkImage(
              imageUrl: urlPicture,
              //placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: 60,
              width: 56,
              fit: BoxFit.cover,
            ),
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
                    style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          recentMessage + "   ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: isDarkMode
                              ? TextStyle(color: index < 3 ? Colors.white : Colors.white70)
                              : TextStyle(color: index < 3 ? Colors.black : Colors.black54),
                        ),
                      ),
                      Text(
                        time + "    ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black87),
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

Widget itemUserChatForSearch({String name, String urlPicture, bool isConnected, onClick, isDarkMode}) {
  return FlatButton(
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    onPressed: onClick,
    splashColor: isDarkMode ? Colors.white10 : Colors.black12,
    child: Container(
      height: 50,
      padding: EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // CircleAvatar(
          //   radius: 30,
          //   backgroundImage: NetworkImage(
          //     urlPicture,
          //   ),
          //   backgroundColor: isDarkMode ? Colors.white24 : Colors.black26,
          // ),
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: CachedNetworkImage(
              imageUrl: urlPicture,
            //  placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: 50,
              width: 46,
              fit: BoxFit.cover,
            ),
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
                    style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  Flexible(
                    child: Text(
                      isConnected ? "Connected" : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
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
