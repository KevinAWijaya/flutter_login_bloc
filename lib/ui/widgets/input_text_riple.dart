import 'package:flutter/material.dart';

import '../../core/color.dart';
import '../../core/constants/space.dart';

class VInputTextRiple extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool isUseRipleEffect;
  final void Function(String)? onChanged;

  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final Color cursorColor;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const VInputTextRiple({
    Key? key,
    this.controller,
    this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.isUseRipleEffect = false,
    this.onChanged,
    this.backgroundColor = VColor.primary,
    this.borderColor = VColor.primary,
    this.iconColor = VColor.onAccent,
    this.textColor = VColor.onAccent,
    this.cursorColor = VColor.onAccent,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  State<VInputTextRiple> createState() => _VInputTextRipleState();
}

class _VInputTextRipleState extends State<VInputTextRiple> {
  late final TextEditingController _ctrl;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _ctrl = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _ctrl.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: borderRadiusMedium,
      color: widget.backgroundColor,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadiusMedium,
              border: Border.all(color: widget.borderColor),
              color: widget.backgroundColor,
            ),
            child: TextField(
              controller: _ctrl,
              focusNode: _focusNode,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              cursorWidth: 1,
              cursorRadius: const Radius.circular(2),
              cursorColor: widget.cursorColor,
              style: TextStyle(color: widget.textColor),
              decoration: InputDecoration(
                hintText: widget.hint ?? 'Tap untuk mengisi',
                hintStyle: TextStyle(color: widget.textColor.withAlpha(150)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
              ),
              onChanged: widget.onChanged,
            ),
          ),

          // 🔹 Overlay InkWell for ripple effect
          if (widget.isUseRipleEffect && widget.suffixIcon == null)
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: borderRadiusMedium,
                      child: InkWell(
                        borderRadius: borderRadiusMedium,
                        onTap: () => _focusNode.requestFocus(),
                        overlayColor: WidgetStateProperty.resolveWith<Color?>(
                          (states) {
                            if (states.contains(WidgetState.pressed)) {
                              return VColor.white.withAlpha(50);
                            }
                            if (states.contains(WidgetState.hovered)) {
                              return VColor.black.withAlpha(20);
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
