import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/forgot_password_screen/forgot_password_viewmodel.dart';
import 'package:flutter/material.dart';

import '../base/base.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ForgotPasswordViewModel>(
      viewModel: ForgotPasswordViewModel(),
      onViewModelReady: (viewModel) => _viewModel = viewModel!..init(),
      builder: (context, viewModel, child) => buildForgotPassword(),
    );
  }

  Widget buildForgotPassword() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppBar(
              elevation: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Paragraph(
                      content: 'Reset your password',
                      style: STYLE_LARGE_BIG.copyWith(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: AppFormField(
                      labelText: 'Email address',
                      hintText: 'Enter your email',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: AppButton(
                      onTap: () {},
                      enableButton: true,
                      content: 'Reset password',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
