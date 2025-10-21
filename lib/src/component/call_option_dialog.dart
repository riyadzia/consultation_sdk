import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/animation/animated_ripple_horizontal_icon.dart';
import 'package:consultation_sdk/src/animation/animated_ripple_icon.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/services/navigation_service.dart';
import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/global_widget/app_pinky_circle_gradient.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_cubit.dart';
import 'package:consultation_sdk/src/screen/call_waiting_screen.dart';
import 'package:consultation_sdk/consultation_sdk.dart';

class CallOptionDialog {
  static openCallOptionDialog(
    BuildContext context,
    ValueChanged<bool> startCall, {
    bool isActive = true,
  }) {
    if (!context.read<HealthPackageCubit>().getIsCardActiveForAll()) {
      Utils.showMiddleToast("Your haven't buy any package");
      return;
    }
    Utils.showCustomDialog(
      context,
      delay: 300,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: const EdgeInsets.all(16.0),
            height: screenWidth() * 0.5,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const AppPinkyCircleGradient(),
                ),
                Material(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: getWidth(8), width: screenWidth()),
                        CustomText(
                          text: "Call Doctor 24/7",
                          fontSize: getWidth(18),
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          text: "Audio & Video",
                          fontSize: getWidth(14),
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: AppColors.greyBorderColor,
                                  ),
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(5),
                                    onTap: () {
                                      Navigator.of(
                                        ConsultationSdk().navigatorKey
                                            .currentState!
                                            .context,
                                      ).pop();
                                      startCall(false);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: "Audio",
                                            fontSize: getWidth(16),
                                            textAlign: TextAlign.center,
                                            color: AppColors.mainColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(width: getWidth(10)),
                                          AnimatedRippleIcon(
                                            color: AppColors.mainColor,
                                            size: 24.0,
                                            child: Icon(
                                              Icons.call,
                                              size: 28,
                                              color: AppColors.mainColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: AppColors.greyBorderColor,
                                  ),
                                ),
                                child: Material(
                                  color: AppColors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(5),
                                    onTap: () {
                                      Navigator.of(
                                        ConsultationSdk()
                                            .navigatorKey
                                            .currentState!
                                            .context,
                                      ).pop();
                                      startCall(true);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: "Video",
                                            fontSize: getWidth(16),
                                            color: AppColors.mainColor,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(width: getWidth(10)),
                                          AnimatedRippleHorizontalIcon(
                                            color: AppColors.mainColor,
                                            size: 24.0,
                                            startAngle: 4,
                                            child: Icon(
                                              Icons.videocam,
                                              size: 28,
                                              color: AppColors.mainColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
