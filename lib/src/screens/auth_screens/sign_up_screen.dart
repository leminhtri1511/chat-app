import 'package:chat_app/src/configs/configs.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../routers.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                        content: 'Sign Up',
                        style: STYLE_LARGE_BOLD,
                      ),
                      const SizedBox(width: 10),
                      Lottie.asset(AppImages.loadingMessage),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Paragraph(
                    content:
                        'Get chatting with friends and family today by signing up for our chat app!',
                    style: STYLE_SMALL.copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 45),
                  buildEmailFormField(),
                  buildUserNameFormField(),
                  buildPasswordFormField(),
                  buildConfirmPasswordFormField(),
                  buildConfirmButton(),
                  buildGotoSignInScreen(context),
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

  Widget buildUserNameFormField() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: AppFormField(
        labelText: 'User name',
        hintText: 'Enter username',
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

  Widget buildConfirmPasswordFormField() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: AppFormField(
        labelText: 'Confirm password',
        hintText: 'Confirm Your password',
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

  Widget buildGotoSignInScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Paragraph(
            content: 'Alread have an account?',
            style: STYLE_SMALL_BOLD.copyWith(color: AppColors.BLACK_400),
          ),
          const SizedBox(width: 10),
          InkWell(
              onTap: () => AppRouter.goToSignInScreen(context),
              child: Paragraph(
                content: 'Log in',
                style: STYLE_SMALL_BOLD.copyWith(color: AppColors.BLACK_500),
              ))
        ],
      ),
    );
  }
}
