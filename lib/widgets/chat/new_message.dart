import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Send a message...',
              ),
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              onChanged: (value) {
                setState(() => _enteredMessage = value);
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();

    final user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage.trim(),
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': user.displayName,
      'userAvatar': user.photoURL,
    });

    _controller.clear();
  }
}
