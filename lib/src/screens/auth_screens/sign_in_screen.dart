import 'package:chat_app/src/configs/configs.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../routers.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future<bool> exitApp() async {
    //   return (await showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: const Text('Are you sure?'),
    //           content: const Text('Do you want to exit an App'),
    //           actions: <Widget>[
    //             TextButton(
    //               onPressed: () =>
    //                   Navigator.of(context).pop(false), //<-- SEE HERE
    //               child: const Text('No'),
    //             ),
    //             TextButton(
    //               onPressed: () =>
    //                   Navigator.of(context).pop(true), // <-- SEE HERE
    //               child: const Text('Yes'),
    //             ),
    //           ],
    //         ),
    //       )) ??
    //       false;
    // }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 45),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Paragraph(
                        content: 'Sign In',
                        style: STYLE_LARGE_BOLD,
                      ),
                      const SizedBox(width: 10),
                      Lottie.asset(AppImages.loadingMessage),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Paragraph(
                    content:
                        'Welcome back! Sign in using your social account or email to continue us',
                    style: STYLE_SMALL.copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 45),
                  buildEmailFormField(),
                  buildPasswordFormField(),
                  buildConfirmButton(),
                  buildForgotPassword(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailFormField() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: AppFormField(
        labelText: 'Email address',
        hintText: 'Enter your email',
      ),
    );
  }

  Widget buildPasswordFormField() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: AppFormField(
        labelText: 'Password',
        hintText: 'Enter password',
      ),
    );
  }

  Widget buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: AppButton(
        enableButton: true,
        content: 'Confirm',
        onTap: () {},
      ),
    );
  }

  Widget buildForgotPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => AppRouter.goToForgotPasswordScreen(context),
            child: Paragraph(
              content: 'Forgot your password?',
              style: STYLE_SMALL_BOLD.copyWith(color: AppColors.PRIMARY_PURPLE),
            ),
          ),
        ],
      ),
    );
  }
}
