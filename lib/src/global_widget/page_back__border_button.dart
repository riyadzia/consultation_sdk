import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';

class PageBackBorderButton extends StatelessWidget {
  const PageBackBorderButton({super.key, this.onPressed, this.backgroundColor, this.iconColor});
  final Function? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getWidth(7)),
      padding: EdgeInsets.all(getWidth(0)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: iconColor ?? AppColors.secondaryColor,
            strokeAlign: BorderSide.strokeAlignInside)
      ),
      child: Material(
        shape: const CircleBorder(),
        color: backgroundColor ?? Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(getWidth(100)),
          onTap: (){
            if(onPressed == null){
              Navigator.of(context).pop();
            } else {
              onPressed!();
            }
          },
          child: Padding(
            padding: EdgeInsets.all(getWidth(6)),
            child: Icon(Icons.arrow_back_ios_rounded,color: iconColor,),
            // ),
          ),
        ),
      ),
    );
  }
}
