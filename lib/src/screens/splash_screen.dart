import 'dart:async';

import 'package:chat_app/src/screens/choose_method_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_screens/sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (BuildContext context) => const ChooseMethodScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/chat-logo.png',
              color: Colors.deepPurple[400],
            ),
            const SizedBox(height: 10),
            const Text(
              'Chatbox',
              style: TextStyle(
                  fontSize: 35,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
