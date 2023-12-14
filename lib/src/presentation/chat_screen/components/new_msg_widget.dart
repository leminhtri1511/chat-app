import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/src/configs/app_result/app_result.dart';
import 'package:chat_app/src/configs/configs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class NewMsgWidget extends StatefulWidget {
  const NewMsgWidget({
    super.key,
  });

  @override
  State<NewMsgWidget> createState() => _NewMsgWidgetState();
}

class _NewMsgWidgetState extends State<NewMsgWidget> {
  final msgController = TextEditingController();
  final audioSent = AudioPlayer();

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }

  void submitMsg() async {
    final enteredMsg = msgController.text;
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (enteredMsg.trim().isEmpty) {
      return;
    }
    audioSent.play(
      AssetSource('audios/sent_msg.mp3'),
    );
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMsg,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
      'userEmail': userData.data()!['email'],
    });

    msgController.clear();
// FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 15, right: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: true,
              enableSuggestions: true,
              controller: msgController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(hintText: 'Send a msg...'),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              submitMsg();
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
