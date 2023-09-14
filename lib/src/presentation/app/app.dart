import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/app/splash.dart';
import 'package:chat_app/src/presentation/bottom_navigation/navigation.dart';
import 'package:chat_app/src/presentation/chat_screen/chat_screen.dart';
import 'package:chat_app/src/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import '../../configs/firebase/analytics_firebase.dart';
import '../../intl/generated/l10n.dart';

import '../routers.dart';

class Constants {
  static const String languageVietName = 'vi';
  static const String countryVN = 'VN';
  static const String languageEnglish = 'en';
  static const String countryEnglish = 'US';
  static const String defaultLanguage = 'defaultLanguage';
}

bool iconBool = false;

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.deepPurple,
  brightness: Brightness.light,
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.deepPurple,
  brightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      // theme: ThemeData(fontFamily: 'Quicksand'),
      // theme: ThemeData().copyWith(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Colors.deepPurple,
      //   ),
      // ),
      builder: (context, widget) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: widget!,
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // supportedLocales: S.delegate.supportedLocales,
      // initialRoute: Routers.getStarted,
      onGenerateRoute: Routers.generateRoute,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authState) {
          if (authState.connectionState == ConnectionState.waiting) {
            return const ThreeBounceLoading();
          }

          if (authState.hasData) {
            return const BottomNavigation();
          }

          return const SignInScreen();
        },
      ),
    );
  }
}
