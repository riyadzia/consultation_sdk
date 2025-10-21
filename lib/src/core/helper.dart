import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_images.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/global_widget/app_pinky_circle_gradient.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';

class Helper {
  static Color getCategoryColor(int index) {
    int x = index % categoryColors.length;
    return categoryColors[x];
  }

  static Map<String, int> getListReference(List<String> list) {
    Map<String, int> referenceIndexMap = {};
    for (int i = 0; i < list.length; i++) {
      referenceIndexMap[list[i]] = i;
    }
    return referenceIndexMap;
  }

  /// for package background
  static String getPackageBackground(String type) {
    switch (type) {
      case "telemedicine":
        return AppImages.telemedicinePackageSmall;
      case "bronze":
        return AppImages.bronzePackageSmall;
      case "silver":
        return AppImages.silverPackageSmall;
      case "gold":
        return AppImages.goldPackageSmall;
      default:
        return AppImages.bronzePackageSmall;
    }
  }

  /// for package background
  static String getPackageBackgroundOld(String type) {
    switch (type) {
      case "telemedicine":
      return AppImages.bronzePackage;
      case "bronze":
      return AppImages.bronzePackage;
      case "silver":
      return AppImages.silverPackage;
      case "gold":
      return AppImages.goldPackage;
      default:
      return AppImages.bronzePackage;
    }
  }

  /// for call type
  static bool isVideoCall(int? data) {
    if (data == null) {
      return true;
    }
    if (data == 1) {
      return true;
    } else {
      return false;
    }
  }

  /// for package button background
  static String getPackageButtonBackground(String type) {
    switch (type) {
      case "bronze":
        return AppImages.bronzeButtonBack;
      case "silver":
        return AppImages.silverButtonBack;
      case "gold":
        return AppImages.goldButtonBack;
      default:
        return AppImages.bronzeButtonBack;
    }
  }

  static Future<bool> customAlertDialog(BuildContext context,
      {String title = "",
      String message = "",
      String cancelButtonText = "",
        double? height,
      String okButtonText = ""}) async {
    return await (Utils.showCustomDialog(
          context,
          barrierDismissible: false,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: const EdgeInsets.all(16.0),
              height: height ?? screenWidth() * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const AppPinkyCircleGradient()),
                  Material(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: getWidth(8),
                            width: screenWidth(),
                          ),
                          CustomText(
                              text: title,
                              fontSize: getWidth(18),
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600),
                          SizedBox(height: getWidth(10),),
                          CustomText(
                              text: message,
                              fontSize: getWidth(14),
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: getWidth(20),
                          ),
                          Row(
                            children: [
                              if (cancelButtonText.isNotEmpty) ...[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // color: AppColors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: AppColors.greyBorderColor)),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        onTap: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                  text: cancelButtonText,
                                                  fontSize: getWidth(16),
                                                  textAlign: TextAlign.center,
                                                  color: AppColors.mainColor,
                                                  fontWeight: FontWeight.w600),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                              ],
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      // color: AppColors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: AppColors.greyBorderColor)),
                                  child: Material(
                                    color: AppColors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(5),
                                      onTap: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                                text: okButtonText,
                                                fontSize: getWidth(16),
                                                color: AppColors.mainColor,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w600),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )) ??
        false;
  }
}

List<Color> categoryColors = [
  const Color(0xff8B5CF6),
  const Color(0xff9BB167),
  const Color(0xffF43F5E),
  const Color(0xffEAB308),
  const Color(0xffFB8728),
  const Color(0xffEAB308),
];
