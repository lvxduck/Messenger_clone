import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickmessage/models/message.dart';
import 'package:quickmessage/widgets/bottomBarChat.dart';
import 'package:quickmessage/widgets/itemMessage.dart';
import 'package:quickmessage/widgets/itemUserChat.dart';
import 'package:quickmessage/widgets/listMessage.dart';
import 'package:quickmessage/widgets/myTextField.dart';

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {

  String currentUserUid = 'duc1234';
  String userChatUid = 'minh1234';
  List<Message> messages;

  @override
  void initState() {
    messages = [
      Message(uid: currentUserUid),
      Message(uid: currentUserUid,content: 'Oke em'),
      Message(uid: currentUserUid),
      Message(uid: currentUserUid,content: 'May nho mat tau day nhe con cho'),
      Message(uid: userChatUid),
      Message(uid: userChatUid),
      Message(uid: userChatUid, content: 'May nho mat tau day nhe con cho. May nho mat tau day nhe con cho. huhuhuhu :V :v'),
      Message(uid: currentUserUid),
      Message(uid: currentUserUid),
      Message(uid: currentUserUid),
      Message(uid: userChatUid),
      Message(uid: currentUserUid),
      Message(uid: currentUserUid,content: 'Oke em'),
      Message(uid: currentUserUid),
      Message(uid: currentUserUid,content: 'May nho mat tau day nhe con cho'),
      Message(uid: userChatUid),
      Message(uid: userChatUid),
      Message(uid: userChatUid, content: 'May nho mat tau day nhe con cho. May nho mat tau day nhe con cho. huhuhuhu :V :v'),
      Message(uid: currentUserUid),
      Message(uid: currentUserUid),
      Message(uid: currentUserUid),
      Message(uid: userChatUid),
      Message(uid: userChatUid, content: 'May nho mat tau day nhe con cho. May nho mat tau day nhe con cho. huhuhuhu :V :v'),
      Message(uid: currentUserUid),
      Message(uid: currentUserUid),
    ];
    super.initState();
  }

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: ListMessage(messages,currentUserUid,userChatUid)),
          BottomBarChat(),
        ],

      ),
    );
  }
}
