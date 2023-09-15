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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final firebase = FirebaseAuth.instance;
  File? selectedImage;

  dynamic init() {}

  void uploadImage() {}

  void signUpbutton() async {
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

  Future<void> goToSignInScreen(BuildContext context) =>
      AppRouter.goToSignInScreen(context);

  Future<void> goToHomeScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.home);

  dynamic signUpSuccess(_) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Paragraph(
          content: 'Sign up success fully!',
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
