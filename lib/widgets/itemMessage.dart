import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MessageType { Right, Left }
enum MessageBorderType { Top, Center, Bottom, Single }

class ItemMessage extends StatelessWidget {
  final String content;
  final MessageType messageType;
  final MessageBorderType messageBorderType;

  ItemMessage(this.content, this.messageType, this.messageBorderType);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print(messageType);
        print(messageBorderType);
      },
      child: Container(
        margin: messageBorderType==MessageBorderType.Top?EdgeInsets.only(top: 10):EdgeInsets.only(top: 6),
        alignment: messageType == MessageType.Right
            ? Alignment.centerRight
            : Alignment.centerLeft,
        // color: Colors.blue,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 260),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: generateBorder(messageBorderType, messageType),
              color: Colors.blue,
            ),
            child: Text(
              content,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius generateBorder(MessageBorderType messageBorderType, MessageType messageType) {
    Radius radius = Radius.circular(16);
    if(messageType==MessageType.Right){
      switch(messageBorderType){
        case MessageBorderType.Top:
          return BorderRadius.only(
              topLeft: radius, topRight: radius, bottomLeft: radius);
        case MessageBorderType.Center:
          return BorderRadius.only(
              topLeft: radius, bottomLeft: radius);
        case MessageBorderType.Bottom:
          return BorderRadius.only(
              topLeft: radius, bottomRight: radius, bottomLeft: radius);
        case MessageBorderType.Single:
          return BorderRadius.only(
              topLeft: radius, topRight: radius, bottomRight: radius, bottomLeft: radius);
      }
    }else{
      switch(messageBorderType){
        case MessageBorderType.Top:
          return BorderRadius.only(
              topLeft: radius, topRight: radius, bottomRight: radius);
        case MessageBorderType.Center:
          return BorderRadius.only(
              topRight: radius, bottomRight: radius);
        case MessageBorderType.Bottom:
          return BorderRadius.only(
              topRight: radius, bottomRight: radius, bottomLeft: radius);
        case MessageBorderType.Single:
          return BorderRadius.only(
              topRight: radius, topLeft: radius, bottomRight: radius, bottomLeft: radius);
      }
    }
  }
}
