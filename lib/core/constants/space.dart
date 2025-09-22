import 'package:flutter/material.dart';
import 'package:wisdom_pos_test/core/constants/size.dart';

Widget spaceVerticalSuperSmall = const SizedBox(height: marginSuperSmall);
Widget spaceVerticalSmall = const SizedBox(height: marginSmall);
Widget spaceVerticalMedium = const SizedBox(height: marginMedium);
Widget spaceVerticalLarge = const SizedBox(height: marginLarge);
Widget spaceVerticalSuperLarge = const SizedBox(height: marginExtraLarge);
Widget spaceVerticalCustom(double value) => SizedBox(height: value);

Widget spaceHorizontalSuperSmall = const SizedBox(width: marginSuperSmall);
Widget spaceHorizontalSmall = const SizedBox(width: marginSmall);
Widget spaceHorizontalMedium = const SizedBox(width: marginMedium);
Widget spaceHorizontalLarge = const SizedBox(width: marginLarge);
Widget spaceHorizontalSuperLarge = const SizedBox(width: marginExtraLarge);
Widget spaceHorizontalCustom(double value) => SizedBox(width: value);

final borderRadiusSmall = BorderRadius.circular(radiusSmall);
final borderRadiusMedium = BorderRadius.circular(radiusMedium);
final borderRadiusLarge = BorderRadius.circular(radiusLarge);
final borderRadiusExtraLarge = BorderRadius.circular(radiusExtraLarge);
final borderRadiusSuperLarge = BorderRadius.circular(radiusSuperLarge);
final borderRadiusMax = BorderRadius.circular(radiusMax);
