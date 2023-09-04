import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/home_screen/home_screen_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../base/base.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel? _viewModel;
  var isLogin = true;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeScreenViewModel>(
      viewModel: HomeScreenViewModel(),
      onViewModelReady: (viewModel) => _viewModel = viewModel!..init(),
      builder: (context, viewModel, child) => buildHomeScreen(),
    );
  }

  Widget buildHomeScreen() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // AppBar(
                //   actions: [
                //     IconButton(
                //       onPressed: () => FirebaseAuth.instance.signOut(),
                //       icon: const Icon(
                //         Icons.logout_outlined,
                //       ),
                //     ),
                //   ],
                // ),
                Paragraph(
                  content: 'HOME SCREEN',
                  style: STYLE_LARGE_BOLD.copyWith(fontSize: 40),
                ),
                const SizedBox(
                  height: 70,
                ),
                AppButton(
                  content: 'Log out',
                  enableButton: true,
                  onTap: () => FirebaseAuth.instance.signOut(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
