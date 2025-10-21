// import 'package:clinicall/app/core/app_colors.dart';
// import 'package:clinicall/app/core/app_icons.dart';
// import 'package:clinicall/app/core/app_images.dart';
// import 'package:clinicall/app/core/app_sizes.dart';
// import 'package:clinicall/app/core/app_text.dart';
// import 'package:clinicall/app/core/contants.dart';
// import 'package:clinicall/app/core/extensions.dart';
// import 'package:clinicall/app/global_methods/helper.dart';
// import 'package:clinicall/app/global_widgets/app_pinky_circle_gradient.dart';
// import 'package:clinicall/app/global_widgets/custom_image.dart';
// import 'package:clinicall/app/global_widgets/custom_text.dart';
// import 'package:clinicall/app/modules/signIn/controller/login_controller.dart';
// import 'package:clinicall/app/modules/user_app/account_pages/components/footer.dart';
// import 'package:clinicall/app/modules/user_app/packages/controller/service_package_controller.dart';
// import 'package:clinicall/app/modules/user_app/packages/model/active_health_card_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:consultation_sdk/src/core/app_colors.dart';
// import 'package:consultation_sdk/src/core/app_icons.dart';
// import 'package:consultation_sdk/src/core/app_images.dart';
// import 'package:consultation_sdk/src/core/app_sizes.dart';
// import 'package:consultation_sdk/src/core/helper.dart';
// import 'package:consultation_sdk/src/global_widget/app_pinky_circle_gradient.dart';
// import 'package:consultation_sdk/src/global_widget/custom_image.dart';
// import 'package:consultation_sdk/src/global_widget/custom_text.dart';
// import 'package:consultation_sdk/src/model/active_health_card_model.dart';
//
// class ActiveCardFrontPage extends StatelessWidget {
//   const ActiveCardFrontPage({super.key, required this.activeHealthCardModel});
//   final ActiveHealthCardModel activeHealthCardModel;
//
//   @override
//   Widget build(BuildContext context) {
//     bool isTelemedicine = activeHealthCardModel.packageModel.type == "telemedicine";
//     double cardHeight = screenWidth() * 0.52;
//     if(!isTelemedicine){
//       cardHeight = screenWidth() * 0.585;
//     }
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//         height: cardHeight,
//         width: screenWidth(),
//         margin: EdgeInsets.symmetric(
//             horizontal: getWidth(12), vertical: getWidth(12)),
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
//                 Expanded(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   left: isTelemedicine ? getWidth(8) : getWidth(16),
//                                   right: isTelemedicine ? getWidth(8) : getWidth(0),
//                                   top: isTelemedicine ? getWidth(8) : getWidth(16),
//                                   bottom: isTelemedicine ? getWidth(8) : getWidth(0)
//                               ),
//                               child: Row(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: getWidth(40),
//                                           vertical: getWidth(6),),
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: isTelemedicine ? AppColors.mainColor : AppColors.secondaryColor),
//                                             borderRadius:
//                                             BorderRadius.circular(
//                                                 getWidth(0))),
//                                         child: CustomText(
//                                           text: AppText().healthCard,
//                                           fontSize: getWidth(16),
//                                           color: AppColors.mainColor,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const Spacer(),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: isTelemedicine ? 0 : getWidth(10)),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: getWidth(isTelemedicine ? 12 : 20)),
//                               child: Column(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 children: [
//                                   CustomText(
//                                       text: Get.find<ServicePackageController>().user.fullName,
//                                       fontSize: getWidth(12),
//                                       fontWeight: FontWeight.w400),
//                                   CustomText(
//                                       text:
//                                       "${AppText().cardId}: ${activeHealthCardModel.healthCardId}"
//                                           .convertEnglishToBangla(),
//                                       fontSize: getWidth(12),
//                                       fontWeight: FontWeight.w400),
//                                   GetBuilder<LoginController>(
//                                     builder: (loginController) {
//                                       String type =
//                                           "${activeHealthCardModel.packageModel.type}";
//                                       if (loginController
//                                           .selectedLanguage
//                                           .value !=
//                                           "English" &&
//                                           activeHealthCardModel
//                                               .packageModel
//                                               .bnType!
//                                               .isNotEmpty) {
//                                         type =
//                                         "${activeHealthCardModel.packageModel.bnType}";
//                                       }
//                                       return CustomText(
//                                         text:
//                                         "${AppText().healthPackage}: ${type.capitalizeFirstLetter()}"
//                                             .convertEnglishToBangla(),
//                                         fontSize: getWidth(12),
//                                         fontWeight: FontWeight.w400,
//                                       );
//                                     },
//                                   ),
//                                   CustomText(
//                                       text:
//                                       "${AppText().validThru}:  ${dmyDateFormat.format(DateTime.parse(activeHealthCardModel.packageExpiredDate))}"
//                                           .convertEnglishToBangla(),
//                                       fontSize: getWidth(12),
//                                       fontWeight: FontWeight.w400),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Health Card Images
//                       Container(
//                         padding: EdgeInsets.only(right: getWidth(12)),
//                         width: screenWidth() * 0.35,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               height: getWidth(isTelemedicine ? 8 : 16),
//                             ),
//                             CustomImage(
//                               path: AppIcons.logoText,
//                               height: getWidth(18),
//                             ),
//                             Center(
//                               child: CustomText(
//                                 text: AppText().appDescription,
//                                 fontSize: getWidth(10),
//                                 color: AppColors.secondaryColor,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             Expanded(
//                               child: CustomImage(
//                                 path: AppImages.packageCardDoctor,
//                                 width: screenWidth() * (isTelemedicine ? 0.2 : 0.24),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //Footer-start
//                 const ActiveCardFooter()
//                 //Footer-end
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
