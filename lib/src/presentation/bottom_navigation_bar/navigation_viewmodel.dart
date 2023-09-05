import 'package:flutter/cupertino.dart';

import '../../configs/configs.dart';
import '../base/base.dart';
import '../home_screen/home_screen.dart';

class NavigationViewModel extends BaseViewModel {
  int selectIndex = 0;
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();

  // final screens = [
  //   const HomeScreen(),
  //   const ServiceListScreen(),
  //   const ServiceListScreen(),
  //   const ServiceListScreen(),
  //   const Center(
  //     child: Paragraph(
  //       content: 'Notification',
  //       style: STYLE_LARGE_BIG,
  //     ),
  //   ),
  //   const Center(
  //     child: Paragraph(
  //       content: 'Profile',
  //       style: STYLE_LARGE_BIG,
  //     ),
  //   )
  // ];

  dynamic init() {}

  CupertinoTabScaffold bottomNavigationBar() {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: false,
      tabBar: CupertinoTabBar(
        activeColor: AppColors.PRIMARY_PURPLE,
        inactiveColor: AppColors.BLACK_300,
        backgroundColor: AppColors.BLACK_100,
        onTap: (index) {
          if (selectIndex == index) {
            switch (index) {
              case 0:
                firstTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
              case 1:
                secondTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
              case 2:
                thirdTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
              case 3:
                fourthTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
            }
          }
          selectIndex = index;
          notifyListeners();
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
            // label: NavigationLanguage.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_favorites_alt, size: 32),
            activeIcon:
                Icon(CupertinoIcons.square_favorites_alt_fill, size: 32),
            // label: NavigationLanguage.service,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bell),
            activeIcon: Icon(CupertinoIcons.bell_fill),
            // label: NavigationLanguage.notification,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_crop_circle, size: 32),
            activeIcon: Icon(CupertinoIcons.person_crop_circle_fill, size: 32),
            // label: NavigationLanguage.profile,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              navigatorKey: firstTabNavKey,
              builder: (context) => const HomeScreen(),
            );
          case 1:
            return CupertinoTabView(
              navigatorKey: secondTabNavKey,
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child: Paragraph(
                      content: 'List Friends',
                      style: STYLE_LARGE_BIG,
                    ),
                  ),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              navigatorKey: thirdTabNavKey,
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child: Paragraph(
                      content: 'Notification',
                      style: STYLE_LARGE_BIG,
                    ),
                  ),
                );
              },
            );
          case 3:
            return CupertinoTabView(
              navigatorKey: fourthTabNavKey,
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Center(
                    child:
                        Paragraph(content: 'Profile', style: STYLE_LARGE_BIG),
                  ),
                );
              },
            );
          default:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: HomeScreen());
              },
            );
        }
      },
    );
  }
}
