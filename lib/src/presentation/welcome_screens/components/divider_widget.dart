import 'package:flutter/cupertino.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
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
