import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.color,
      this.fontWeight,
      this.fontSize = 14,
      this.titleColor,
        this.side,
      this.elevation = 2,
      this.verticalPadding,
      this.horizontalPadding,
      this.borderRadius = 10,
      this.child});
  final String title;
  final Function() onTap;
  final Color? color;
  final BorderSide? side;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? elevation;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? titleColor;
  final Widget? child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.green,
          elevation: elevation ?? 1,
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding ?? 3, horizontal: horizontalPadding ?? 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: side,
          backgroundColor: color ?? AppColors.secondaryColor,),
      child: child ??
          Center(
            child: CustomText(
                text: title,
                fontSize: fontSize ?? 15,
                color:  titleColor ?? AppColors.white,
                fontWeight: fontWeight ?? FontWeight.w600,
            ),
          ),
    );
  }
}
