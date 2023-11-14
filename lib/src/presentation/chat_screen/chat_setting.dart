import 'dart:async';

import 'package:chat_app/src/configs/configs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ChatSettings extends StatefulWidget {
  const ChatSettings({super.key});

  @override
  State<ChatSettings> createState() => _ChatSettingsState();
}

class _ChatSettingsState extends State<ChatSettings> {
  String imgError =
      'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=';
  int groupMembers = 0;
  String? imageUrl;
  String? userName;
  String? userEmail;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    fetchUserCount();
  }

  Future<void> fetchUserCount() async {
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

    void deleteWarning() {
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
          deleteWarning();
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

    Widget deleteMsgButton() => ElevatedButton.icon(
          onPressed: () => deleteAllMessages(),
          icon: const Icon(Icons.delete),
          label: const Paragraph(
            content: 'Delete chat',
            style: STYLE_SMALL_BOLD,
          ),
        );

    Widget groupMember() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: userCount,
                          itemBuilder: (context, index) {
                            final userData = snapshot.data?.docs[index];
                            final userImageUrl = userData?['image_url'];
                            final userUsername = userData?['username'];

                            return Row(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 90,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                userImageUrl ?? imgError),
                                          ),
                                        ),
                                        Paragraph(
                                          content: userUsername ?? '',
                                          style: STYLE_MEDIUM,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            groupMember(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      deleteMsgButton(),
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
}
