import 'package:chat_app/src/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FunctionBarWidget extends StatelessWidget {
  const FunctionBarWidget({
    super.key,
    this.svgIcon,
    this.title,
    this.content,
    this.onTap,
  });

  final String? svgIcon;
  final String? title;
  final String? content;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.BLACK_100,
            radius: 27,
            child: SvgPicture.asset(svgIcon ?? ''),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Paragraph(
                content: title ?? '',
                style: STYLE_MEDIUM_BOLD,
              ),
              const SizedBox(height: 3),
              Paragraph(
                content: content ?? '',
                style: STYLE_MEDIUM,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}
