import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configs/configs.dart';

class LogInIcon extends StatelessWidget {
  const LogInIcon({super.key, this.iconPath});

  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: AppColors.COLOR_WHITE,
        ),
      ),
      child: SvgPicture.asset(iconPath ?? ''),
    );
  }
}
