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
      builder: (ctx) => WarningDialog(
        image: AppImages.icPlus,
        title: BaseWidgetLanguage.exitApp,
        content: BaseWidgetLanguage.exitConfirm,
        leftButtonName: BaseWidgetLanguage.cancel,
        onTapLeft: () => Navigator.pop(ctx),
        rightButtonName: BaseWidgetLanguage.confirm,
        onTapRight: SystemNavigator.pop,
      ),
      //  AlertDialog(
      //   title: const Text('Are you sure?'),
      //   content: const Text('Do you want to exit an App'),
      //   actions: <Widget>[
      //     TextButton(
      //       onPressed: () => Navigator.of(ctx).pop(false), //<-- SEE HERE
      //       child: const Text('No'),
      //     ),
      //     const TextButton(
      //       onPressed: SystemNavigator.pop, // <-- SEE HERE
      //       child: Text('Yes'),
      //     ),
      //   ],
      // ),
    );
  }
}
