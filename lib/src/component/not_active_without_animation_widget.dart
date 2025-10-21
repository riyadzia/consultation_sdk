import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/contants.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';

class NotActiveWithoutAnimationWidget extends StatelessWidget {
  const NotActiveWithoutAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              5),
          color: AppColors.white,
          boxShadow: defaultBoxShadow()
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.white,
        child: InkWell(
          onTap: () {
            // Get.find<ServicePackageController>().isFromGift = false;
            // Get.toNamed(Routes.allPackagesScreen);
          },
          borderRadius: BorderRadius.circular(
              5),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(10),
                vertical: getWidth(10)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomText(text: "Buy Health Package",
                        fontSize: getWidth(14),
                        fontWeight: FontWeight.w500
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CustomText(text: "Cashback up to BDT 200K on hospitalization *",
                          fontSize: getWidth(10),
                          textAlign: TextAlign
                              .center,
                          color: Colors.black54,
                          maxLines: 2,
                          overflow: TextOverflow
                              .ellipsis,
                          fontWeight: FontWeight
                              .w600
                      ),
                    ),
                  ],
                ),
                // const Positioned(
                //   right: 0,
                //   child:
                //   Icon(Icons.arrow_forward_ios,
                //     size: 16,),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
