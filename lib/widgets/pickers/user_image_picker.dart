import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
        ),
        TextButton.icon(
          icon: Icon(Icons.image),
          label: Text('Add Image'),
          onPressed: () {},
        ),
      ],
    );
  }
}
