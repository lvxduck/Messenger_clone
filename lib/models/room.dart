import 'package:flutter/cupertino.dart';
import 'package:quickmessage/models/message.dart';

class Room{
  String id;
  String name;
  String urlPicture;
  String userChatUid;
  List<Message> messages;
  Room({this.id,this.name,this.urlPicture,this.messages, this.userChatUid});

  @override
  String toString() {
    return 'Room{id: $id, name: $name, urlPicture: $urlPicture, userChatUid: $userChatUid}';
  }
}