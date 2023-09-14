import 'package:chat_app/src/configs/configs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatSettings extends StatelessWidget {
  const ChatSettings({super.key});

  @override
  Widget build(BuildContext context) {
    void deleteAllMessages() async {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userEmail = user.email;
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
                content: const Text(
                    'You do not have permission to delete messages.'),
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

    return Scaffold(
      body: Column(
        children: [
          const Paragraph(
            content: 'Settings',
            style: STYLE_LARGE_BOLD,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10,
            ),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    deleteAllMessages();
                  },
                  icon: const Icon(Icons.delete),
                  label: const Paragraph(
                    content: 'Delete chat',
                    style: STYLE_SMALL_BOLD,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
