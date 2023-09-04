import 'package:chat_app/src/configs/configs.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 2,
      width: 100,
      color: AppColors.COLOR_WHITE,
    );
  }
}