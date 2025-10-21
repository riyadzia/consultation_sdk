import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_icons.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.path,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
  });

  final String? path;
  final BoxFit fit;
  final double? height, width;
  final Color? color;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    final imagePath = path == null || path == '' ? AppIcons.logo : path;

    if (isFile) {
      return Image.file(
        File(imagePath!),
        fit: fit,
        color: color,
        height: height,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.image_outlined, size: height);
          // return Image(
          //   image: const NetworkImage(AppIcons.logo),
          //   height: height,
          //   width: width,
          // );
        },
      );
    }

    // Network Image
    if (imagePath!.startsWith('http') ||
        imagePath.startsWith('https') ||
        imagePath.startsWith('www.')) {
      // SVG network image
      if (imagePath.endsWith('.svg')) {
        return SizedBox(
          height: height,
          width: width,
          child: SvgPicture.network(
            imagePath,
            fit: fit,
            height: height,
            width: width,
            color: color,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image_outlined, size: height);
              // return Image(
              //   image: const NetworkImage(AppIcons.logo),
              //   height: height,
              //   width: width,
              // );
            },
          ),
        );
      }
      return CachedNetworkImage(
        imageUrl: imagePath,
        fit: fit,
        color: color,
        height: height,
        width: width,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Center(
            child: SizedBox(
              height: getWidth(20),
              width: getWidth(20),
              child: CircularProgressIndicator(
                backgroundColor: AppColors.mainColor,
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Icon(Icons.image_outlined,);
          // return const Image(image: NetworkImage(AppIcons.logo), fit: BoxFit.cover)
        },
      );
    }

    // Svg Asset Image
    if (imagePath.endsWith('.svg')) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(
          imagePath,
          fit: fit,
          height: height,
          width: width,
          color: color,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.image_outlined, size: height);
            // return Image(
            //   image: const NetworkImage(AppIcons.logo),
            //   height: height,
            //   width: width,
            // );
          },
        ),
      );
    }

    return Image.asset(
      imagePath,
      fit: fit,
      color: color,
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.image_outlined, size: height);
        // return Image(
        //   image: const NetworkImage(AppIcons.logo),
        //   height: height,
        //   width: width,
        // );
      },
    );
  }
}
