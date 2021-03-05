import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:chat_app/widgets/auth_form.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(isLoading: isLoading, onSubmit: _submitAuthForm),
    );
  }

  Future<void> _submitAuthForm({
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  }) async {
    AuthResult authResult;
    setState(() => isLoading = true);

    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _auth.currentUser().then((user) {
          UserUpdateInfo userUpdateInfo = UserUpdateInfo();
          userUpdateInfo.displayName = userName;

          return user.updateProfile(userUpdateInfo);
        });

        await Firestore.instance.collection('users').document(authResult.user.uid).setData({
          'username': userName,
          'email': email,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(message),
        ),
      );
    } catch (err) {
      print(err);
    } finally {
      setState(() => isLoading = false);
    }
  }
}
