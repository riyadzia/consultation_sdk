import 'package:flutter/material.dart';

class AppSizes {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late double defaultSize;
  static late Orientation orientation;
  static late TextScaler textScaler;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    textScaler = _mediaQueryData.textScaler;
  }
}

double screenHeight() => AppSizes.height;
double screenWidth() => AppSizes.width;
double getHeight(double inputHeight) {
  double screenHeight = AppSizes.height;
  var percent = ((screenHeight / 100) * inputHeight) / screenHeight;
  return (screenHeight * percent) / 10;
}

double kTabIndicatorHeight() => isMobile() ? getWidth(50) : getWidth(40);

TextScaler textScaler() => AppSizes.textScaler;

double getWidth(double inputWidth) {
  double screenWidth = AppSizes.width;
  return (inputWidth / 430) * screenWidth;
}

bool isSmallDevice(){
  return screenWidth() < 390;
}

bool isMobile() {
  return AppSizes.width <= 600;
}
