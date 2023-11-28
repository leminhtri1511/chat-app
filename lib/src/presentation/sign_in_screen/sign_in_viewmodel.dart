// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:chat_app/src/configs/widget/dialog/exit_app_dialog.dart';
import 'package:chat_app/src/configs/widget/loading/loading_diaglog.dart';
import 'package:chat_app/src/presentation/app_routers.dart';
import 'package:chat_app/src/presentation/routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base/base.dart';

class SignInViewModel extends BaseViewModel {
  final firebase = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool emailChecker = true;
  bool passwordChecker = true;
  bool enableLoginChecker = false;

  String? emailErrorMsg;
  String? passwordErrorMsg;

  dynamic init() {}

  void onEmail() {
    final emailTextChecker = emailController.text;
    if (emailTextChecker.isEmpty) {
      emailChecker = false;
      emailErrorMsg = 'Please enter your email';
    } else if (emailTextChecker.endsWith('@gmail.com')) {
      emailChecker = true;
      emailErrorMsg = '';
    }
    // else if (emailTextChecker.indexOf('@gmail.com') > 0) {
    //   emailChecker = false;
    //   emailErrorMsg = 'Incorrect email';
    // }

    else {
      emailChecker = false;
      emailErrorMsg = 'Incorrect email';
    }

    // if (emailChecker.isNotEmpty &&
    //     emailChecker.endsWith('@gmail.com') &&
    //     emailChecker.indexOf('@gmail.com') > 0) {
    //   isEmail = true;
    //   emailErrorMsg = '';
    // } else {
    //   isEmail = false;
    // }
    notifyListeners();
  }

  void onPassword() {
    final passwordTextChecker = passwordController.text;
    if (passwordTextChecker.isNotEmpty) {
      passwordChecker = true;
      passwordErrorMsg = '';
    } else {
      passwordChecker = false;
      passwordErrorMsg = 'Please enter your password';
    }
    notifyListeners();
  }

  void enableLoginButton() {
    final emailTextChecker = emailController.text;
    final passwordTextChecker = passwordController.text;
    if (emailChecker &&
        passwordChecker &&
        emailTextChecker.isNotEmpty &&
        passwordTextChecker.isNotEmpty) {
      enableLoginChecker = true;
    } else {
      enableLoginChecker = false;
    }
    notifyListeners();
  }

  void logInButton() async {
    if (enableLoginChecker) {
      try {
        LoadingDialog.showLoadingDialog(context);

        final userLogIn = await firebase
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
            .then((user) async {
          user.user!.getIdToken().then((idToken) async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('jwt', idToken!);
            print('idToken: ---: $idToken');
          });
          print('login success');
        });
        print(userLogIn);
        Timer(const Duration(seconds: 1), () {
          LoadingDialog.hideLoadingDialog(context);
          AppRouter.goToChatScreen(context);
        });
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
  }

  Future<void> exitWaring() => showDialog(
        context: context,
        builder: (context) => const ExitAppDialog(),
      );
  Future<void> goToHomeScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.navigation);

  Future<void> goToSignUpScreen(BuildContext context) =>
      AppRouter.goToSignUpScreen(context);

  Future<void> goToForgotPasswordScreen(BuildContext context) =>
      AppRouter.goForgotPassScreen(context);
}
