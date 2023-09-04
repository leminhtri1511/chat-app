import 'package:chat_app/src/presentation/base/base.dart';
import 'package:chat_app/src/presentation/routers.dart';
import 'package:flutter/cupertino.dart';

class WelcomeScreenViewModel extends BaseViewModel {
  dynamic init() {}

  Future<void> goToSignInScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.signIn);

  Future<void> goToSignUpScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routers.signUp);
}
