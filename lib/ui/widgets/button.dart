import 'package:flutter/material.dart';

import '../../core/color.dart';
import '../../core/constants/size.dart';
import 'text.dart';

/// [VButton] is a reusable custom button with support for:
/// - Text and optional icon
/// - Disabled state
/// - Ripple/overlay effect following Material Design standards
/// - Customizable color, border, and size
///
/// Used to create consistent buttons across the application.
class VButton extends StatelessWidget {
  const VButton({
    super.key,
    required this.text,
    this.textSize = textSizeMedium,
    this.textColor = VColor.onPrimary,
    this.textPadding = marginSmall,
    this.icon,
    this.iconSize = 40,
    this.iconMargin = marginSmall,
    this.iconColor = VColor.onPrimary,
    this.buttonColor = VColor.primary,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.onPressed,
    this.isDisabled = false,
  });

  final String text;
  final Color textColor;
  final double textSize;

  /// Padding around the text inside the button.
  final double textPadding;

  /// Optional icon displayed to the left of the text.
  final IconData? icon;
  final Color iconColor;
  final double iconSize;

  /// Space between the icon and the text.
  final double iconMargin;
  final Color buttonColor;

  final Color borderColor;
  final double borderWidth;

  /// Indicates whether the button is disabled.
  ///
  /// If [true], the button cannot be pressed and appears dimmed.
  final bool isDisabled;

  /// Callback triggered when the button is pressed.
  ///
  /// Ignored if [isDisabled] is true.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDisabled ? VColor.primaryOpacity : buttonColor,
      borderRadius: BorderRadius.circular(radiusMedium),
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(radiusMedium),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return VColor.white.withAlpha(50); // ripple effect
          }
          if (states.contains(WidgetState.hovered)) {
            return VColor.black.withAlpha(20); // hover effect
          }
          return null;
        }),
        child: Container(
          padding: EdgeInsets.all(textPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(right: iconMargin),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: iconSize,
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
      ),
    );
  }
}
