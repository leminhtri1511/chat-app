import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/src/configs/configs.dart';
import 'package:flutter/material.dart';

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
    this.isMe,
  }) : isFirstInSequence = true;

  // Create a amessage bubble that continues the sequence.
  const MsgBlockWidget.next({
    super.key,
    required this.message,
    required this.isMe,
    this.userEmail,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

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

                  // The "speech" box surrounding the message.
                  Container(
                    decoration: BoxDecoration(
                      gradient: isMe!
                          ? const LinearGradient(
                              colors: [
                                  Color.fromARGB(154, 156, 68, 180),
                                  Color.fromARGB(154, 178, 84, 205),
                                ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)
                          : LinearGradient(
                              colors: [
                                theme.colorScheme.primary.withAlpha(50),
                                theme.colorScheme.primary.withAlpha(50),
                              ],
                            ),

                      // color: isMe
                      //     ? AppColors.SECONDARY_PURPLE
                      //     : theme.colorScheme.secondary.withAlpha(200),
                      // Only show the message bubble's "speaking edge" if first in
                      // the chain.
                      // Whether the "speaking edge" is on the left or right depends
                      // on whether or not the message bubble is the current user.
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
                    // Set some reasonable constraints on the width of the
                    // message bubble so it can adjust to the amount of text
                    // it should show.
                    constraints: const BoxConstraints(maxWidth: 250),
                    padding: const EdgeInsets.symmetric(
                      vertical: 11,
                      horizontal: 15,
                    ),
                    // Margin around the bubble.
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Paragraph(
                      content: message,
                      softWrap: true,
                      style: STYLE_MEDIUM.copyWith(
                        height: 1.3,
                        fontWeight: FontWeight.w500,
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
