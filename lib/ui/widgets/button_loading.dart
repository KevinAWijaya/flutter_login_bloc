import 'package:flutter/material.dart';

import '../../core/color.dart';
import '../../core/constants/size.dart';
import 'text.dart';

/// [VButtonLoading] is a reusable custom button with built-in loading state.
///
/// Features:
/// - Displays text and a loading indicator
/// - Disabled state handling
/// - Ripple/overlay effect following Material Design standards
/// - Customizable colors, border radius, and padding
///
/// Typically used for form submissions or async actions where a loading
/// indicator should appear after pressing the button.
class VButtonLoading extends StatelessWidget {
  const VButtonLoading({
    super.key,
    required this.text,
    this.textSize = textSizeMedium,
    this.textColor = VColor.onPrimary,
    this.textColorDisabled = VColor.grey1,
    this.buttonColor = VColor.primary,
    this.buttonColorDisabled = VColor.primaryOpacity,
    this.onPressed,
    this.isDisabled = false,
    this.textPadding = marginSmall,
    this.borderRadius = radiusMedium,
    this.isLoading = false,
  });

  final String text;
  final Color textColor;
  final double textSize;

  /// Text color when disabled.
  final Color textColorDisabled;

  /// Background color when enabled.
  final Color buttonColor;

  /// Background color when disabled.
  final Color buttonColorDisabled;

  /// Callback triggered when the button is pressed.
  ///
  /// Ignored if [isDisabled] is true.
  final VoidCallback? onPressed;

  /// Indicates whether the button is disabled.
  final bool isDisabled;

  /// Padding around the text inside the button.
  final double textPadding;

  /// Border radius for button shape.
  final double borderRadius;

  /// Whether the loading spinner should be shown.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDisabled ? buttonColorDisabled : buttonColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: isDisabled || isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
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
          width: double.infinity,
          padding: EdgeInsets.all(textPadding),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VText(
                text,
                isBold: true,
                color: !isDisabled ? textColor : textColorDisabled,
                fontSize: textSize,
              ),
              if (isLoading)
                Container(
                  margin: const EdgeInsets.only(left: marginMedium),
                  height: textSizeLarge,
                  width: textSizeLarge,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
