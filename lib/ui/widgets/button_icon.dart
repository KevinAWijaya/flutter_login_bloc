import 'package:flutter/material.dart';
import 'package:wisdom_pos_test/core/color.dart';
import 'package:wisdom_pos_test/core/constants/size.dart';

class VButtonIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  final Color selectedColor;
  final Color selectedIconColor;

  final Color unselectedColor;
  final Color unselectedIconColor;

  final Color borderColor;

  final double size;
  final double padding;

  const VButtonIcon({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = VColor.primaryContainer,
    this.selectedIconColor = VColor.onPrimaryContainer,
    this.unselectedColor = Colors.transparent,
    this.unselectedIconColor = VColor.onSurface,
    this.borderColor = VColor.outlineVar,
    this.size = iconMedium,
    this.padding = marginSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.white.withAlpha(50);
          }
          if (states.contains(WidgetState.hovered)) {
            return Colors.black.withAlpha(20);
          }
          return null;
        }),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? selectedColor : unselectedColor,
            border: Border.all(color: borderColor),
          ),
          child: Icon(
            icon,
            color: isSelected ? selectedIconColor : unselectedIconColor,
            size: size,
          ),
        ),
      ),
    );
  }
}
