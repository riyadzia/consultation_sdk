import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';

class PagePinkyBackground extends StatelessWidget {
  PagePinkyBackground({super.key, this.child});
  final Widget? child;

  final circleSized = (screenWidth() * 0.99);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(),
      width: screenWidth(),
      color: AppColors.light5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: - screenWidth() * 0.256,
            left: - screenWidth() * 0.1,
            child: Container(
              height: circleSized,
              width: circleSized,
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
            top: screenWidth() * 0.12,
            left: - circleSized * 0.1,
            child: Container(
              height: circleSized,
              width: circleSized,
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
            top: circleSized,
            left: -screenWidth() * 0.25,
            child: Container(
              height: circleSized,
              width: circleSized,
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
            top: -screenWidth() * 0.13,
            left: screenWidth() * 0.38,
            child: Container(
              height: circleSized,
              width: circleSized,
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
            left: (circleSized) * 0.42,
            child: Container(
              height: circleSized,
              width: circleSized,
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
            right: - circleSized * 0.4,
            bottom: -circleSized * 0.25,
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
          if(child != null)...[
            child!,
          ],
        ],
      ),
    );
  }
}
