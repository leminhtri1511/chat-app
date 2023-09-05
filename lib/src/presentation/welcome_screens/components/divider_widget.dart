

import 'package:chat_app/src/configs/configs.dart';
import 'package:flutter/cupertino.dart';

class DiverderWidget extends StatelessWidget {
  const DiverderWidget({
    super.key,
    this.width,
    this.color,
  });

  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: 1,
      color: color,
    );
  }
}
