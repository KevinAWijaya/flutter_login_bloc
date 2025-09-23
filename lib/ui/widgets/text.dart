import 'package:flutter/material.dart';

import '../../core/color.dart';
import '../../core/constants/constants.dart';

class VText extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final TextOverflow? overflow;
  final TextAlign? align;
  final TextDecoration? decoration;
  final int? maxLines;
  final Color? color;
  final bool? isBold;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final VoidCallback? onPressed;

  const VText(
    this.title, {
    super.key,
    this.fontSize,
    this.overflow,
    this.onPressed,
    this.decoration,
    this.maxLines,
    this.align,
    this.color = VColor.onSurface,
    this.fontWeight,
    this.fontStyle,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        title!,
        style: TextStyle(
          fontFamily: interFontFamily,
          color: color,
          fontSize: fontSize,
          fontStyle: fontStyle,
          fontWeight: fontWeight ?? (isBold! ? FontWeight.bold : FontWeight.normal),
          decoration: decoration,
          decorationColor: VColor.black,
        ),
        overflow: overflow,
        textAlign: align,
        maxLines: maxLines,
      ),
    );
  }
}

class VTextShadow extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final TextOverflow? overflow;
  final TextAlign? align;
  final TextDecoration? decoration;
  final int? maxLines;
  final Color? color;
  final bool? isBold;
  final VoidCallback? onPressed;

  const VTextShadow(this.title,
      {super.key, this.fontSize, this.overflow, this.onPressed, this.decoration, this.maxLines, this.align, this.color = VColor.black, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        title!,
        style: TextStyle(
          fontFamily: interFontFamily,
          color: color,
          fontSize: fontSize,
          fontWeight: isBold! ? FontWeight.bold : FontWeight.normal,
          decoration: decoration,
          shadows: const <Shadow>[
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 4.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ),
        overflow: overflow,
        textAlign: align,
        maxLines: maxLines,
      ),
    );
  }
}
