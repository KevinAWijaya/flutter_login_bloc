import 'package:flutter/material.dart';

import '../../core/color.dart';
import '../../core/constants/size.dart';
import '../../core/constants/space.dart';

class VInputText extends StatefulWidget {
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
  final VoidCallback? onSuffixTap;

  const VInputText({
    Key? key,
    this.controller,
    this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.isUseRipleEffect = false,
    this.onChanged,
    this.backgroundColor = VColor.accent,
    this.borderColor = VColor.accent,
    this.iconColor = VColor.onAccent,
    this.textColor = VColor.onAccent,
    this.cursorColor = VColor.onAccent,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
  }) : super(key: key);

  @override
  State<VInputText> createState() => _VInputTextState();
}

class _VInputTextState extends State<VInputText> {
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: borderRadiusMedium,
              border: Border.all(color: widget.borderColor),
              color: widget.backgroundColor,
            ),
            child: Row(
              children: [
                // Prefix icon
                if (widget.prefixIcon != null) ...[
                  ..._prefixIcon(),
                ],

                // Text field
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    focusNode: _focusNode,
                    keyboardType: widget.keyboardType,
                    obscureText: widget.obscureText,
                    cursorWidth: 2,
                    cursorRadius: const Radius.circular(2),
                    cursorColor: widget.cursorColor,
                    style: TextStyle(color: widget.textColor),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: widget.hint ?? 'Tap untuk mengisi',
                      hintStyle: TextStyle(color: widget.textColor.withAlpha(150)),
                      border: InputBorder.none,
                    ),
                    onChanged: widget.onChanged,
                  ),
                ),

                // Suffix icon
                if (widget.suffixIcon != null) ...[
                  ..._suffixIcon(),
                ],
              ],
            ),
          ),

          // 🔹 Overlay InkWell for ripple effect
          if (widget.isUseRipleEffect)
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
                  if (widget.suffixIcon != null) // space for suffix onClick
                    spaceHorizontalCustom(iconSmall + (marginLarge * 2))
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _prefixIcon() {
    return [
      IconTheme(
        data: IconThemeData(color: widget.iconColor, size: iconSmall),
        child: widget.prefixIcon!,
      ),
      spaceHorizontalSmall,
    ];
  }

  List<Widget> _suffixIcon() {
    return [
      spaceHorizontalSmall,
      widget.onSuffixTap != null
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onSuffixTap,
                // 🔹 Bentuk splash (Circle)
                customBorder: const CircleBorder(),
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
                child: Padding(
                  padding: const EdgeInsets.all(marginSmall),
                  child: IconTheme(
                    data: IconThemeData(
                      color: widget.iconColor,
                      size: iconSmall,
                    ),
                    child: widget.suffixIcon!,
                  ),
                ),
              ),
            )
          : IconTheme(
              data: IconThemeData(color: widget.iconColor, size: iconSmall),
              child: widget.suffixIcon!,
            ),
    ];
  }
}
