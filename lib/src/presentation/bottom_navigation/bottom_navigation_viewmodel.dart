import 'package:chat_app/src/presentation/profile_screen/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../base/base.dart';
import '../chat_screen/chat_screen.dart';

class NavigationViewModel extends BaseViewModel {
  int selectedIndex = 0;

  final screens = [
    const HomeScreen(),
    const ChatScreen(),
  ];

  dynamic init() {}

  NavigationBarTheme bottomNavigate() {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        // indicatorColor: AppColors.SURFACE_PURPLE,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 15,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            // color: AppColors.PRIMARY_PURPLE,
          ),
        ),
      ),
      child: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: Colors.transparent,
        height: 65,
        selectedIndex: selectedIndex,
        onDestinationSelected: (selectedIndex) {
          this.selectedIndex = selectedIndex;
          notifyListeners();
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(CupertinoIcons.chat_bubble, size: 28),
            selectedIcon: Icon(
              CupertinoIcons.chat_bubble_fill,
              // color: AppColors.PRIMARY_PURPLE,
              size: 28,
            ),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.person_crop_circle, size: 28),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
