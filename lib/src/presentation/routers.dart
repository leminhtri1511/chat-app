import 'package:chat_app/src/presentation/forgot_password_screen/forgot_pasword_screen.dart';
import 'package:chat_app/src/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:chat_app/src/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

import 'app/splash.dart';
import 'bottom_navigation_bar/navigation_screen.dart';

class Routers {
  static const String getStarted = '/getStarted';
  static const String home = '/home';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgotPass = '/forgotPass';
  
  static const String navigation = '/navigation';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case getStarted:
        return animRoute(
          const SplashScreen(),
          beginOffset: right,
          name: getStarted,
          arguments: arguments,
        );

      case signIn:
        return animRoute(
          const SignInScreen(),
          beginOffset: right,
          name: getStarted,
          arguments: arguments,
        );

      case signUp:
        return animRoute(
          const SignUpScreen(),
          beginOffset: right,
          name: getStarted,
          arguments: arguments,
        );

      case forgotPass:
        return animRoute(
          const ForgotPasswordScreen(),
          beginOffset: right,
          name: getStarted,
          arguments: arguments,
        );

        case navigation:
        return animRoute(
          const NavigateScreen(),
          beginOffset: right,
          name: getStarted,
          arguments: arguments,
        );

      default:
        return animRoute(
          Center(
            child: Text('No route defined for ${settings.name}'),
          ),
          name: '/error',
        );
    }
  }

  static Route animRoute(
    Widget page, {
    required String name,
    Offset? beginOffset,
    Object? arguments,
  }) {
    return PageRouteBuilder(
      settings: RouteSettings(name: name, arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = beginOffset ?? const Offset(0, 0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Offset center = const Offset(0, 0);
  static Offset top = const Offset(0, 1);
  static Offset bottom = const Offset(0, -1);
  static Offset left = const Offset(-1, 0);
  static Offset right = const Offset(1, 0);
}
