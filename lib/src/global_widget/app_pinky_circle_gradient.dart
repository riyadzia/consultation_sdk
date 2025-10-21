import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';

class AppPinkyCircleGradient extends StatelessWidget {
  const AppPinkyCircleGradient({super.key,this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          right: 0,
          child: Container(
            color: AppColors.light5,
          ),
        ),
        Positioned(
          top: - screenWidth() * 0.32,
          right: -getWidth(20),
          child: Container(
            height: screenWidth() * 0.8,
            width: screenWidth() * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 100,
                    offset: const Offset(0, 0),
                    color: AppColors.mainColor.withValues(alpha: 0.17))
              ],
            ),
          ),
        ),
        Positioned(
          top: - screenWidth() * 0.17,
          right: 0,
          child: Container(
            height: screenWidth() * 0.7,
            width: screenWidth() * 0.7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 100,
                    offset: const Offset(0, 0),
                    color: AppColors.mainColor.withValues(alpha: 0.17))
              ],
            ),
          ),
        ),
        if(child != null)...[
          Positioned(
            // top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: child!,
          ),
        ]
      ],
    );
  }
}
