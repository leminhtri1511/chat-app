import 'package:chat_app/src/configs/widget/dialog/exit_app_dialog.dart';
import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BuildContext? _context;
  BuildContext get context => _context!;

  dynamic setContext(BuildContext value) => _context = value;

  Future<bool> exitApp() async {
    return await showDialog(
      context: context,
      builder: (ctx) => const ExitAppDialog(),
    );
  }
}
