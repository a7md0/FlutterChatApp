import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, idx) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This work $idx'),
        ),
      ),
    );
  }
}
