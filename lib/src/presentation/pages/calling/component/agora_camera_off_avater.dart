import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';

class AgoraCameraOffAvatar extends StatelessWidget {
  const AgoraCameraOffAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getWidth(272),
      width: getWidth(153),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            height: getWidth(272),
            width: getWidth(153),
            child: Center(
              child: Icon(Icons.videocam_off,size: getWidth(40),),
            ),
          ),
        ),
      ),
    );
  }
}
