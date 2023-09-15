import 'dart:async';

import 'package:chat_app/src/configs/configs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatSettings extends StatefulWidget {
  const ChatSettings({super.key});

  @override
  State<ChatSettings> createState() => _ChatSettingsState();
}

class _ChatSettingsState extends State<ChatSettings> {
  int groupMembers = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserCount();
  }

  Future<void> _fetchUserCount() async {
    try {
      final QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      final int userCount = usersSnapshot.size;
      setState(() {
        groupMembers = userCount;
      });
    } catch (error) {
      print('Error counting users: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    void successDelete() {
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
    }

    void deleteWaring() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Messages'),
            content:
                const Text('Are you sure you want to delete all messages?'),
            actions: [
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  FirebaseFirestore.instance.collection('chat').get().then(
                    (querySnapshot) {
                      for (var doc in querySnapshot.docs) {
                        doc.reference.delete();
                      }
                    },
                  );
                  Navigator.pop(context);
                  successDelete();
                },
              ),
            ],
          );
        },
      );
    }

    void deleteAllMessages() async {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userEmail = user.email;
        const userEmailAdmin = "leminhtri151102@gmail.com";

        if (userEmail == userEmailAdmin) {
          deleteWaring();
          // Navigator.pop(context);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Paragraph(
              content: 'Advance',
              style: STYLE_LARGE_BOLD,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      membersCount(),
                      ElevatedButton.icon(
                        onPressed: () {
                          deleteAllMessages();
                        },
                        icon: const Icon(Icons.delete),
                        label: const Paragraph(
                          content: 'Delete chat',
                          style: STYLE_SMALL_BOLD,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget membersCount() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final int userCount = snapshot.data?.size ?? 0;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Paragraph(
                      content: 'Group members: ${userCount.toString()}',
                      style: STYLE_MEDIUM_BOLD,
                    )
                  ],
                ),
              );
            }
          },
        ),
  );
}
