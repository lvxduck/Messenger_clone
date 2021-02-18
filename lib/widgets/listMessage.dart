import 'package:flutter/material.dart';
import 'package:quickmessage/models/message.dart';

import 'itemMessage.dart';

class ListMessage extends StatelessWidget {
  final String currentUserUid;
  final String userChatUid;
  final List<Message> messages;

  ListMessage(this.messages, this.currentUserUid, this.userChatUid);

  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    MessageType messageType;
    MessageBorderType messageBorderType;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: messages != null
          ? ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                index = messages.length - index - 1;
                //   if(index+1 == messages.length){
                //     _scrollController.animateTo(
                //         _scrollController.position.maxScrollExtent,
                //         duration: Duration(milliseconds: 500),
                //         curve: Curves.fastOutSlowIn);
                // }
                if (messages[index].uid == currentUserUid) {
                  messageBorderType =
                      calculateBorderTypeRight(messageType, index);
                  messageType = MessageType.Right;
                  return ItemMessage(
                      messages[index].content, messageType, messageBorderType);
                } else {
                  messageBorderType =
                      calculateBorderTypeLeft(messageType, index);
                  messageType = MessageType.Left;
                  return ItemMessage(
                      messages[index].content, messageType, messageBorderType);
                }
              },
            )
          : Container(),
    );
  }

  MessageBorderType calculateBorderTypeRight(
      MessageType messageType, int index) {
    if (index - 1 >= 0 &&
        messages[index - 1].uid == userChatUid &&
        messages[index + 1].uid == userChatUid) return MessageBorderType.Single;
    if (messageType == null || messageType == MessageType.Left)
      return MessageBorderType.Bottom;
    else if (messageType == MessageType.Right &&
        index - 1 >= 0 &&
        messages[index - 1].uid == currentUserUid)
      return MessageBorderType.Center;
    return MessageBorderType.Top;
  }

  MessageBorderType calculateBorderTypeLeft(
      MessageType messageType, int index) {
    if (index - 1 >= 0 &&
        messages[index - 1].uid == currentUserUid &&
        messages[index + 1].uid == currentUserUid) return MessageBorderType.Single;
    if (messageType == null || messageType == MessageType.Right)
      return MessageBorderType.Bottom;
    else if (messageType == MessageType.Left &&
        index - 1 >= 0 &&
        messages[index - 1].uid == userChatUid) return MessageBorderType.Center;
    return MessageBorderType.Top;
  }
}
