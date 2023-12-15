// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:chat_app/src/presentation/app_routers.dart';
import 'package:chat_app/src/presentation/base/base.dart';
import 'package:chat_app/src/resources/authentication.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../configs/widget/loading/loading_dialog.dart';
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
  bool imageChecker = true;
  bool enableSignUpChecker = false;

  String? emailErrorMsg;
  String? nameErrorMsg;
  String? passwordErrorMsg;
  String? confirmPasswordErrorMsg;

  dynamic init() {}

  // void onImage() {
  //   if (selectedImage != null) {
  //     imageChecker = true;
  //   } else {
  //     imageChecker = false;
  //   }
  //   notifyListeners();
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
    const nameMinimumLength = 5;
    if (nameTextChecker.isEmpty) {
      nameChecker = false;
      nameErrorMsg = 'Please enter your full name';
    } else if (nameTextChecker.contains(specialChars)) {
      nameChecker = false;
      nameErrorMsg = 'Name cannot contains numbers or special characters';
    } else if (nameTextChecker.length < nameMinimumLength) {
      nameChecker = false;
      nameErrorMsg = 'Enter more than 5 characters';
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
    if (emailChecker &&
        nameChecker &&
        passwordChecker &&
        confirmPasswordChecker &&
        // imageChecker &&
        // selectedImage != null &&
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
        if (selectedImage == null) {
          imageEmptyDialog(context);
          return;
        }
        LoadingDialog.showLoadingDialog(context);
        await Authentication().signUp(
          emailController.text,
          userNameController.text,
          passwordController.text,
          selectedImage!,
        );

        LoadingDialog.hideLoadingDialog(context);
        goToSignInScreen(context);
        signUpSuccessDialog(context);
      } on FirebaseAuthException catch (e) {
        LoadingDialog.hideLoadingDialog(context);
        signUpFailDialog(e);
      } catch (e) {
        LoadingDialog.hideLoadingDialog(context);
        print(e.toString());
      }
    }
  }

  dynamic imageEmptyDialog(_) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => WarningOneDialog(
        imagePng: AppImages.icWarning,
        title: 'No profile picture',
        content: 'Please choose a profile picture and try again',
        buttonName: 'Cancel',
        buttonColor: AppColors.SECOND_YELLOW,
        onTap: () => Navigator.pop(context),
      ),
    );
  }

  dynamic signUpSuccessDialog(_) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WarningOneDialog(
        imagePng: AppImages.icSuccess,
        title: 'Sign up successfully',
        content: 'Now you can log in to your account',
        buttonName: 'Log in',
        buttonColor: AppColors.COLOR_GREEN,
        onTap: () => Navigator.pop(context),
      ),
    );
  }

  dynamic signUpFailDialog(e) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WarningOneDialog(
        imagePng: AppImages.icFalse,
        title: 'Email registered',
        content: 'Your email has been registered before',
        buttonName: 'Cancel',
        buttonColor: AppColors.FIRST_RED,
        onTap: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Auth failed.'),
            ),
          );
        },
      ),
    );
  }

  Future<void> goToSignInScreen(BuildContext context) =>
      AppRouter.goToSignInScreen(context);
}
