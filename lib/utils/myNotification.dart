import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:quickmessage/models/room.dart';
import 'package:quickmessage/screens/chat.dart';

class MyNotification {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings _initializationSettingsAndroid = AndroidInitializationSettings('app_icon2');

  MyNotification() {
    _initNotification();
  }

  Room _room;
  int _index;

  Future _selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
    print('Select Notification');
    Get.to(Chat(), arguments: {'room': _room, 'index': _index});
  }

  void displayNotification(String title, String body, room, index) async {
    _room = room;
    _index = index;
    _initNotification();
    await Future.delayed(Duration(milliseconds: 200));
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            // color: Colors.red,
            priority: Priority.high,
            sound: RawResourceAndroidNotificationSound("notification"),
            showWhen: true);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics,
        payload: 'item x');
  }

  void _initNotification() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(android: _initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: _selectNotification);
  }
}
