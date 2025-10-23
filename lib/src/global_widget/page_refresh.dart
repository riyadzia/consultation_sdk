import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:flutter/material.dart';

class PageRefresh extends StatelessWidget {
  PageRefresh(
      {super.key,
      required this.onRefresh,
      required this.child,
      this.backgroundColor,
      this.progressColor});
  final Function onRefresh;
  final Widget child;
  final Color? backgroundColor;
  final Color? progressColor;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        color: progressColor ?? Colors.white,
        backgroundColor: backgroundColor ?? AppColors.mainColor,
        strokeWidth: 2.0,
        onRefresh: () => onRefresh(),
        child: child);
  }
}
