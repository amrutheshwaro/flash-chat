import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessageStream extends StatelessWidget {
  final stream;
  final currentUser;

  MessageStream({@required this.stream, @required this.currentUser});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageMap = message.data()! as Map;
            final messageText = messageMap['text'];
            final messageSender = messageMap['sender'];
            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: messageSender == currentUser,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 20.0,
              ),
              children: messageBubbles,
            ),
          );
        });
  }
}
