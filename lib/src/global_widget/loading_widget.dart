import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_icons.dart';
import 'package:consultation_sdk/src/global_widget/custom_image.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = Tween<double>(
      begin: 0,
      end: 12.5664, // 2Radians (360 degrees)
    ).animate(animationController);
    animationController.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
            animation: animation,
          builder: (context, child) => Transform.rotate(
            angle: animation.value,
            child: CircularProgressIndicator(
              color: AppColors.mainColor,
              value: 0.4,
              // strokeAlign: 1,
              strokeWidth: 5,
              backgroundColor: AppColors.mainColor.withValues(alpha: 0.32),
            ),
          ),
        ),
        CustomImage(
          path: AppIcons.logo,
          height: 16,
        )
      ],
    );
  }
}
