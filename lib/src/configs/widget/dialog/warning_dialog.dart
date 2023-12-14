import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs.dart';
import '../../constants/app_space.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog({
    Key? key,
    this.content,
    this.image,
    this.title,
    this.leftButtonName,
    this.leftButtonColor,
    this.rightButtonColor,
    this.rightButtonName,
    this.onTapLeft,
    this.onTapRight,
  }) : super(key: key);
  final String? content;
  final String? title;
  final String? leftButtonName;
  final String? rightButtonName;
  final String? image;
  final Color? leftButtonColor;
  final List<Color>? rightButtonColor;
  final VoidCallback? onTapLeft;
  final VoidCallback? onTapRight;

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
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image != null)
                CircleAvatar(
                  backgroundColor: AppColors.COLOR_WHITE,
                  radius: 35,
                  child: Image.asset(
                    image ?? '',
                  ),
                ),
              const SizedBox(
                height: 18,
              ),
              Paragraph(
                content: title,
                style: STYLE_BIG.copyWith(fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeToPadding.sizeLarge,
                  vertical: SizeToPadding.sizeLarge,
                ),
                child: Paragraph(
                  textAlign: TextAlign.center,
                  content: content ?? '',
                  style: STYLE_MEDIUM.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 8),
                      child: AppOutlineButton(
                        content: leftButtonName,
                        color: leftButtonColor,
                        onTap: () => onTapLeft!(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25, left: 8),
                      child: AppButton(
                        enableButton: true,
                        content: rightButtonName,
                        buttonColor: rightButtonColor,
                        onTap: () => onTapRight!(),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
