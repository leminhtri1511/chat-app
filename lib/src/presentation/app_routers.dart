import 'package:chat_app/src/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:chat_app/src/presentation/chat_screen/chat_setting.dart';
import 'package:chat_app/src/presentation/forgot_password_screen/forgot_password.dart';
import 'package:chat_app/src/presentation/sign_in_screen/sign_in.dart';
import 'package:chat_app/src/presentation/sign_up_screen/sign_up.dart';
import 'package:chat_app/src/presentation/welcome_screens/welcome.dart';
import 'package:flutter/cupertino.dart';

class AppRouter {
  static Future<void> goToWelcomeScreen(BuildContext context) => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );

  static Future<void> goToSignUpScreen(BuildContext context) => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const SignUpScreen(),
        ),
      );

  static Future<void> goToSignInScreen(BuildContext context) => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );

  static Future<void> goToChatScreen(BuildContext context) => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const BottomNavigation(),
        ),
      );
  static Future<void> goForgotPassScreen(BuildContext context) =>
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        ),
      );


}
