// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:chat_app/src/presentation/app_routers.dart';
import 'package:chat_app/src/presentation/base/base.dart';
import 'package:chat_app/src/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

import '../../configs/configs.dart';
import '../../configs/widget/loading/loading_diaglog.dart';
import '../routers.dart';

class SignUpViewModel extends BaseViewModel {
  final firebase = FirebaseAuth.instance;

  File? selectedImage;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameController = TextEditingController();
  final specialChars = RegExp(r'[;~`!@#\$%^&*(),.?":{}\<>|0-9]');

  bool emailChecker = true;
  bool nameChecker = true;
  bool passwordChecker = true;
  bool confirmPasswordChecker = true;
  // bool imageChecker = true;
  bool enableSignUpChecker = false;

  String? emailErrorMsg;
  String? nameErrorMsg;
  String? passwordErrorMsg;
  String? confirmPasswordErrorMsg;


  dynamic init() {}

  // void onImage() {
  //   if (selectedImage == null) {
  //     imageChecker = false;
  //   } else {
  //     imageChecker = true;
  //   }
  // }

  void onEmail() {
    final emailTextChecker = emailController.text;
    if (emailTextChecker.isEmpty) {
      emailChecker = false;
      emailErrorMsg = 'Please enter your email';
    } else if (emailTextChecker.endsWith('@gmail.com')) {
      emailChecker = true;
      emailErrorMsg = '';
    }
    // else if (emailTextChecker.lastIndexOf(Reg)) {
    //   emailChecker = false;
    //   emailErrorMsg = 'Incorrect email';
    // }
    else {
      emailChecker = false;
      emailErrorMsg = 'Email format: example@gmail.com';
    }
    notifyListeners();
  }

  void onUserName() {
    final nameTextChecker = userNameController.text;
    const nameMinimunLength = 5;
    if (nameTextChecker.isEmpty) {
      nameChecker = false;
      nameErrorMsg = 'Please enter your full name';
    } else if (nameTextChecker.contains(specialChars)) {
      nameChecker = false;
      nameErrorMsg = 'Name cannot contains numbers or special characters';
    } else if (nameTextChecker.length < nameMinimunLength) {
      nameChecker = false;
      nameErrorMsg = 'Name too short';
    } else {
      nameChecker = true;
      nameErrorMsg = '';
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

  void onConfirmPassword() {
    final confirmPasswordTextChecker = confirmPasswordController.text;
    final passwordTextChecker = passwordController.text;
    if (confirmPasswordTextChecker.isNotEmpty &&
        confirmPasswordTextChecker == passwordTextChecker) {
      confirmPasswordChecker = true;
      confirmPasswordErrorMsg = '';
    } else if (confirmPasswordTextChecker != passwordTextChecker) {
      confirmPasswordChecker = false;
      confirmPasswordErrorMsg = "Password didn't match";
    } else if (confirmPasswordTextChecker.isEmpty) {
      confirmPasswordChecker = false;
      confirmPasswordErrorMsg = 'Please confirm your password';
    } else {
      confirmPasswordChecker = false;
      confirmPasswordErrorMsg = 'Invalid password';
    }
    notifyListeners();
  }

  void enableSignUpButton() {
    final emailTextChecker = emailController.text;
    final nameTextChecker = userNameController.text;
    final passwordTextChecker = passwordController.text;
    final confirmPasswordTextChecker = confirmPasswordController.text;
    if (
        emailChecker &&
        nameChecker &&
        passwordChecker &&
        confirmPasswordChecker &&
  
        emailTextChecker.isNotEmpty &&
        nameTextChecker.isNotEmpty &&
        passwordTextChecker.isNotEmpty &&
        confirmPasswordTextChecker.isNotEmpty) {
      enableSignUpChecker = true;
    } else {
      enableSignUpChecker = false;
    }
    notifyListeners();
  }

  void signUpButton() async {
    if (enableSignUpChecker) {
      try {
        LoadingDialog.showLoadingDialog(context);
        final createUser = await firebase.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${createUser.user!.uid}.jpg');
        await storageRef.putFile(selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(createUser.user!.uid)
            .set({
          'username': userNameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'image_url': imageUrl,
        });

        Timer(
          const Duration(seconds: 1),
          () {
            LoadingDialog.hideLoadingDialog(context);
            goToSignInScreen(context);
            signUpSuccess(context);
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

  Future<void> goToSignInScreen(BuildContext context) =>
      AppRouter.goToSignInScreen(context);

  Future<void> goToHomeScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.home);

  dynamic signUpSuccess(_) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Paragraph(
          content: 'Sign up successfully!',
          style: STYLE_LARGE_BOLD,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Paragraph(content: 'Great', style: STYLE_SMALL_BOLD),
          ),
        ],
      ),
    );
  }
}
