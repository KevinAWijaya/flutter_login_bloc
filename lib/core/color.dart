import 'package:flutter/material.dart';

class VColor {
  // brand color
  static const Color primary = Color(0xFF697565);
  static const Color onPrimary = Color(0xFFECDFCC);

  // secondary button
  static const Color secondary = Color(0xFFECDFCC);
  static const Color onSecondary = Color(0xFF3C3D37);

  // background element (card, container)
  static const Color surface = Color(0xFF3C3D37);
  static const Color onSurface = Color(0xFFECDFCC);

  /// background primary
  static const Color accent = Color(0xFF181C14);
  static const Color onAccent = Color(0xFFECDFCC);

  static const Color primaryOpacity = Color.fromARGB(150, 105, 117, 101);
  static const Color secondaryOpacity = Color.fromARGB(150, 236, 223, 204);
  static const Color surfaceOpacity = Color.fromARGB(150, 60, 61, 55);
  static const Color accentOpacity = Color.fromARGB(150, 24, 28, 20);

  static const Color background = Color.fromARGB(255, 255, 255, 255);
  static const Color backgroundCard = Color.fromARGB(255, 238, 238, 238);

  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color whiteOpacitiy = Color.fromARGB(20, 255, 255, 255);
  static const Color blackOpacity = Color.fromARGB(20, 0, 0, 0);

  static const Color grey1 = Color(0xFFEEEEEE);
  static const Color grey2 = Color.fromARGB(255, 169, 168, 168);
  static const Color grey3 = Color.fromARGB(255, 86, 86, 86);
  static const Color grey4 = Color.fromARGB(255, 52, 52, 52);

  static const Color grey1Opacity = Color.fromARGB(20, 186, 186, 186);
  static const Color grey2Opacity = Color.fromARGB(20, 122, 122, 122);
  static const Color grey3Opacity = Color.fromARGB(20, 86, 86, 86);
  static const Color grey4Opacity = Color.fromARGB(20, 52, 52, 52);

  static WidgetStateProperty<Color?> overlayColor({
    Color rippleColor = primary,
    Color hoverColor = primary,
  }) {
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return rippleColor.withAlpha(80); // ripple effect
      }
      if (states.contains(WidgetState.hovered)) {
        return hoverColor.withAlpha(40); // hover effect
      }
      return null;
    });
  }
}
