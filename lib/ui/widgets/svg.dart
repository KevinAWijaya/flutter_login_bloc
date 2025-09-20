/// dependencies flutter_svg

// import 'package:flutter/material.dart';

// import '../../core/color.dart';

// class VSvgPicture extends StatelessWidget {
//   final String img;
//   final double? height;
//   final double? width;
//   final Color? color;
//   final VoidCallback? onPressed;

//   const VSvgPicture(this.img, {super.key, this.color, this.height, this.width, this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: SvgPicture.asset(
//         img,
//         width: width,
//         height: height,
//         colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcATop),
//         placeholderBuilder: (BuildContext context) {
//           return const Icon(
//             Icons.error,
//             color: VColor.primary,
//           );
//         },
//       ),
//     );
//   }
// }
