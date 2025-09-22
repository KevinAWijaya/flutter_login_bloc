import 'package:flutter/material.dart';
import 'package:wisdom_pos_test/core/color.dart';

class VLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const VLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.white.withAlpha(125),
              child: const Center(
                child: CircularProgressIndicator(
                  color: VColor.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
