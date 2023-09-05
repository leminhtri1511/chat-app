// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:chat_app/src/presentation/base/base.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routers.dart';

class SignUpViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final firebase = FirebaseAuth.instance;
  File? selectedImage;

  dynamic init() {}

  void uploadImage() {}

  void signUpbutton() async {
    try {
      final createUser = await firebase.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${createUser.user?.uid}.jpg');
      await storageRef.putFile(selectedImage!);
      final imageUrl = storageRef.getDownloadURL();
      print(imageUrl);
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
