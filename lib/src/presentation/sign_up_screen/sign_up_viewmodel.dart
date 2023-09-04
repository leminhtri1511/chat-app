import 'package:chat_app/src/presentation/base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routers.dart';

class SignUpViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final firebase = FirebaseAuth.instance;
  // var enteredEmail = 'test1@gmail.com';
  // var enteredPassword = '123123123';

  dynamic init() {}

  void signUpbutton() async {
    try {
      final createUser = await firebase.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print(createUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Auth failed.'),
        ),
      );
    }
  }

  Future<void> goToSignInScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.signIn);
}
