import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/app_routers.dart';

import 'package:chat_app/src/presentation/chat_screen/components/chat_msg_widget.dart';
import 'package:chat_app/src/presentation/chat_screen/components/new_msg_widget.dart';
import 'package:chat_app/src/presentation/chat_screen/chat_screen_viewmodel.dart';
import 'package:chat_app/src/presentation/chat_screen/data/items.dart';
import 'package:chat_app/src/presentation/chat_screen/models/menu_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../base/base.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatScreenViewModel? _viewModel;
  final currentUser = FirebaseAuth.instance.currentUser;

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
      builder: (context, viewModel, child) => buildChatScreen(),
    );
  }

  //MAIN WIDGET
  Widget buildChatScreen() {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          buildAppBar(),
          const Expanded(
            child: ChatMsgWidget(),
          ),
          const NewMsgWidget(),
        ],
      ),
    );
  }

  Widget buildAppBar() {
    final checkAdmin = currentUser?.email;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          // const Spacer(),
          Paragraph(
            content: 'Group chat',
            style: STYLE_LARGE_BOLD.copyWith(
              fontSize: 20,
            ),
          ),
          const Spacer(),
          if (checkAdmin == 'leminhtri151102@gmail.com')
            IconButton(
              onPressed: () => _viewModel!.showChatSettings(),
              icon: const Icon(Icons.menu),
            )
        ],
        // actions: [
        //
        // ],
      ),
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
        child: Row(
          children: [
            Icon(
              item.icon,
            ),
            Paragraph(
              content: item.text.toString(),
              style: STYLE_SMALL_BOLD,
            ),
          ],
        ),
      );
}
