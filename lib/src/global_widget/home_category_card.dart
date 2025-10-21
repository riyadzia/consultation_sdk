import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/contants.dart';
import 'package:consultation_sdk/src/global_widget/custom_image.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';

class HomeCategoryCard extends StatelessWidget {
  const HomeCategoryCard(
      {super.key, required this.categoryName, required this.slogan, required this.icon, required this.onPressed});

  final String categoryName;
  final String slogan;
  final String icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getWidth(10)),
        border: Border.all(color: AppColors.travelBorderColor.withValues(alpha: 1),),
        boxShadow: defaultBoxShadow(),
      ),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getWidth(10)),
        child: InkWell(
          highlightColor: AppColors.mainColor.withValues(alpha: 0.07),
          onTap: () => onPressed(),
          borderRadius: BorderRadius.circular(getWidth(10)),
          child: Padding(
            padding: EdgeInsets.all(getWidth(6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.mainColor.withValues(alpha: 0.00),
                  radius: getWidth(28),
                  child: Center(
                    child: CustomImage(path: icon,
                      height: getWidth(36),width: getWidth(36),
                    ),
                  ),
                ),
                // GetBuilder<LoginController>(builder: (loginController) {
                //   return CustomText(text: categoryName,
                //       fontSize: getWidth(14),
                //       fontWeight: loginController.selectedLanguage.value == "English"
                //           ? FontWeight.w500 : FontWeight.w600
                //   );
                // }),
                CustomText(text: categoryName,
                    fontSize: getWidth(14),
                    fontWeight: FontWeight.w500
                ),
                SizedBox(height: getWidth(0),),
                CustomText(text: slogan,
                    fontSize: getWidth(10),
                    textAlign: TextAlign.center,
                    color: Colors.black54,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                  isOnlySolimani: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
