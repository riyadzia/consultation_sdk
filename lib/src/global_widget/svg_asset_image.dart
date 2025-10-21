import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgAssetImage extends StatelessWidget {
  const SvgAssetImage(
      {super.key,
      required this.image,
      this.height,
      this.width,
      this.fit = BoxFit.contain,
      this.color});
  final String image;
  final double? height, width;
  final BoxFit fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return color != null
        ? SvgPicture.asset(
            image,
            height: height,
            width: width,
            color: color,
            fit: fit,
          )
        : SvgPicture.asset(
            image,
            height: height,
            width: width,
            fit: fit,
          );
  }
}
