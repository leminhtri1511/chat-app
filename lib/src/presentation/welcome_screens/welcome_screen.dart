import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/app_routers.dart';
import 'package:chat_app/src/presentation/welcome_screens/components/divider_widget.dart';
import 'package:chat_app/src/presentation/welcome_screens/components/log_in_icon.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../base/base.dart';
import 'welcome_screen_viewmodel.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  WelcomeScreenViewModel? _viewModel;
  var isLogin = true;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<WelcomeScreenViewModel>(
      viewModel: WelcomeScreenViewModel(),
      onViewModelReady: (viewModel) => _viewModel = viewModel!..init(),
      builder: (context, viewModel, child) => buildWelcome(),
    );
  }

  Widget buildWelcome() {
    return Center(
      child: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
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
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 5),
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
                            style: STYLE_SMALL_BOLD.copyWith(
                                color: AppColors.COLOR_WHITE),
                          ),
                          // const SizedBox(height: 20),
                          const SizedBox(height: 30),
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LogInIcon(
                                iconPath: AppImages.fbIcon,
                              ),
                              SizedBox(width: 30),
                              LogInIcon(
                                iconPath: AppImages.ggIcon,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const DividerWidget(
                                  width: 160,
                                  color: Color.fromARGB(255, 95, 117, 140),
                                ),
                                Paragraph(
                                  content: 'OR',
                                  style: STYLE_LARGE.copyWith(
                                      color: AppColors.COLOR_WHITE),
                                ),
                                const DividerWidget(
                                  color: AppColors.BLACK_400,
                                  width: 160,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () =>
                                  AppRouter.goToSignUpScreen(context),
                              child: const Paragraph(
                                content: 'Sign up with email',
                                style: STYLE_LARGE_BOLD,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Paragraph(
                                  content: 'Already have an account?',
                                  style: STYLE_SMALL_BOLD.copyWith(
                                      color: AppColors.BLACK_300),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      AppRouter.goToSignInScreen(context),
                                  child: Paragraph(
                                    content: 'Log in',
                                    style: STYLE_SMALL_BOLD.copyWith(
                                        color: AppColors.COLOR_WHITE),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                // SizedBox(
                //   height: 50,
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () => _viewModel!.goToSignInScreen(context),
                //     style: const ButtonStyle(
                //       backgroundColor:
                //           MaterialStatePropertyAll(Colors.transparent),
                //     ),
                //     // onPressed: () => AppRouter.goToWelcomeScreen(context),
                //     child: Paragraph(
                //       content: 'Sign in',
                //       style: STYLE_LARGE_BOLD.copyWith(
                //           color: AppColors.COLOR_WHITE),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
