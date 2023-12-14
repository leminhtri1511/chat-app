// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chat_app/src/presentation/base/base.dart';
import 'package:chat_app/src/presentation/chat_screen/chat_setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../configs/configs.dart';

class ChatScreenViewModel extends BaseViewModel {
  File? selectedImage;
  final firebase = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  dynamic init() {
    setUpPushNotification();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showNoInternetDialog(context);
    }
  }

  dynamic showNoInternetDialog(_) {
    showDialog(
      context: context,
      builder: (context) => WarningOneDialog(
        imageLottie: AppImages.networkError,
        title: 'Network error',
        content: 'Please check your connection and try again',
        buttonName: 'Cancel',
        onTap: () => Navigator.pop(context),
      ),
    );
  }

  void setUpPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('chat');
  }

  Future<void> showChatSettings() async {
    showModalBottomSheet(
      elevation: 0,
      context: context,
      builder: (context) => const ChatSettings(),
      showDragHandle: true,
      isScrollControlled: false,
      // enableDrag: true
    );
  }

  void deleteAllMessages() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final userEmail = currentUser.email;
      const userEmailAdmin = "leminhtri151102@gmail.com";

      if (userEmail == userEmailAdmin) {
        await FirebaseFirestore.instance
            .collection('chat')
            .get()
            .then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            doc.reference.delete();
          }
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Messages'),
              content: const Text('All messages have been deleted.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Permission Denied'),
              content:
                  const Text('You do not have permission to delete messages.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}
