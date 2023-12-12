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
  String? userEmail;
  String imgError =
      'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=';

  dynamic init() {
    //  super.initState();
    loadUserProfileImage();
  }

  Future<void> loadUserProfileImage() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userData = await _firestore.collection('users').doc(userId).get();
      if (userData.exists) {
        imageUrl = userData['image_url'];
        userName = userData['username'];
        userEmail = userData['email'];
        notifyListeners();
      }
    }
  }

  void logOutButton() {
    logOutDialog(context);
  }

  dynamic logOutDialog(_) {
    showDialog(
      context: context,
      builder: (ctx) => WarningDialog(
        image: AppImages.icWarning,
        title: 'Logging out!',
        leftButtonName: 'Yes',
        leftButtonColor: AppColors.COLOR_YELLOW,
        onTapLeft: () {
          deletedLocal();
          goToSignInScreen(context);
        },
        rightButtonName: 'No',
        onTapRight: () => Navigator.pop(context),
      ),
    );
  }

  Future<void> deletedLocal() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  // Future<void> goToHomeScreen(BuildContext context) =>
  //     Navigator.pushNamed(context, Routers.navigation);

  Future<void> goToSignInScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.signIn);

  // Future<void> goToForgotPasswordScreen(BuildContext context) =>
  //     Navigator.pushNamed(context, Routers.forgotPass);
}
