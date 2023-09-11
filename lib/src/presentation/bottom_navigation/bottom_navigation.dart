import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../base/base.dart';

import 'navigation.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  NavigationViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<NavigationViewModel>(
      viewModel: NavigationViewModel(),
      onViewModelReady: (viewModel) => _viewModel = viewModel!..init(),
      builder: (context, viewModel, child) => buildBottomNavigation(),
    );
  }

  Widget buildBottomNavigation() {
    return Scaffold(
      body: _viewModel!.screens[_viewModel!.selectedIndex],
      bottomNavigationBar: _viewModel!.bottomNavigate(),
    );
  }
}
