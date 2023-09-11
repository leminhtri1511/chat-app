import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/configs/widget/pick_image/pick_image.dart';
import 'package:chat_app/src/presentation/forgot_password_screen/forgot_password.dart';
import 'package:chat_app/src/presentation/home_screen/components/chat_msg_widget.dart';
import 'package:chat_app/src/presentation/home_screen/components/new_msg_widget.dart';
import 'package:chat_app/src/presentation/home_screen/home_screen_viewmodel.dart';
import 'package:chat_app/src/presentation/routers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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
      child: Column(
        
        children: [
          buildAppBar(),
          // const Spacer(),
          const Expanded(
            child: ChatMsgWidget(),
          ),
          const NewMsgWidget()
        ],
      ),
    );
  }

  Widget buildAppBar() => AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Paragraph(
          content: 'HOME',
          style: STYLE_LARGE_BOLD.copyWith(
              fontSize: 20, color: AppColors.COLOR_WHITE),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(
              Icons.logout_outlined,
              color: AppColors.COLOR_WHITE,
            ),
          ),
        ],
      );
}
