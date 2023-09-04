
import 'package:chat_app/src/presentation/screens/auth_screens/forgot_pasword_screen.dart';
import 'package:chat_app/src/presentation/screens/auth_screens/sign_in_screen.dart';
import 'package:chat_app/src/presentation/screens/auth_screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRouter {
  static Future<void> goToSignInScreen(BuildContext context) => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
      
  static Future<void> goToSignUpScreen(BuildContext context) => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const SignUpScreen(),
        ),
      );

      static Future<void> goToForgotPasswordScreen(BuildContext context) => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        ),
      );
}
