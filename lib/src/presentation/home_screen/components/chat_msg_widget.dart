import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/home_screen/components/msg_block_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMsgWidget extends StatelessWidget {
  const ChatMsgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, chatSnapshots) {
        final loadedMsg = chatSnapshots.data?.docs;
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: ThreeBounceLoading(),
          );
        }

        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Paragraph(
            content: 'No msg yet!',
            style: STYLE_MEDIUM,
          );
        }
        if (chatSnapshots.hasError) {
          return const Paragraph(
            content: 'Something went wrong...',
            style: STYLE_MEDIUM,
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 10,
            right: 10,
          ),
          reverse: true,
          itemCount: loadedMsg?.length,
          itemBuilder: (context, index) {
            final chatMsg = loadedMsg?[index].data();
            final nextMsg = index + 1 < loadedMsg!.length
                ? loadedMsg[index + 1].data()
                : null;
            final currentMsgUserId = chatMsg?['userId'];
            final nextMsgUserId = nextMsg != null ? nextMsg['userId'] : null;
            final nextUserIsSame = nextMsgUserId == currentMsgUserId;

            if (nextUserIsSame) {
              return MsgBlockWidget.next(
                message: chatMsg?['text'],
                isMe: authUser?.uid == currentMsgUserId,
              );
            } 
            else {
              return MsgBlockWidget.first(
                userImage: chatMsg?['userImage'],
                username: chatMsg?['userName'],
                message: chatMsg?['text'],
                isMe: authUser?.uid == currentMsgUserId,
              );
            }
            // Paragraph(
            //   content: loadedMsg[index].data()['text'],
            //   style: STYLE_MEDIUM_BOLD,
            // );
          },
        );
      },
    );
  }
}
