import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key? key;

  final String? userId;
  final String userName;
  final String userAvatar;
  final String message;
  final bool isMe;

  MessageBubble({
    required this.key,
    this.userId,
    required this.userName,
    required this.userAvatar,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
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
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline6?.color,
                    ),
                  ),
                  Text(
                    message,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline6?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userAvatar,
            ),
          ),
        ),
      ],
    );
  }
}
