import 'dart:async';

import 'package:chat_app/src/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'choose_method_screen.dart';

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/chat-logo.png',
              color: Colors.deepPurple[400],
            ),
            const SizedBox(height: 10),
            Paragraph(
              content: 'Chatbox',
              style: STYLE_LARGE_BIG.copyWith(
                  fontSize: 30, fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
  }
}
