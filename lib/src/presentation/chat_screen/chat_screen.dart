import 'package:chat_app/src/configs/configs.dart';

import 'package:chat_app/src/presentation/chat_screen/components/chat_msg_widget.dart';
import 'package:chat_app/src/presentation/chat_screen/components/new_msg_widget.dart';
import 'package:chat_app/src/presentation/chat_screen/chat_screen_viewmodel.dart';

import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../base/base.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ChatScreenViewModel? _viewModel;

  void setUpPushNotification() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    // final token = await fcm.getToken();
    // print('Token: ${token}');
    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();

    setUpPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChatScreenViewModel>(
      viewModel: ChatScreenViewModel(),
      onViewModelReady: (viewModel) => _viewModel = viewModel!..init(),
      builder: (context, viewModel, child) => buildHomeScreen(),
    );
  }

  Widget buildHomeScreen() {
    return Column(
      children: [
        buildAppBar(),
        const Expanded(
          child: ChatMsgWidget(),
        ),
        const NewMsgWidget()
      ],
    );
  }

  Widget buildAppBar() => SafeArea(
        child: AppBar(
          title: Paragraph(
            content: 'Group chat',
            style: STYLE_LARGE_BOLD.copyWith(
              fontSize: 20,
            ),
          ),
          centerTitle: false,
          // actions: [
          //   IconButton(
          //     onPressed: () => FirebaseAuth.instance.signOut(),
          //     icon: const Icon(
          //       Icons.logout_outlined,
          //       color: AppColors.COLOR_WHITE,
          //     ),
          //   ),
          // ],
        ),
      );
}
