import 'dart:io';

import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthForm extends StatefulWidget {
  final Future<void> Function({
    required String email,
    required String password,
    required String userName,
    required bool isLogin,
    required BuildContext ctx,
    required File userImage,
  }) onSubmit;
  final bool isLoading;

  const AuthForm({
    Key? key,
    required this.isLoading,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;

  String? _userEmail = "";
  String? _userName = "";
  String? _userPassword = "";
  File? _userImageFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    UserImagePicker(
                      imagePicked: _imagePicked,
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }

                      return null;
                    },
                    onSaved: (value) => _userEmail = value,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 character';
                        }

                        return null;
                      },
                      onSaved: (value) => _userName = value,
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long';
                      }

                      return null;
                    },
                    onSaved: (value) => _userPassword = value,
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      child: Text(_isLogin ? 'Create new account' : 'I already have an account'),
                      onPressed: () {
                        setState(() => _isLogin = !_isLogin);
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _trySubmit() {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    FocusScope.of(context).unfocus(); // Close keyboard (remove focus from any input)

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image first.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState?.save();

      widget.onSubmit(
        email: _userEmail?.trim() ?? '',
        userName: _userName?.trim() ?? '',
        password: _userPassword?.trim() ?? '',
        isLogin: _isLogin,
        ctx: context,
        userImage: _userImageFile!,
      );
    }
  }

  void _imagePicked(File image) {
    _userImageFile = image;
  }
}
