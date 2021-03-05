import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key key;

  final String userId;
  final String message;
  final bool isMe;

  MessageBubble({
    this.key,
    this.userId,
    this.message,
    this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(!isMe ? 0 : 12),
              bottomRight: Radius.circular(isMe ? 0 : 12),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: Firestore.instance.collection('users').document(userId).get(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading...');
                  }

                  return Text(
                    userSnapshot.data['username'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline6.color,
                    ),
                  );
                },
              ),
              Text(
                message,
                textAlign: isMe ? TextAlign.end : TextAlign.start,
                style: TextStyle(
                  color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline6.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
