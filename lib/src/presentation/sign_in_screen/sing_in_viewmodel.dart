import 'package:chat_app/src/presentation/routers.dart';
import 'package:flutter/cupertino.dart';

import '../base/base.dart';

class SignInViewModel extends BaseViewModel {
  dynamic init() {}

  Future<void> goToSignUpScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.signUp);

  Future<void> goToForgotPasswordScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.forgotPass);
}
