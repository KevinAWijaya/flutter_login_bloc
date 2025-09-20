import 'package:flutter/material.dart';

import '../../core/color.dart';
import '../../core/constants/size.dart';
import '../../core/constants/space.dart';
import 'text.dart';

class VButton extends StatelessWidget {
  const VButton({
    super.key,
    required this.text,
    this.textColor = VColor.white,
    this.textSize = textSizeMedium,
    this.icon,
    this.iconColor = VColor.white,
    this.iconSize = 40,
    this.iconMargin = marginSmall,
    this.onTap,
    this.buttonColor = VColor.primary,
    this.borderColor = Colors.transparent,
    this.borderWitdh = 0,
    this.disabled = false,
  });

  final Color buttonColor;

  final String text;
  final Color textColor;
  final double textSize;

  final IconData? icon;
  final Color iconColor;
  final double iconSize;
  final double iconMargin;

  final Color borderColor;
  final double borderWitdh;

  final bool disabled;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginMedium),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWitdh),
          borderRadius: BorderRadius.circular(radiusMedium),
          color: disabled ? VColor.primaryOpacity : buttonColor,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: icon != null,
              child: Container(
                margin: EdgeInsets.only(right: iconMargin),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: iconSize,
                ),
              ),
            ),
            VText(
              text,
              fontSize: textSize,
              isBold: true,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}

class VButtonLoading extends StatelessWidget {
  const VButtonLoading(
    this.title, {
    super.key,
    this.textColor = VColor.white,
    this.textColorDisabled = VColor.grey1,
    this.buttonColor = VColor.primary,
    this.buttonColorDisabled = VColor.primaryOpacity,
    @required this.onPressed,
    this.disabled = false,
    this.textPadding = 24,
    this.borderRadius = 10,
    this.isLoading = false,
  });
  final String title;
  final Color textColor;
  final Color textColorDisabled;
  final Color buttonColor;
  final Color buttonColorDisabled;
  final VoidCallback? onPressed;
  final bool disabled;
  final double textPadding;
  final double borderRadius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(textPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: !disabled ? buttonColor : buttonColorDisabled,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VText(
                  title,
                  isBold: true,
                  color: !disabled ? textColor : textColorDisabled,
                ),
                isLoading
                    ? Row(
                        children: [
                          spaceHorizontalMedium,
                          const SizedBox(
                            height: textSizeLarge,
                            width: textSizeLarge,
                            child: CircularProgressIndicator(
                              strokeWidth: 5,
                              valueColor: AlwaysStoppedAnimation<Color>(VColor.white),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            ),
          )),
    );
  }
}
