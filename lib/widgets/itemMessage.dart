import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MessageType { Right, Left }
enum MessageBorderType { Top, Center, Bottom, Single }

class ItemMessage extends StatelessWidget {
  final String content;
  final String urlPicture;
  final MessageType messageType;
  final MessageBorderType messageBorderType;

  ItemMessage(this.content, this.messageType, this.messageBorderType, this.urlPicture);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(messageType);
        print(messageBorderType);
      },
      child: messageType == MessageType.Right ? currentMessage() : userChatMessage(),
    );
  }

  Widget userChatMessage() {
    return Container(
        margin: messageBorderType == MessageBorderType.Top
            ? EdgeInsets.only(top: 10, left: 16)
            : EdgeInsets.only(top: 4, left: 16),
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            messageBorderType == MessageBorderType.Bottom ||
                    messageBorderType == MessageBorderType.Single
                ? CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(urlPicture),
                    backgroundColor: Colors.red,
                  )
                : Padding(padding: EdgeInsets.only(left: 28)),
            ConstrainedBox(
              //For message width
              constraints: BoxConstraints(maxWidth: 260),
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: generateBorder(messageBorderType, messageType),
                  color: Colors.white10,
                ),
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget currentMessage() {
    return Container(
      margin: messageBorderType == MessageBorderType.Top
          ? EdgeInsets.only(top: 10, right: 16)
          : EdgeInsets.only(top: 4, right: 16),
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 260),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: generateBorder(messageBorderType, messageType),
            color: Colors.deepPurple,
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius generateBorder(MessageBorderType messageBorderType, MessageType messageType) {
    Radius radius = Radius.circular(16);
    if (messageType == MessageType.Right) {
      switch (messageBorderType) {
        case MessageBorderType.Top:
          return BorderRadius.only(topLeft: radius, topRight: radius, bottomLeft: radius);
        case MessageBorderType.Center:
          return BorderRadius.only(topLeft: radius, bottomLeft: radius);
        case MessageBorderType.Bottom:
          return BorderRadius.only(topLeft: radius, bottomRight: radius, bottomLeft: radius);
        case MessageBorderType.Single:
          return BorderRadius.only(
              topLeft: radius, topRight: radius, bottomRight: radius, bottomLeft: radius);
      }
    } else {
      switch (messageBorderType) {
        case MessageBorderType.Top:
          return BorderRadius.only(topLeft: radius, topRight: radius, bottomRight: radius);
        case MessageBorderType.Center:
          return BorderRadius.only(topRight: radius, bottomRight: radius);
        case MessageBorderType.Bottom:
          return BorderRadius.only(topRight: radius, bottomRight: radius, bottomLeft: radius);
        case MessageBorderType.Single:
          return BorderRadius.only(
              topRight: radius, topLeft: radius, bottomRight: radius, bottomLeft: radius);
      }
    }
    return BorderRadius.only(
        topRight: radius, topLeft: radius, bottomRight: radius, bottomLeft: radius);
  }
}
