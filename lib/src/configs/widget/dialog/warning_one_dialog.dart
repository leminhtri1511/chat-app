import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_space.dart';
import '../../constants/app_styles.dart';
import '../button/app_button.dart';
import '../button/app_outline_button.dart';
import '../text/paragraph.dart';

class WarningOneDialog extends StatelessWidget {
  const WarningOneDialog({
    super.key,
    this.content,
    this.image,
    this.title,
    this.buttonName,
    this.buttonColor,
    this.onTap,
  });
  final String? content;
  final String? title;
  final String? buttonName;
  final String? image;
  final Color? buttonColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dynamic dialogContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        // vertical: 20.0,
        horizontal: 50,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image != null)
                CircleAvatar(
                  backgroundColor: AppColors.COLOR_WHITE,
                  radius: 35,
                  child: Image.asset(
                    image ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              Paragraph(
                content: title,
                textAlign: TextAlign.center,
                style: STYLE_LARGE_BIG.copyWith(fontWeight: FontWeight.w600),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeToPadding.sizeSmall,
                  vertical: SizeToPadding.sizeLarge,
                ),
                child: Paragraph(
                  content: content ?? '',
                  textAlign: TextAlign.center,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (buttonName != null) const SizedBox(height: 10),
              if (buttonName != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: AppOutlineButton(
                    content: buttonName,
                    onTap: onTap,
                    color: buttonColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
