import 'package:flutter/material.dart';

import 'package:chat_app/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(onSubmit: _submitAuthForm),
    );
  }

  void _submitAuthForm({
    String email,
    String password,
    String username,
    bool isLogin,
  }) {}
}
