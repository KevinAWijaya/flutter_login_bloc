import 'package:flutter/material.dart';

import '../../../core/color.dart';
import '../../../core/constants/space.dart';

class VDatePickerHelper {
  static Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,

    // selected date color
    Color backgroundColor = VColor.primary,
    Color textColor = VColor.onPrimary,

    // date picker color
    Color primaryColor = VColor.primary,
    Color dateBackgroundColor = VColor.surfaceContainer,
    Color dateTextColor = VColor.onSurface,
    Color headerBackgroundColor = VColor.primary,
    Color headerTextColor = VColor.onPrimary,
    Color todayHighlightColor = VColor.primary,
    Color selectedDateColor = VColor.primary,
  }) async {
    final DateTime now = DateTime.now();

    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: headerTextColor,
              onSurface: dateTextColor,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: dateBackgroundColor,
              headerBackgroundColor: headerBackgroundColor,
              headerForegroundColor: headerTextColor,
              todayBackgroundColor: WidgetStatePropertyAll(todayHighlightColor.withAlpha(60)),
              todayForegroundColor: WidgetStatePropertyAll(todayHighlightColor),

              // text & background date
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return headerTextColor; // selected date text
                }
                return dateTextColor; // default text color
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return selectedDateColor;
                }
                return null;
              }),
              dayOverlayColor: VColor.overlayColor(hoverColor: selectedDateColor, rippleColor: selectedDateColor),

              // 👇 Custom OK & Cancel button
              cancelButtonStyle: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(selectedDateColor),
                overlayColor: VColor.overlayColor(hoverColor: selectedDateColor, rippleColor: selectedDateColor),
              ),
              confirmButtonStyle: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(selectedDateColor),
                overlayColor: VColor.overlayColor(hoverColor: selectedDateColor, rippleColor: selectedDateColor),
              ),
            ),
            dialogTheme: DialogThemeData(backgroundColor: dateBackgroundColor),

            // input mode
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: dateBackgroundColor,
              labelStyle: TextStyle(color: dateTextColor),
              hintStyle: TextStyle(color: dateTextColor.withAlpha(180)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: borderRadiusMedium,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: selectedDateColor, width: 2),
                borderRadius: borderRadiusMedium,
              ),
            ),
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyLarge: TextStyle(color: dateTextColor),
                  bodyMedium: TextStyle(color: dateTextColor),
                ),
          ),
          child: child!,
        );
      },
    );
  }
}
