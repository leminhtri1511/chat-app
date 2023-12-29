// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:chat_app/src/configs/widget/loading/loading_dialog.dart';
import 'package:chat_app/src/presentation/routers.dart';
import 'package:chat_app/src/resources/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/configs.dart';
import '../base/base.dart';

class SignInViewModel extends BaseViewModel {
  final firebase = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool emailChecker = true;
  bool passwordChecker = true;
  bool enableSignInChecker = false;

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
    } else if (emailTextChecker.indexOf('@gmail.com') > 0) {
      emailChecker = false;
      emailErrorMsg = 'Incorrect email';
    } else {
      emailChecker = false;
      emailErrorMsg = 'Incorrect email';
    }
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
      enableSignInChecker = true;
    } else {
      enableSignInChecker = false;
    }
    notifyListeners();
  }

  Future<void> logInButton() async {
    if (enableSignInChecker) {
      try {
        // LoadingDialog.showLoadingDialog(context);

        // Authentication().signIn(
        //   emailController.text,
        //   passwordController.text,
        // );

        // Timer(
        //   const Duration(seconds: 1),
        //   () {
        //     LoadingDialog.hideLoadingDialog(context);
        //     goToHomeScreen(context);
        //   },
        // );
        LoadingDialog.showLoadingDialog(context);

        final userLogIn = await firebase
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
            .then(
          (user) async {
            user.user!.getIdToken().then((idToken) async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('jwt', idToken!);
              print('idToken: --- $idToken');
            });
            print('login success');
          },
        );

        print(userLogIn);

        Timer(
          const Duration(seconds: 1),
          () {
            LoadingDialog.hideLoadingDialog(context);
            goToHomeScreen(context);
          },
        );
      } on FirebaseAuthException catch (e) {
        LoadingDialog.hideLoadingDialog(context);

        if (e.code == 'email-already-in-use') {}

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Auth failed.'),
          ),
        );
      }
    }
  }

  showNetWorkDialog(_) {
    showDialog(
      context: context,
      builder: (context) => const WarningDialog(),
    );
  }

  Future<void> goToHomeScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.navigation);

  Future<void> goToSignUpScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.signUp);

  Future<void> goToForgotPasswordScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.forgotPass);
}
