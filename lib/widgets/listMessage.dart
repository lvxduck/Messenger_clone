import 'package:flutter/material.dart';
import 'package:quickmessage/models/message.dart';

import 'itemMessage.dart';

class ListMessage extends StatelessWidget {
  final String currentUserUid;
  final String userChatUid;
  final String userChatUrlPicture;
  final List<Message> messages;

  ListMessage(this.messages, this.currentUserUid, this.userChatUid, this.userChatUrlPicture);

  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    MessageType messageType;
    MessageBorderType messageBorderType;

    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 8),
      child: messages != null
          ? ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                index = messages.length - index - 1;
                if (messages[index].uid == currentUserUid) {
                  messageBorderType = calculateBorderTypeRight(messageType, index);
                  messageType = MessageType.Right;
                  return ItemMessage(
                      messages[index].content, messageType, messageBorderType, userChatUrlPicture);
                } else {
                  messageBorderType = calculateBorderTypeLeft(messageType, index);
                  messageType = MessageType.Left;
                  return ItemMessage(
                      messages[index].content, messageType, messageBorderType, userChatUrlPicture);
                }
              },
            )
          : Container(),
    );
  }

  MessageBorderType calculateBorderTypeRight(MessageType messageType, int index) {
    if (messageType == null || messageType == MessageType.Left) if (index - 1 >= 0 &&
            messages[index - 1].uid == userChatUid ||
        index - 1 < 0)
      return MessageBorderType.Single;
    else
      return MessageBorderType.Bottom;
    else if (messageType == MessageType.Right &&
        index - 1 >= 0 &&
        messages[index - 1].uid == currentUserUid) return MessageBorderType.Center;
    return MessageBorderType.Top;
  }

  MessageBorderType calculateBorderTypeLeft(MessageType messageType, int index) {
    if (messageType == null || messageType == MessageType.Right) if (index - 1 >= 0 &&
            messages[index - 1].uid == currentUserUid ||
        index - 1 < 0)
      return MessageBorderType.Single;
    else
      return MessageBorderType.Bottom;
    else if (messageType == MessageType.Left &&
        index - 1 >= 0 &&
        messages[index - 1].uid == userChatUid) return MessageBorderType.Center;
    return MessageBorderType.Top;
  }
}
