import 'package:flutter/material.dart';

import '../../core/color.dart';

class VCheckbox extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final double height;
  final double width;

  const VCheckbox({
    super.key,
    this.isChecked = false,
    required this.onChanged,
    this.height = 18,
    this.width = 18,
  });

  @override
  State<VCheckbox> createState() => _VCheckboxState();
}

class _VCheckboxState extends State<VCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  void didUpdateWidget(covariant VCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isChecked != widget.isChecked) {
      setState(() {
        isChecked = widget.isChecked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Checkbox(
        value: isChecked,
        checkColor: VColor.white,
        activeColor: VColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onChanged: (bool? value) {
          if (value != null) {
            setState(() {
              isChecked = value;
            });
            widget.onChanged(value);
          }
        },
      ),
    );
  }
}
