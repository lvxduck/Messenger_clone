import 'package:flutter/cupertino.dart';
import 'package:quickmessage/models/room.dart';

class UserChat {
  String uid;
  String name;
  String urlPicture;

  UserChat({@required this.uid, @required this.name, @required this.urlPicture});
}

class CurrentUser {
  String uid;

  @override
  String toString() {
    return 'CurrentUser{uid: $uid, name: $name, urlPicture: $urlPicture, rooms: $rooms}';
  }

  String name;
  String urlPicture;
  List<Room> rooms;

  CurrentUser({this.uid = "", this.name = "", this.urlPicture});
}
