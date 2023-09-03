import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/screens/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseMethodScreen extends StatelessWidget {
  const ChooseMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppImages.chatLogo,
                        height: 30,
                        color: AppColors.COLOR_WHITE,
                      ),
                      const SizedBox(width: 10),
                      Paragraph(
                        content: 'Chatbox',
                        style: STYLE_LARGE_BOLD.copyWith(
                            color: AppColors.COLOR_WHITE),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Paragraph(
                    content: 'Connect friends easily & quickly',
                    style: TextStyle(
                        color: AppColors.COLOR_WHITE,
                        fontFamily: 'Quicksand',
                        fontSize: 70,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  Paragraph(
                    content:
                        'Our chat app is the perfect way to stay connected with friends and family.',
                    style:
                        STYLE_SMALL_BOLD.copyWith(color: AppColors.COLOR_WHITE),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => AppRouter.goToSignUpScreen(context),
                      child: const Paragraph(
                        content: 'Sign up with email',
                        style: STYLE_LARGE_BOLD,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Paragraph(
                        content: 'Alread have an account?',
                        style: STYLE_SMALL_BOLD.copyWith(
                            color: AppColors.BLACK_300),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                          onTap: () => AppRouter.goToSignInScreen(context),
                          child: Paragraph(
                            content: 'Log in',
                            style: STYLE_SMALL_BOLD.copyWith(
                                color: AppColors.COLOR_WHITE),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
