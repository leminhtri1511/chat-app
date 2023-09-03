import 'package:chat_app/src/configs/constants/app_styles.dart';
import 'package:chat_app/src/configs/widget/text/paragraph.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Paragraph(
                content:   'Sign In Screen',
                style: STYLE_MEDIUM_BOLD,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
