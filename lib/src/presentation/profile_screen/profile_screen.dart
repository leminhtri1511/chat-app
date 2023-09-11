import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/profile_screen/profile.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../base/base.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileViewModel>(
      viewModel: ProfileViewModel(),
      onViewModelReady: (viewModel) => _viewModel = viewModel!..init(),
      builder: (context, viewModel, child) => buildSignIn(),
    );
  }

  Widget buildSignIn() {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Paragraph(
                  content: 'PROFILE',
                  style: STYLE_LARGE_BOLD,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
