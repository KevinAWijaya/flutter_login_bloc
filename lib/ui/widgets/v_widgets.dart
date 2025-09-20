import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/color.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/size.dart';
import 'button.dart';
import 'text.dart';

class VInputText extends StatelessWidget {
  final String initialValue;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String hint;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final bool isSecureText;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Color filledBorderColor;
  final Color? hintTextColor;
  final Color? textColor;
  final bool filled;
  final double textPadding;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final Function(String)? onSubmittedText;
  final Function()? onEditingComplete;
  final double? borderRadius;
  final bool autoFocus;
  final TextAlign textAlign;
  final void Function()? onTap;

  const VInputText(
      {super.key,
      this.initialValue = "",
      this.textEditingController,
      this.hint = "",
      this.onSaved,
      this.focusNode,
      this.borderRadius = 10,
      this.filled = false,
      this.fillColor = VColor.primaryOpacity,
      this.textColor = VColor.grey4,
      this.hintTextColor = VColor.grey4,
      this.filledBorderColor = Colors.transparent,
      this.onChanged,
      this.isSecureText = false,
      this.validator,
      this.suffixIcon,
      this.readOnly = false,
      this.keyboardType = TextInputType.text,
      this.textInputAction,
      this.prefixIcon,
      this.textCapitalization = TextCapitalization.none,
      this.textPadding = 14,
      this.onSubmittedText,
      this.onEditingComplete,
      this.maxLines = 1,
      this.autoFocus = true,
      this.textAlign = TextAlign.start,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      readOnly: readOnly,
      textInputAction: textInputAction,
      controller: textEditingController?.text == '' ? (textEditingController?..text = initialValue) : textEditingController,
      focusNode: focusNode,
      style: TextStyle(
          // fontFamily: interFontFamily,
          fontSize: textSizeMedium,
          color: filled ? textColor : VColor.grey4),
      maxLines: maxLines,
      textAlign: textAlign,
      obscureText: isSecureText,
      cursorColor: VColor.primary,
      keyboardType: keyboardType,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: textSizeMedium,
          fontFamily: interFontFamily,
          color: filled ? hintTextColor : VColor.grey3Opacity,
        ),
        filled: filled,
        fillColor: fillColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: filled ? filledBorderColor : VColor.primary,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius!),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: filled ? filledBorderColor : VColor.grey1Opacity,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius!),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: filled ? filledBorderColor : VColor.grey1Opacity,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius!),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: filled ? filledBorderColor : VColor.grey1Opacity,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius!),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: textPadding,
          horizontal: textPadding,
        ),
      ),
      textCapitalization: textCapitalization,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: onSaved,
      onChanged: onChanged,
      onFieldSubmitted: onSubmittedText,
      onEditingComplete: onEditingComplete,
    );
  }
}

class VInputPassword extends StatefulWidget {
  final String initialValue;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String hint;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final bool isSecureText;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;

  const VInputPassword(
      {super.key,
      this.initialValue = "",
      this.textEditingController,
      this.hint = "",
      this.onSaved,
      this.focusNode,
      this.onChanged,
      this.isSecureText = true,
      this.validator,
      this.textInputAction});

  @override
  State<VInputPassword> createState() => _VInputPasswordState();
}

class _VInputPasswordState extends State<VInputPassword> {
  bool isSecureText = true;

  @override
  void initState() {
    isSecureText = widget.isSecureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController?.text == '' ? (widget.textEditingController?..text = widget.initialValue) : widget.textEditingController,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      style: TextStyle(
        fontFamily: interFontFamily,
        fontSize: 14.0,
      ),
      obscureText: isSecureText,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontFamily: interFontFamily,
          color: VColor.grey3,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: VColor.primary,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            isSecureText = !isSecureText;
            setState(() {});
          },
          icon: isSecureText
              ? const Icon(
                  Icons.visibility,
                  color: VColor.primary,
                )
              : const Icon(
                  Icons.visibility_off,
                  color: VColor.primary,
                ),
        ),
      ),
      textCapitalization: TextCapitalization.words,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
    );
  }
}

class VInputOTP extends StatelessWidget {
  final String initialValue;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String hint;
  final FormFieldSetter<String>? onSaved;
  final bool isSecureText;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Color? fillColor;
  final bool? filled;
  final Color borderColor;
  final bool last;
  final bool first;

  const VInputOTP(this.borderColor,
      {super.key,
      this.initialValue = "",
      this.textEditingController,
      this.hint = "",
      this.onSaved,
      this.focusNode,
      this.filled,
      this.fillColor,
      this.isSecureText = false,
      this.validator,
      this.suffixIcon,
      this.readOnly = false,
      this.keyboardType = TextInputType.number,
      this.textInputAction,
      this.last = false,
      this.first = false,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: TextFormField(
        readOnly: readOnly,
        textInputAction: textInputAction,
        maxLines: 1,
        maxLength: 1,
        controller: textEditingController?.text == '' ? (textEditingController?..text = initialValue) : textEditingController,
        focusNode: focusNode,
        style: TextStyle(fontFamily: interFontFamily, fontSize: 27.0, fontWeight: FontWeight.bold),
        obscureText: isSecureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: VColor.secondary,
              width: 10,
            ),
          ),
          prefixIcon: prefixIcon,
          hintText: hint,
          counterText: "",
          hintStyle: TextStyle(
            fontFamily: interFontFamily,
            color: VColor.grey4Opacity,
          ),
          filled: filled,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 20,
          ),
        ),
        textCapitalization: TextCapitalization.words,
        validator: validator,
        onSaved: onSaved,
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}

class VLoadingPage extends StatelessWidget {
  const VLoadingPage({super.key});

