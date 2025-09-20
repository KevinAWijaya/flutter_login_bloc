import 'package:flutter/material.dart';

import '../../core/color.dart';
import '../../core/constants/size.dart';
import 'text.dart';

class NotificationIcon extends StatelessWidget {
  final int count;
  final void Function()? onTap;
  const NotificationIcon({super.key, required this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          const IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.notifications,
              size: 30,
              color: VColor.grey3,
            ),
            onPressed: null,
          ),
          if (count > 0)
            Positioned(
              right: 8,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: VText(
                  count.toString(),
                  color: VColor.white,
                  fontSize: textSizeSmall,
                  isBold: true,
                  align: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
