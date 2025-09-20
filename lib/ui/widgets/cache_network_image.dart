// /// dependencies cached_network_image

// import 'package:flutter/material.dart';
// import 'package:wisdom_pos_test/core/color.dart';

// class VCachedNetworkImage extends StatelessWidget {
//   final String url;
//   final double height;
//   final double width;
//   final Widget placeholder;

//   const VCachedNetworkImage(this.url,
//       {super.key,
//       this.height = 40.0,
//       this.width = 40.0,
//       this.placeholder = const Icon(
//         Icons.dangerous,
//         color: VColor.primary,
//       )});

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: url,
//       height: height,
//       width: width,
//       fit: BoxFit.fitWidth,
//       errorWidget: (c, s, d) => placeholder,
//       placeholder: (c, s) => placeholder,
//     );
//   }
// }