  Widget _loadingPage() {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(VColor.primary),
          ),
          SizedBox(
            height: 14,
          ),
          VText(
            "Please wait . . .",
            color: VColor.grey4,
            fontSize: 14,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loadingPage();
  }
}

class VAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> action;
  final bool isCenter;
  final bool isLightTheme;
  final double elevation;

  const VAppBar(this.title, {super.key, this.action = const [], this.isCenter = true, this.isLightTheme = true, this.elevation = 1.0});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0, // Remove default shadow
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0), // Small line height
        child: Container(
          color: Colors.grey, // Line color
          height: 0.5, // Thin line
        ),
      ),
      centerTitle: isCenter,
      backgroundColor: isLightTheme ? VColor.white : VColor.primary,
      titleTextStyle: TextStyle(
        color: isLightTheme ? VColor.black : VColor.white,
      ),
      title: VText(
        title,
        isBold: true,
        fontSize: textSizeSmall,
        color: isLightTheme ? VColor.black : VColor.white,
      ),
      // leadingWidth: 32.0,
      titleSpacing: 0,
      iconTheme: IconThemeData(color: isLightTheme ? VColor.secondary : VColor.white),
      actions: action,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

TextSpan vTextSpan(
    {String text = "",
    bool isBold = false,
    TextDecoration? decoration,
    Color color = VColor.grey4,
    GestureRecognizer? recognizer,
    List<InlineSpan>? children,
    double fontSize = 14.0}) {
  return TextSpan(
      text: text,
      style: TextStyle(
          fontFamily: interFontFamily, fontWeight: !isBold ? FontWeight.normal : FontWeight.bold, color: color, decoration: decoration, fontSize: fontSize),
      recognizer: recognizer,
      children: children);
}

class VTextRich extends StatelessWidget {
  final InlineSpan? textSpan;
  final Color? color;
  final double? fontSize;
  final TextDecoration? decoration;
  final bool isBold;

  const VTextRich({super.key, this.textSpan, this.color, this.fontSize, this.decoration, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textSpan!,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: interFontFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: !isBold ? FontWeight.normal : FontWeight.bold,
        decoration: decoration,
      ),
    );
  }
}

class VMessageItem extends StatelessWidget {
  final String message;
  final double height;
  final double width;
  final VoidCallback? action;

  const VMessageItem({
    super.key,
    this.height = 100.0,
    this.width = double.infinity,
    this.message = "Data is empty",
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VText(
            message.isEmpty ? "Data is Empty" : message,
          ),
          if (action != null) ...refreshButton()
        ],
      ),
    );
  }

  List<Widget> refreshButton() {
    return [
      const SizedBox(
        height: 8.0,
      ),
      VButton(
        text: "Refresh",
        onTap: action,
      ),
    ];
  }
}

class VBackground extends StatelessWidget {
  final Widget child;
  final String background;
  final Widget? footer;

  const VBackground({super.key, required this.child, this.background = "background.png", this.footer});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: -40.0,
          left: 0.0,
          right: 0.0,
          child: Image.asset(
            imagePath + background,
            fit: BoxFit.fitWidth,
          ),
        ),
        child,
        if (footer != null) footer!
      ],
    );
  }
}

class VExpansionTile extends StatefulWidget {
  const VExpansionTile({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.tilePadding,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.textColor,
    this.collapsedTextColor,
    this.iconColor,
    this.collapsedIconColor,
  })  : assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
          'CrossAxisAlignment.baseline is not supported since the expanded children '
          'are aligned in a column, not a row. Try to use another constant.',
        ),
        super(key: key);

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final Widget? trailing;

  final bool initiallyExpanded;
  final bool maintainState;
  final EdgeInsetsGeometry? tilePadding;
  final Alignment? expandedAlignment;
  final CrossAxisAlignment? expandedCrossAxisAlignment;
  final EdgeInsetsGeometry? childrenPadding;
  final Color? iconColor;
  final Color? collapsedIconColor;
  final Color? textColor;
  final Color? collapsedTextColor;

  @override
  State<VExpansionTile> createState() => _ExpansionTileState();
}

class _ExpansionTileState extends State<VExpansionTile> with SingleTickerProviderStateMixin {
  static const Duration _kExpand = Duration(milliseconds: 200);

  static final Animatable<double> _easeOutTween = CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _borderColor;
  late Animation<Color?> _headerColor;
  late Animation<Color?> _iconColor;
  late Animation<Color?> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _borderColor = _controller.drive(_borderColorTween.chain(_easeOutTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor = _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = PageStorage.of(context).readState(context) as bool? ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context).writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    // ignore: unused_local_variable
    final Color borderSideColor = _borderColor.value ?? Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor.value ?? Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTileTheme.merge(
            iconColor: _iconColor.value,
            textColor: _headerColor.value,
            child: ListTile(
              onTap: _handleTap,
              contentPadding: widget.tilePadding,
              leading: widget.leading,
              title: widget.title,
              subtitle: widget.subtitle,
              trailing: widget.trailing ??
                  RotationTransition(
                    turns: _iconTurns,
                    child: const Icon(Icons.expand_more),
                  ),
            ),
          ),
          ClipRect(
            child: Align(
              alignment: widget.expandedAlignment ?? Alignment.center,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    _borderColorTween.end = theme.dividerColor;
    _headerColorTween
      ..begin = widget.collapsedTextColor ?? theme.textTheme.titleMedium!.color
      ..end = widget.textColor ?? colorScheme.secondary;
    _iconColorTween
      ..begin = widget.collapsedIconColor ?? theme.unselectedWidgetColor
      ..end = widget.iconColor ?? colorScheme.secondary;
    _backgroundColorTween
      ..begin = widget.collapsedBackgroundColor
      ..end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Padding(
          padding: widget.childrenPadding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: widget.expandedCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: widget.children,
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
