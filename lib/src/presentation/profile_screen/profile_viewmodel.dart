// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:chat_app/src/configs/language/base_widget_language.dart';
import 'package:chat_app/src/presentation/routers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/configs.dart';
import '../base/base.dart';

class ProfileViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? imageUrl;
  String? userName;

  dynamic init() {}

  Future<void> loadUserProfileImage() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userData = await _firestore.collection('users').doc(userId).get();
      if (userData.exists) {
        imageUrl = userData['image_url'];
        userName = userData['userName'];
        notifyListeners();
      }
    }
  }

  void logOutButton() {
    logOutDialog(context);
  }

  Future<void> deletedLocal() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  dynamic logOutDialog(_) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Paragraph(content: 'Log out'),
        content: const Paragraph(content: 'Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
//
  // Future<void> goToHomeScreen(BuildContext context) =>
  //     Navigator.pushNamed(context, Routers.navigation);

  // Future<void> goToSignUpScreen(BuildContext context) =>
  //     Navigator.pushNamed(context, Routers.signUp);

  // Future<void> goToForgotPasswordScreen(BuildContext context) =>
  //     Navigator.pushNamed(context, Routers.forgotPass);
}
