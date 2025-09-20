import 'package:flutter/material.dart';
import 'package:wisdom_pos_test/core/color.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
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
              color: Colors.white.withOpacity(0.5), // semi-transparent grey
              child: const Center(
                child: CircularProgressIndicator(
                  color: VColor.primary, // color of the spinner
                ),
              ),
            ),
          ),
      ],
    );
  }
}
