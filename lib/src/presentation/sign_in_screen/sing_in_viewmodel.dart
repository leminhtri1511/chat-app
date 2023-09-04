import 'package:chat_app/src/presentation/routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../base/base.dart';

class SignInViewModel extends BaseViewModel {
  final firebase = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  dynamic init() {}

  void logInButton() async {
    try {
      final userLogIn = await firebase.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,

      );
      print(userLogIn);
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

  Future<void> goToSignUpScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.signUp);

  Future<void> goToForgotPasswordScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.forgotPass);
}
