import 'package:flutter/material.dart';

import '../../../core/color.dart';
import '../../../core/constants/size.dart';
import '../text.dart';

class LoadingHelper {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: marginMedium, vertical: marginLarge),
            decoration: BoxDecoration(
              color: VColor.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: VColor.primary,
                ),
                SizedBox(height: 16),
                VText(
                  "Loading...",
                  fontSize: textSizeMedium,
                  color: VColor.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
