import 'package:flutter/material.dart';
import 'package:wisdom_pos_test/core/constants/size.dart';
import 'package:wisdom_pos_test/core/constants/space.dart';

import '../../core/color.dart';

class VDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;

  // Customization

  // selected date color
  final Color backgroundColor;
  final Color textColor;

  // date picker color
  final Color primaryColor;
  final Color dateBackgroundColor;
  final Color dateTextColor;
  final Color headerBackgroundColor;
  final Color headerTextColor;
  final Color todayHighlightColor;
  final Color selectedDateColor;

  const VDatePicker({
    super.key,
    this.initialDate,
    this.onDateSelected,
    this.primaryColor = VColor.primary,
    this.backgroundColor = VColor.primary,
    this.textColor = VColor.onPrimary,
    this.dateBackgroundColor = VColor.onSurfaceContainer,
    this.dateTextColor = VColor.onPrimary,
    this.headerBackgroundColor = VColor.primary,
    this.headerTextColor = VColor.onPrimary,
    this.todayHighlightColor = VColor.primary,
    this.selectedDateColor = VColor.primary,
  });

  @override
  State<VDatePicker> createState() => _VDatePickerState();
}

class _VDatePickerState extends State<VDatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.primaryColor,
              onPrimary: widget.headerTextColor,
              onSurface: widget.dateTextColor,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: widget.dateBackgroundColor,
              headerBackgroundColor: widget.headerBackgroundColor,
              headerForegroundColor: widget.headerTextColor,
              todayBackgroundColor: WidgetStatePropertyAll(widget.todayHighlightColor.withAlpha(60)),
              todayForegroundColor: WidgetStatePropertyAll(widget.todayHighlightColor),

              // text & background date
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return widget.headerTextColor; // selected date text
                }
                return widget.dateTextColor; // default text color
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return widget.selectedDateColor;
                }
                return null;
              }),
              dayOverlayColor: VColor.overlayColor(hoverColor: widget.selectedDateColor, rippleColor: widget.selectedDateColor),

              // 👇 Custom OK & Cancel button
              cancelButtonStyle: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(widget.selectedDateColor),
                overlayColor: VColor.overlayColor(hoverColor: widget.selectedDateColor, rippleColor: widget.selectedDateColor),
              ),
              confirmButtonStyle: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(widget.selectedDateColor),
                overlayColor: VColor.overlayColor(hoverColor: widget.selectedDateColor, rippleColor: widget.selectedDateColor),
              ),
            ),
            dialogTheme: DialogThemeData(backgroundColor: widget.dateBackgroundColor),

            // input mode
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: widget.dateBackgroundColor,
              labelStyle: TextStyle(color: widget.dateTextColor),
              hintStyle: TextStyle(color: widget.dateTextColor.withAlpha(180)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.primaryColor),
                borderRadius: borderRadiusMedium,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.selectedDateColor, width: 2),
                borderRadius: borderRadiusMedium,
              ),
            ),
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyLarge: TextStyle(color: widget.dateTextColor),
                  bodyMedium: TextStyle(color: widget.dateTextColor),
                ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginMedium),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(color: widget.primaryColor, width: 1),
          borderRadius: borderRadiusLarge,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}" : "Select Date",
              style: TextStyle(color: widget.textColor, fontSize: 16),
            ),
            Icon(Icons.calendar_today, color: widget.textColor),
          ],
        ),
      ),
    );
  }
}
