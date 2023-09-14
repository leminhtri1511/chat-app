import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../configs/configs.dart';
import '../../configs/language/base_widget_language.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BuildContext? _context;
  BuildContext get context => _context!;

  dynamic setContext(BuildContext value) => _context = value;

  Future<bool> exitApp() async {
    return await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
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
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Paragraph(content: 'No', style: STYLE_SMALL_BOLD),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop,
            child: const Paragraph(content: 'Yes', style: STYLE_SMALL_BOLD),
          ),
        ],
      ),
    );
  }
}
