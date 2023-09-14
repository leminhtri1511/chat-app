import 'package:chat_app/src/configs/configs.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../base/base.dart';

import 'sign_in_viewmodel.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInViewModel? _viewModel;
  var isLogin = true;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SignInViewModel>(
      viewModel: SignInViewModel(),
      onViewModelReady: (viewModel) => _viewModel = viewModel!..init(),
      builder: (context, viewModel, child) => buildSignIn(),
    );
  }

  Widget buildSignIn() {
    return SafeArea(
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
                    Lottie.asset(AppImages.smallChatIcon),
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
                buildForgotPassword(),
                buildLogInButton(),
                buildGotoSignUpScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AppFormField(
        textEditingController: _viewModel!.emailController,
        labelText: 'Email address',
        hintText: 'Enter your email',
      ),
    );
  }

  Widget buildPasswordFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AppFormField(
        textEditingController: _viewModel!.passwordController,
        obscureText: true,
        labelText: 'Password',
        hintText: 'Enter password',
      ),
    );
  }

  Widget buildForgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => _viewModel!.goToForgotPasswordScreen(context),
            child: Paragraph(
              content: 'Forgot password?',
              style: STYLE_SMALL_BOLD.copyWith(color: AppColors.PRIMARY_PURPLE),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: AppButton(
        enableButton: true,
        content: 'Log in',
        onTap: () => _viewModel!.logInButton(),
      ),
    );
  }

  Widget buildGotoSignUpScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Paragraph(
            content: "Don't have any account yet?",
            style: STYLE_SMALL_BOLD.copyWith(),
          ),
          TextButton(
            onPressed: () => _viewModel!.goToSignUpScreen(context),
            child: Paragraph(
              content: 'Sign up',
              style: STYLE_SMALL_BOLD.copyWith(color: AppColors.PRIMARY_PURPLE),
            ),
          )
        ],
      ),
    );
  }
}
