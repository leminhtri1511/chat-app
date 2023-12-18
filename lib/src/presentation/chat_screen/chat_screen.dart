
import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/chat_screen/components/chat_msg_widget.dart';
import 'package:chat_app/src/presentation/chat_screen/components/new_msg_widget.dart';
import 'package:chat_app/src/presentation/chat_screen/chat_screen_viewmodel.dart';
import 'package:flutter/material.dart';

import '../base/base.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatScreenViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ChatScreenViewModel>(
      viewModel: ChatScreenViewModel(),
      onViewModelReady: (viewModel) => _viewModel = viewModel!..init(),
      builder: (context, viewModel, child) => buildChatScreen(),
    );
  }

  // MAIN WIDGET
  Widget buildChatScreen() {
    return Column(
      children: [
        buildAppBar(),
        const Expanded(
          child: ChatMsgWidget(),
        ),
        const NewMsgWidget(),
      ],
    );
  }

  Widget buildAppBar() {
    final checkAdmin = _viewModel!.currentUser?.email;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: SafeArea(
        child: Row(
          children: [
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
        ),
      ),
    );
  }

  // PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
  //       child: Row(
  //         children: [
  //           Icon(item.icon),
  //           Paragraph(
  //             content: item.text.toString(),
  //             style: STYLE_SMALL_BOLD,
  //           ),
  //         ],
  //       ),
  //     );
}
