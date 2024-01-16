import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/configs/widget/dialog/exit_app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BuildContext? _context;
  BuildContext get context => _context!;

  dynamic setContext(BuildContext value) => _context = value;

  Future<bool> exitApp() async {
    return await showDialog(
        context: context,
        builder: (ctx) => WarningDialog(
              image: AppImages.icWarning,
              imageColor: AppColors.PRIMARY_PURPLE,
              title: 'Exit app!',
              content: 'Do you want to exit this app?',
              leftButtonName: 'Yes',
              onTapLeft: () => SystemNavigator.pop,
              rightButtonName: 'No',
              onTapRight: () => Navigator.pop(context),
            )
        //  ExitAppDialog(),
        );
  }
}
