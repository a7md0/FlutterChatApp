import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection(
              '/chats/X9Ym9cELPzbUe0OAwVDX/messages',
            )
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents as List<DocumentSnapshot>;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, idx) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[idx]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection(
            '/chats/X9Ym9cELPzbUe0OAwVDX/messages',
          )
              .add(
            {
              'text': 'New text',
            },
          );
        },
      ),
    );
  }
}
