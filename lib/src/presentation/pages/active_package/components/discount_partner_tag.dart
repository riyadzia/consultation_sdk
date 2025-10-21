// import 'package:clinicall/app/core/app_colors.dart';
// import 'package:clinicall/app/core/app_images.dart';
// import 'package:clinicall/app/core/app_sizes.dart';
// import 'package:clinicall/app/core/app_text.dart';
// import 'package:clinicall/app/global_widgets/custom_image.dart';
// import 'package:clinicall/app/global_widgets/custom_text.dart';
// import 'package:clinicall/app/modules/signIn/controller/login_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:consultation_sdk/src/core/app_colors.dart';
// import 'package:consultation_sdk/src/core/app_images.dart';
// import 'package:consultation_sdk/src/core/app_sizes.dart';
// import 'package:consultation_sdk/src/global_widget/custom_text.dart';
//
// class DiscountPartnerTag extends StatelessWidget {
//   const DiscountPartnerTag({super.key, required this.isShowConditionText});
//   final bool isShowConditionText;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           if(isShowConditionText)...[
//             CustomText(
//               text: AppText().conditionApply,
//               textAlign: TextAlign.center,
//               fontSize: getWidth(8),
//               color: AppColors.secondaryColor,
//               fontWeight: FontWeight.w400,
//             ),
//           ],
//           const Spacer(),
//           CustomText(
//             text: "${AppText().discountPartner}:  ",
//             textAlign: TextAlign.center,
//             fontSize: getWidth(8),
//             color: AppColors.secondaryColor,
//             fontWeight: FontWeight.w400,
//           ),
//           GetBuilder<LoginController>(
//             builder: (loginController) {
//               return CustomImage(
//                 path:
//                 loginController.selectedLanguage.value ==
//                     "English"
//                     ? AppImages.pragatiEn
//                     : AppImages.pragatiBn,
//                 height: getWidth(16),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
