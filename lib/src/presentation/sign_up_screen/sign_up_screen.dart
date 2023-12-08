import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/configs/widget/pick_image/pick_image.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../base/base.dart';
import 'sign_up_viewmodel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpViewModel? _viewModel;
  var isLogin = true;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SignUpViewModel>(
      viewModel: SignUpViewModel(),
      onViewModelReady: (viewModel) => _viewModel = viewModel!..init(),
      builder: (context, viewModel, child) => buildSignUp(),
    );
  }

  Widget buildSignUp() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Paragraph(
                      content: 'Sign Up',
                      style: STYLE_LARGE_BOLD,
                    ),
                    const SizedBox(width: 10),
                    Lottie.asset(AppImages.smallChatIcon),
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
                buildPickImage(),
                buildEmailFormField(),
                buildUserNameFormField(),
                buildPasswordFormField(),
                buildConfirmPasswordFormField(),
                buildSignUpButton(),
                buildGotoSignUpScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPickImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: PickImage(
        onPickImage: (pickedImage) {
          _viewModel!.selectedImage = pickedImage;
        },
        // onChanged: (value) {
        //   _viewModel!
        //     ..onImage()
        //     ..enableSignUpButton();
        // },
      ),
    );
  }

  Widget buildEmailFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AppFormField(
        textEditingController: _viewModel!.emailController,
        validator: _viewModel!.emailErrorMsg,
        keyboardType: TextInputType.emailAddress,
        labelText: 'Email address',
        hintText: 'Enter your email',
        onChanged: (value) {
          _viewModel!
            ..onEmail()
            ..enableSignUpButton();
        },
      ),
    );
  }

  Widget buildUserNameFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AppFormField(
        maxLenght: 50,

        textEditingController: _viewModel!.userNameController,
        validator: _viewModel!.nameErrorMsg,
        labelText: 'User name',
        hintText: 'Enter username',
        onChanged: (value) {
          _viewModel!
            ..onUserName()
            ..enableSignUpButton();
        },
      ),
    );
  }

  Widget buildPasswordFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AppFormField(
        textEditingController: _viewModel!.passwordController,
        validator: _viewModel!.passwordErrorMsg,
        labelText: 'Password',
        hintText: 'Enter password',
        obscureText: true,
        onChanged: (value) {
          _viewModel!
            ..onPassword()
            ..enableSignUpButton();
        },
      ),
    );
  }

  Widget buildConfirmPasswordFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AppFormField(
        textEditingController: _viewModel!.confirmPasswordController,
        validator: _viewModel!.confirmPasswordErrorMsg,
        labelText: 'Confirm password',
        hintText: 'Confirm Your password',
        obscureText: true,
        onChanged: (value) {
          _viewModel!
            ..onConfirmPassword()
            ..enableSignUpButton();
        },
      ),
    );
  }

  Widget buildSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: AppButton(
        enableButton: _viewModel!.enableSignUpChecker,
        content: 'Sign up',
        onTap: () => _viewModel!.signUpButton(),
      ),
    );
  }

  Widget buildGotoSignUpScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Paragraph(
            content: 'Already have an account?',
            style: STYLE_SMALL_BOLD,
          ),
          TextButton(
            onPressed: () => _viewModel!.goToSignInScreen(context),
            child: Paragraph(
              content: 'Sign in',
              style: STYLE_SMALL_BOLD.copyWith(color: AppColors.PRIMARY_PURPLE),
            ),
          ),
        ],
      ),
    );
  }
}
