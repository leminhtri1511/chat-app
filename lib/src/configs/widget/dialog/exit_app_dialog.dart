import 'package:chat_app/src/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitAppDialog extends StatelessWidget {
  const ExitAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Paragraph(
          content: 'Exit app !',
          style: STYLE_MEDIUM_BOLD,
        ),
        content:  Paragraph(
          content: 'Are you sure you want to exit?',
          style: STYLE_MEDIUM.copyWith(fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Paragraph(content: 'No', style: STYLE_SMALL_BOLD),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop,
            child: const Paragraph(content: 'Yes', style: STYLE_SMALL_BOLD),
          ),
        ],
      );
  }
}