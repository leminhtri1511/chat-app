import 'package:chat_app/src/presentation/base/base.dart';
import 'package:flutter/cupertino.dart';

import '../routers.dart';


class SignUpViewModel extends BaseViewModel {
  dynamic init() {}

  Future<void> goToSignInScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.signIn);
}