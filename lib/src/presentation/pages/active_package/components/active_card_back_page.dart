// import 'package:clinicall/app/core/app_colors.dart';
// import 'package:clinicall/app/core/app_icons.dart';
// import 'package:clinicall/app/core/app_sizes.dart';
// import 'package:clinicall/app/core/app_text.dart';
// import 'package:clinicall/app/global_methods/helper.dart';
// import 'package:clinicall/app/global_widgets/app_pinky_circle_gradient.dart';
// import 'package:clinicall/app/global_widgets/custom_image.dart';
// import 'package:clinicall/app/global_widgets/custom_text.dart';
// import 'package:clinicall/app/modules/user_app/account_pages/components/discount_partner_tag.dart';
// import 'package:clinicall/app/modules/user_app/packages/controller/service_package_controller.dart';
// import 'package:clinicall/app/modules/user_app/packages/model/active_health_card_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:consultation_sdk/src/core/app_colors.dart';
// import 'package:consultation_sdk/src/core/app_sizes.dart';
// import 'package:consultation_sdk/src/core/helper.dart';
// import 'package:consultation_sdk/src/global_widget/app_pinky_circle_gradient.dart';
// import 'package:consultation_sdk/src/global_widget/custom_image.dart';
// import 'package:consultation_sdk/src/global_widget/custom_text.dart';
// import 'package:consultation_sdk/src/model/active_health_card_model.dart';
//
// class ActiveCardBackPage extends StatelessWidget {
//   const ActiveCardBackPage({super.key, required this.activeHealthCardModel});
//   final ActiveHealthCardModel activeHealthCardModel;
//
//   @override
//   Widget build(BuildContext context) {
//     bool isTelemedicine = activeHealthCardModel.packageModel.type == "telemedicine";
//     double cardHeight = screenWidth() * 0.52;
//     if(!isTelemedicine){
//       cardHeight = screenWidth() * 0.585;
//     }
//
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(getWidth(10)),
//       child: Container(
//         height: cardHeight,
//         width: screenWidth(),
//         margin: EdgeInsets.symmetric(
//             horizontal: getWidth(12), vertical: getWidth(0)),
//         decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(getWidth(15)),
//             boxShadow: [
//               if(isTelemedicine)...[
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.09),
//                   blurRadius: 11.9,
//                   offset: Offset(0, getWidth(4)),
//                 )
//               ]
//             ]),
//         child: Stack(
//           children: [
//             Builder(
//               builder: (context) {
//                 if(isTelemedicine){
//                   return ClipRRect(
//                       borderRadius: BorderRadius.circular(getWidth(10)),
//                       child: const AppPinkyCircleGradient());
//                 } else {
//                   return CustomImage(
//                     path: Helper.getPackageBackgroundOld(activeHealthCardModel.packageModel.type ??
//                         ""),
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   );
//                 }
//               },
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: isTelemedicine ? getWidth(10) : getWidth(16),
//                       right: isTelemedicine ? getWidth(10) : getWidth(16),
//                       top: isTelemedicine ? getWidth(8) : getWidth(12),
//                       bottom: isTelemedicine ? getWidth(8) : getWidth(0)
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.max,
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           CustomText(
//                             text: AppText().healthCard,
//                             fontSize: getWidth(15),
//                             color: AppColors.mainColor,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           const Spacer(),
//                           Column(
//                             children: [
//                               CustomImage(
//                                 path: AppIcons.logoText,
//                                 height: getWidth(18),
//                               ),
//                               Center(
//                                 child: CustomText(
//                                   text: AppText().appDescription,
//                                   fontSize: getWidth(10),
//                                   color: AppColors.secondaryColor,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//
//                       /// Package Details
//                       // CustomText(text: AppText().cardBenefits,
//                       //   fontSize: getWidth(10),
//                       //   color: AppColors.secondaryColor,
//                       //   fontWeight: FontWeight.w600,),
//                       // ...List.generate(packageBenefits.length, (index){
//                       //   return  CustomText(text: "• ${packageBenefits[index].tr}",
//                       //     fontSize: getWidth(10),
//                       //     color: AppColors.secondaryColor,
//                       //     fontWeight: FontWeight.w400,);
//                       // }),
//
//                       /// Terms & Condition
//                       SizedBox(
//                         height: getWidth(6),
//                       ),
//                       CustomText(
//                         text: AppText().termsConditions,
//                         fontSize: getWidth(10),
//                         color: AppColors.secondaryColor,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       ...List.generate(packageTermsConditions.length,
//                               (index) {
//                             return CustomText(
//                               text: "• ${packageTermsConditions[index].tr}",
//                               fontSize: getWidth(10),
//                               color: AppColors.secondaryColor,
//                               fontWeight: FontWeight.w400,
//                             );
//                           }),
//                     ],
//                   ),
//                 ),
//                 //Footer
//                 const Spacer(),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         left: getWidth(isTelemedicine ? 0 : 8), right: getWidth(isTelemedicine ? 0 : 8),bottom: getWidth(isTelemedicine ? 0 : 12)),
//                     child: const DiscountPartnerTag(isShowConditionText: false),
//                   ),
//                 ),
//                 SizedBox(
//                   height: getWidth(isTelemedicine ? 8 : 0),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
