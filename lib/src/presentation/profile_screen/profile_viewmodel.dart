// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:chat_app/src/presentation/routers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/configs.dart';
import '../base/base.dart';

class ProfileViewModel extends BaseViewModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? imageUrl;
  String? userName;
  String? userEmail;
  String imgError =
      'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=';

  dynamic init() async {
    //  super.initState();
    loadUserInfor();
    // loadLocalData();
  }

  Future<void> loadUserInfor() async {
    final user = auth.currentUser;

    if (user != null) {
      final userId = user.uid;
      final userData = await firestore.collection('users').doc(userId).get();
      if (userData.exists) {
        imageUrl = userData['image_url'];
        userName = userData['username'];
        userEmail = userData['email'];

        notifyListeners();
      }
    }
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('cachedImageUrl', imageUrl ?? '');
    // prefs.setString('cachedUserName', userName ?? 'User not found');
    // prefs.setString('cachedUserEmail', userEmail ?? '');
  }

  // Future<void> loadLocalData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   imageUrl = prefs.getString('cachedImageUrl') ?? '';
  //   userName = prefs.getString('cachedUserName') ?? 'User not found';
  //   userEmail = prefs.getString('cachedUserEmail') ?? '';
  //   notifyListeners();
  // }

  void logOutButton() {
    logOutDialog(context);
  }

  dynamic logOutDialog(_) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => WarningDialog(
        image: AppImages.icWarning2,
        title: 'Logging out',
        content: 'Are you sure you want to log out?',
        leftButtonName: 'No',
        rightButtonName: 'Yes',
        leftButtonColor: AppColors.BLACK_500,
        rightButtonColor: const [
          AppColors.FIRST_RED,
          AppColors.SECOND_RED
          // AppColors.FIRST_YELLOW,
          // AppColors.SECOND_YELLOW
        ],
        onTapLeft: () => Navigator.pop(context),
        onTapRight: () {
          deletedLocal();
          goToSignInScreen(context);
        },
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
