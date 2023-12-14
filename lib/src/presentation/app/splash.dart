// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/app_routers.dart';
import 'package:chat_app/src/presentation/routers.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  Timer startDelay() => timer = Timer(
        const Duration(seconds: 1),
        // goToLogin,
        welcomeScreen,
      );

  @override
  void initState() {
    super.initState();
    startDelay();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void goToLogin() async {
    final pref = await SharedPreferences.getInstance();
    print('auth_token: ${pref.getString('jwt')}');
    if (pref.getString('jwt') != null) {
      await AppRouter.goToChatScreen(context);
    } else {
      await AppRouter.goToSignInScreen(context);
    }
  }

  void welcomeScreen() async {
    final pref = await SharedPreferences.getInstance();
    print('idToken: --- ${pref.getString('jwt')}');
    if (pref.getString('jwt') != null) {
      await Navigator.pushNamed(context, Routers.navigation);
    } else {
      await Navigator.pushNamed(context, Routers.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_icon.png',
              // fit: BoxFit.cover,
              width: 100,
            ),
            const SizedBox(height: 10),
            Paragraph(
              content: 'C h a t b o x',
              style: STYLE_LARGE_BIG.copyWith(
                fontSize: 30,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      ),
    );
  }
}
