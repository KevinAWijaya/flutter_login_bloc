import 'package:flutter/material.dart';

import '../../core/color.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/size.dart';

class VLogoCircular extends StatelessWidget {
  const VLogoCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(marginLarge),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: VColor.grey1,
      ),
      child: const Image(
        image: AssetImage("${imagePath}logo.png"),
        fit: BoxFit.contain,
      ),
    );
  }
}
