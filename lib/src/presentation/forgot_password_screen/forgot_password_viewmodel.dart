import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/app_routers.dart';
import 'package:chat_app/src/presentation/base/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  dynamic init() {}

  Future<bool> isEmailRegistered(String email) async {
    try {
      final userRecords =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return userRecords.isNotEmpty;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getResetLink() async {
    final enteredEmail = emailController.text;
    final isRegistered = await isEmailRegistered(enteredEmail);

    if (isRegistered) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: enteredEmail);
      resetSuccessDialog();
      // MailCheckDialog.show(
      //   context,
      // );
    } else {
      resetErrorDialog();
      // await Fluttertoast.showToast(
      //   msg: ResetPasswordLanguage.resetEmailAlert,
      //   fontSize: FONT_SIZE_SMALL,
      //   toastLength: Toast.LENGTH_LONG,
      // );
    }

    notifyListeners();
  }

  dynamic resetSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Paragraph(
          content: 'Reset password',
          style: STYLE_MEDIUM_BOLD,
        ),
        content: const Paragraph(
          content: 'Please check your entered email for reset password link',
          style: STYLE_MEDIUM,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              goToSignInScreen(context);
            },
            child: const Paragraph(
              content: 'Go to sign in',
            ),
          ),
        ],
      ),
    );
  }

  dynamic resetErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Paragraph(
          content: 'Email error!',
          style: STYLE_MEDIUM_BOLD,
        ),
        content: const Paragraph(
          content: 'Please enter your registered email',
          style: STYLE_MEDIUM,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Paragraph(
              content: 'Cancel',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> goToSignInScreen(BuildContext context) =>
      AppRouter.goToSignInScreen(context);
}
