// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:chat_app/src/configs/widget/loading/loading_diaglog.dart';
import 'package:chat_app/src/presentation/app_routers.dart';
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
      LoadingDialog.showLoadingDialog(context);

      final userLogIn = await firebase.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print(userLogIn);

      LoadingDialog.hideLoadingDialog(context);
    } on FirebaseAuthException catch (e) {
      LoadingDialog.hideLoadingDialog(context);
      if (e.code == 'email-already-in-use') {}
      //
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Auth failed.'),
        ),
      );
    }
  }

  Future<void> goToHomeScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.navigation);

  Future<void> goToSignUpScreen(BuildContext context) =>
      AppRouter.goToSignUpScreen(context);

  Future<void> goToForgotPasswordScreen(BuildContext context) =>
      AppRouter.goForgotPassScreen(context);
}
