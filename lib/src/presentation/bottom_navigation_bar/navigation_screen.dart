import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../base/base.dart';

import 'navigation.dart';

class NavigateScreen extends StatefulWidget {
  const NavigateScreen({super.key});

  @override
  State<NavigateScreen> createState() => _NavigateScreenState();
}

class _NavigateScreenState extends State<NavigateScreen> {
  NavigationViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<NavigationViewModel>(
      viewModel: NavigationViewModel(),
      onViewModelReady: (viewModel) => _viewModel = viewModel!..init(),
      builder: (context, viewModel, child) => buildNavigateScreen(),
    );
  }

  Widget buildNavigateScreen() {
    return SafeArea(
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        // extendBody: true,
        // body: Navigator(
        //   onGenerateRoute: (settings) {
        //     return
        //     MaterialPageRoute(
        //       builder: (context) => _viewModel!.screens[_viewModel!.index],
        //       settings: settings,
        //     );
        //   },
        // ),
        // body: _viewModel!.screens[_viewModel!.selectIndex],
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: AppColors.BLACK_100,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(60),
              topLeft: Radius.circular(60),
            ),
            child: _viewModel!.bottomNavigationBar(),
          ),
        ),
      ),
    );
  }
}
