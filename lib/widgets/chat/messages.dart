import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy(
                'createdAt',
                descending: true,
              )
              .snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final documents = chatSnapshot.data?.docs ?? [];

            return ListView.builder(
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (ctx, idx) => MessageBubble(
                key: ValueKey(documents[idx].id),
                userName: documents[idx]['userName'],
                userAvatar: documents[idx]['userAvatar'],
                message: documents[idx]['text'],
                isMe: documents[idx]['userId'] == (futureSnapshot.data?.uid ?? ''),
              ),
            );
          },
        );
      },
    );
  }
}
