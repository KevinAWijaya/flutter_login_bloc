import 'package:flutter/material.dart';

class VColor {
  /// HEX COLOR #007F28
  /// HUE 147.0832366866118
  /// CHROMA 61.719877924171264
  /// TONE 46.08553202125894

  // brand color
  static const Color primary = Color(0xFF3a693b);
  static const Color onPrimary = Color(0xFFffffff);

  static const Color primaryContainer = Color(0xFFbbf0b6);
  static const Color onPrimaryContainer = Color(0xFF225025);

  // secondary button
  static const Color secondary = Color(0xFF52634f);
  static const Color onSecondary = Color(0xFFffffff);

  static const Color secondaryContainer = Color(0xFFd5e8cf);
  static const Color onSecondaryContainer = Color(0xFF3b4b39);

  // Tertiary button
  static const Color tertiary = Color(0xFF39656b);
  static const Color onTertiary = Color(0xFFffffff);

  static const Color tertiaryContainer = Color(0xFFbcebf1);
  static const Color onTertiaryContainer = Color(0xFF1f4d53);

  // Error button
  static const Color error = Color(0xFFba1a1a);
  static const Color onError = Color(0xFFffffff);

  static const Color errorContainer = Color(0xFFffdad6);
  static const Color onErrorContainer = Color(0xFF93000a);

  // background element (card, container)
  static const Color surface = Color(0xFFf7fbf1);
  static const Color onSurface = Color(0xFF181d17);

  static const Color surfaceContainerLowest = Color(0xFFffffff);
  static const Color surfaceContainerLow = Color(0xFFf1f5ec);
  static const Color surfaceContainer = Color(0xFFebefe6);
  static const Color surfaceContainerHigh = Color(0xFFe6e9e0);
  static const Color surfaceContainerHighest = Color(0xFFe0e4db);

  // outline
  static const Color outline = Color(0xFF72796f);
  static const Color outlineVar = Color(0xFFc2c9bd);

  // inverse
  static const Color inverseSurface = Color(0xFF2d322c);
  static const Color onInverseSurface = Color(0xFFeef2e9);
  static const Color onInversePrimary = Color(0xFF9fd49b);

  // another

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
