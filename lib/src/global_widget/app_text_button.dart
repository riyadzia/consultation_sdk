import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';

import '../core/app_sizes.dart';

class AppTextButton extends StatefulWidget {
  const AppTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.textSize,
    this.textDecoration,
    this.fontWeight,
    this.isShowIcon = false,
  });
  final String text;
  final Color? textColor;
  final double? textSize;
  final Function onTap;
  final TextDecoration? textDecoration;
  final FontWeight? fontWeight;
  final bool? isShowIcon;

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  Color color = Colors.black87;
  double size = getWidth(14);

  @override
  void initState() {
    color = widget.textColor ?? Colors.black87;
    size = widget.textSize ?? getWidth(14);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          children: [
            CustomText(text: widget.text,
              color: color,
              fontSize: size,
              textDecoration: widget.textDecoration ?? TextDecoration.none,
              fontWeight: widget.fontWeight ?? FontWeight.bold,),
            if(widget.isShowIcon == true)...[
              SizedBox(width: getWidth(4),),
              Icon(
                Icons.keyboard_arrow_down,
                color: color,
                size: getWidth(20),)
            ]
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      color = color.withValues(alpha: 0.6);
      // size = size + 2;
    });
  }

  void _onTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 150)).then((value) {
      setState(() {
        color = widget.textColor ?? Colors.black87;
        // size = widget.textSize ?? 14;
      });
    });
  }
}
