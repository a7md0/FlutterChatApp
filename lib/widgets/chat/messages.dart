import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chat').snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final documents = chatSnapshot.data.documents as List<DocumentSnapshot>;

        return ListView.builder(
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (ctx, idx) => Text(
            documents[idx]['text'],
          ),
        );
      },
    );
  }
}
