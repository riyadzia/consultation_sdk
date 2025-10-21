import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double fontSize;
  final double? fontHeight;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final Color? underlineColor;
  final double? letterSpaching;
  final bool isOnlySolimani;
  final TextDecoration? textDecoration;

  const CustomText({super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight,
    this.fontHeight,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.color = const Color(0xff16020B),
    this.underlineColor,
    this.letterSpaching,
    this.isOnlySolimani = false,
    this.textDecoration});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w400,
          // fontFamily: controller.selectedLanguage.value == "English" && !isOnlySolimani ? "ClashDisplay" : "SolaimanLipi",
          letterSpacing: letterSpaching,
          decoration: textDecoration,
          decorationThickness: 2,
          decorationColor: underlineColor,
          height: fontHeight),
    );
  }
}
