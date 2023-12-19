import 'dart:io';

import 'package:animations/animations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/src/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

String imgError =
    'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=';

// A MessageBubble for showing a single chat message on the ChatScreen.
class MsgBlockWidget extends StatelessWidget {
  // Create a message bubble which is meant to be the first in the sequence.
  const MsgBlockWidget.first({
    super.key,
    this.userImage,
    this.userEmail,
    this.username,
    this.message,
    this.imageMsg,
    this.isMe,
  }) : isFirstInSequence = true;

  // Create a message bubble that continues the sequence.
  const MsgBlockWidget.next({
    super.key,
    required this.message,
    required this.isMe,
    this.imageMsg,
    this.userEmail,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;
  // image = null;

  final String? imageMsg;

  // Whether or not this message bubble is the first in a sequence of messages
  // from the same user.
  // Modifies the message bubble slightly for these different cases - only
  // shows user image for the first message from the same user, and changes
  // the shape of the bubble for messages thereafter.
  final bool isFirstInSequence;

  // Image of the user to be displayed next to the bubble.
  // Not required if the message is not the first in a sequence.
  final String? userImage;

  // Username of the user.
  // Not required if the message is not the first in a sequence.
  final String? username;
  final String? message;
  final String? userEmail;

  // Controls how the MessageBubble will be aligned.
  final bool? isMe;

  bool isURL(String text) {
    // Implement your logic to check if 'text' is a URL
    // For example, you can use a regular expression to check
    // or use a package like 'url_launcher' to handle URL validation.
    // Here's a simple example:
    return text.startsWith('http://') ||
        text.startsWith('https://') ||
        text.endsWith('.com');
  }

  // Function to launch a URL
  void launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void showUserProfile(
    BuildContext context,
    String username,
    String userImage,
    String? userEmail,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              const Paragraph(content: 'User Infor', style: STYLE_LARGE_BOLD),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userImage),
                radius: 40,
              ),
              const SizedBox(height: 16),
              Paragraph(
                content: username,
                style: STYLE_LARGE_BOLD,
              ),
              const SizedBox(height: 16),
              Paragraph(
                content: userEmail ?? '',
                style: STYLE_MEDIUM,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Paragraph(
                content: 'Close',
                style: STYLE_SMALL_BOLD,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (userImage != null)
          Positioned(
            top: 15,
            right: isMe! ? 0 : null,
            child: GestureDetector(
              onTap: () {
                showUserProfile(
                  context,
                  username! ?? '',
                  userImage! ?? '',
                  userEmail ?? '',
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(userImage ?? imgError),
                backgroundColor: theme.colorScheme.primary.withAlpha(180),
                radius: 20,
              ),
            ),
          ),
        Container(
          // Add some margin to the edges of the messages, to allow space for the
          // user's image.
          margin: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            // The side of the chat screen the message should show at.
            mainAxisAlignment:
                isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                    isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // First messages in the sequence provide a visual buffer at
                  // the top.
                  if (isFirstInSequence) const SizedBox(height: 18),
                  if (username != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 13,
                        right: 13,
                      ),
                      child: Paragraph(
                        content: username!,
                        style: STYLE_MEDIUM_BOLD,
                      ),
                    ),
                  if (message != null && isURL(message!))
                    GestureDetector(
                      onTap: () => launchURL(message!),
                      child: Padding(
                        padding: isMe!
                            ? const EdgeInsets.only(right: 15.0, top: 15)
                            : const EdgeInsets.only(left: 15.0, top: 15),
                        child: Text(
                          message!,
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),

                  if (message != null)
                    Container(
                      decoration: BoxDecoration(
                        gradient: isMe!
                            ? const LinearGradient(
                                colors: [
                                  AppColors.PRIMARY_PURPLE,
                                  AppColors.PRIMARY_PURPLE,
                                ],
                              )
                            : const LinearGradient(
                                colors: [
                                  AppColors.BLACK_200,
                                  AppColors.BLACK_200,
                                ],
                              ),
                        borderRadius: BorderRadius.only(
                          topLeft: !isMe! && isFirstInSequence
                              ? Radius.zero
                              : const Radius.circular(12),
                          topRight: isMe! && isFirstInSequence
                              ? Radius.zero
                              : const Radius.circular(12),
                          bottomLeft: const Radius.circular(12),
                          bottomRight: const Radius.circular(12),
                        ),
                      ),
                      constraints: const BoxConstraints(maxWidth: 250),
                      padding: const EdgeInsets.symmetric(
                        vertical: 11,
                        horizontal: 15,
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      ),
                      child: isMe!
                          ? SelectableText(
                              message.toString(),
                              style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.COLOR_WHITE,
                              ),
                            )
                          : SelectableText(
                              message.toString(),
                              style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.BLACK,
                              ),
                            ),
                    ),
                  if (imageMsg != null)
                    Padding(
                      padding: isMe == true
                          ? const EdgeInsets.only(
                              top: 5.0,
                              bottom: 5,
                              right: 10,
                            )
                          : const EdgeInsets.only(
                              top: 5.0,
                              bottom: 5,
                              left: 10,
                            ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: OpenContainer(
                          closedBuilder: (context, action) => Container(
                            height: 350,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.PRIMARY_PURPLE,
                                width: 1.2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                imageMsg.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          openBuilder: (context, action) => Column(
                            children: [
                              AppBar(),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    // height: double.infinity,
                                    // width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: AppColors.PRIMARY_PURPLE,
                                        width: 1.2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        imageMsg.toString(),
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
