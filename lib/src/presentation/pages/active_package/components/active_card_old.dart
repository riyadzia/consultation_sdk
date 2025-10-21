// import 'package:clinicall/app/core/app_colors.dart';
// import 'package:clinicall/app/core/app_sizes.dart';
// import 'package:clinicall/app/core/app_text.dart';
// import 'package:clinicall/app/core/contants.dart';
// import 'package:clinicall/app/core/extensions.dart';
// import 'package:clinicall/app/global_widgets/custom_image.dart';
// import 'package:clinicall/app/global_widgets/custom_text.dart';
// import 'package:clinicall/app/modules/user_app/packages/controller/service_package_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../core/app_images.dart';
//
// class ActiveCardOld extends GetView<ServicePackageController> {
//   const ActiveCardOld({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Container(
//             margin: EdgeInsets.symmetric(
//                 horizontal: getWidth(12), vertical: getWidth(12)),
//             decoration: BoxDecoration(
//                 color: const Color(0xffF6DCDC),
//                 // border: Border.all(color: Color(0xffFF8080)),
//                 borderRadius: BorderRadius.circular(getWidth(15)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.09),
//                     blurRadius: 11.9,
//                     offset: Offset(0, getWidth(4)),
//                   )
//                 ]),
//             child: Stack(
//               children: [
//                 Positioned(
//                   right: -getWidth(60),
//                   top: getWidth(20),
//                   child: Container(
//                     height: getWidth(140),
//                     width: getWidth(140),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                             blurRadius: 100,
//                             offset: const Offset(0, 0),
//                             color: AppColors.mainColor.withValues(alpha: 0.17))
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     top: -getWidth(50),
//                     left: 0,
//                     bottom: 0,
//                     child: const Opacity(
//                         opacity: 0.3,
//                         child: CustomImage(
//                             path: AppImages.packageVector3))),
//                 Positioned(
//                     top: getWidth(0),
//                     left: 100,
//                     bottom: 20,
//                     child: const Opacity(
//                         opacity: 0.3,
//                         child: CustomImage(
//                             path: AppImages.packageVector2))),
//                 Positioned(
//                     top: getWidth(50),
//                     left: 100,
//                     child: const Opacity(
//                         opacity: 1,
//                         child: CustomImage(
//                             path: AppImages.packageVector1))),
//                 Positioned(
//                     right: -getWidth(1),
//                     bottom: -getWidth(1),
//                     child: const Opacity(
//                         opacity: 0.3,
//                         child: CustomImage(
//                             path: AppImages.packageVector5))),
//                 IntrinsicHeight(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           children: [
//                             // title and save amount
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: getWidth(12),
//                                   vertical: getWidth(10)
//                               ),
//                               child: CustomText(
//                                   text:
//                                   "${controller.activeHealthCard.value
//                                       ?.packageModel.type}",
//                                   textAlign: TextAlign.start,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   fontSize: getWidth(14),
//                                   fontWeight:
//                                   FontWeight.w400
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: getWidth(8),
//                                   vertical: getWidth(6)
//                               ),
//                               decoration: BoxDecoration(
//                                   color: const Color(0xffEB148C)
//                                       .withValues(alpha: 0.7)
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.start,
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.center,
//                                 children: [
//                                   CustomText(
//                                       text:
//                                       "${AppText().bdt} ${controller.activeHealthCard
//                                           .value
//                                           ?.packageModel.packageVariation?.sellingPrice
//                                           ?.toStringAsFixed(
//                                           0)}".convertEnglishToBangla(),
//                                       maxLines: 1,
//                                       overflow:
//                                       TextOverflow.ellipsis,
//                                       fontSize: getWidth(13),
//                                       color:
//                                       AppColors.white,
//                                       fontWeight: FontWeight.w600),
//                                   CustomText(
//                                       text: "/${controller
//                                           .activeHealthCard.value
//                                           ?.packageModel.packageVariation?.duration}",
//                                       fontSize: getWidth(12),
//                                       color: AppColors.white,
//                                       fontWeight: FontWeight.w400),
//                                   const Spacer(),
//                                   Container(
//                                     height: getWidth(35),
//                                     alignment: Alignment.center,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: getWidth(10),
//                                         vertical: getWidth(0)),
//                                     decoration: BoxDecoration(
//                                       color: AppColors.white,
//                                       borderRadius:
//                                       BorderRadius.circular(
//                                           getWidth(6)),
//                                     ),
//                                     child: CustomText(
//                                         text: "Save ${controller
//                                             .activeHealthCard.value
//                                             ?.packageModel.packageVariation?.saveAmount
//                                             ?.toStringAsFixed(0)}%".convertEnglishToBangla(),
//                                         fontSize: getWidth(10),
//                                         fontWeight:
//                                         FontWeight.w400),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: getWidth(20),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: getWidth(
//                                       12)),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment
//                                     .start,
//                                 children: [
//                                   CustomText(
//                                       text: controller.user.fullName,
//                                       fontSize: getWidth(15),
//                                       fontWeight: FontWeight.w400),
//                                   CustomText(text: "${AppText().cardId}: ${controller
//                                       .activeHealthCard.value
//                                       ?.healthCardId}",
//                                       fontSize: getWidth(14),
//                                       fontWeight: FontWeight.w400),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: getWidth(30),
//                             ),
//                             // todo add valid thru
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: getWidth(
//                                       12)),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment
//                                     .start,
//                                 children: [
//                                   CustomText(text: AppText().validThru,
//                                       fontSize: getWidth(14),
//                                       fontWeight: FontWeight.w400),
//                                   CustomText(text: mdyDateFormat.format(
//                                       DateTime.parse(
//                                           controller.activeHealthCard
//                                               .value!
//                                               .packageExpiredDate)).convertEnglishToBangla(),
//                                       fontSize: getWidth(14),
//                                       fontWeight: FontWeight.w400),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: getWidth(8),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Health Card Images
//                       SizedBox(
//                         width: screenWidth() * 0.28,
//                         child: Stack(
//                           alignment: Alignment.bottomCenter,
//                           fit: StackFit.passthrough,
//                           children: [
//                             // Card right Colored Background
//                             Positioned(
//                               top: 0,
//                               right: 0,
//                               bottom: 0,
//                               left: 0,
//                               child: ClipRRect(
//                                 borderRadius: const BorderRadius
//                                     .horizontal(
//                                     right: Radius.circular(10)),
//                                 child: CustomImage(
//                                   path: AppImages.packageBack,
//                                   width: screenWidth() * 0.28,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             // Women Image
//                             Positioned(
//                               bottom: 0,
//                               child: CustomImage(
//                                 path: AppImages.packageCardWomen,
//                                 // height: getWidth(150),
//                                 width: screenWidth() * 0.25,
//                               ),
//                             ),
//                             // Text Image
//                             Positioned(
//                               top: getWidth(10),
//                               left: getWidth(10),
//                               child: CustomImage(
//                                 path: AppImages.healthSolutionText,
//                                 height: getWidth(50),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: getWidth(12),),
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: getWidth(16)),
//           decoration: BoxDecoration(
//               color: const Color(0xffF6DCDC),
//               // border: Border.all(color: Color(0xffFF8080)),
//               borderRadius: BorderRadius.circular(getWidth(15)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.09),
//                   blurRadius: 11.9,
//                   offset: Offset(0, getWidth(4)),
//                 )
//               ]),
//           child: Stack(
//             children: [
//               Positioned(
//                 right: -getWidth(60),
//                 top: getWidth(20),
//                 child: Container(
//                   height: getWidth(140),
//                   width: getWidth(140),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                           blurRadius: 100,
//                           offset: const Offset(0, 0),
//                           color: AppColors.mainColor.withValues(alpha: 0.17))
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                   top: -getWidth(50),
//                   left: 0,
//                   bottom: 0,
//                   child: const Opacity(
//                       opacity: 0.3,
//                       child:
//                       CustomImage(path: AppImages.packageVector3))),
//               Positioned(
//                   top: getWidth(0),
//                   left: 100,
//                   bottom: 20,
//                   child: const Opacity(
//                       opacity: 0.3,
//                       child:
//                       CustomImage(path: AppImages.packageVector2))),
//               Positioned(
//                   top: getWidth(50),
//                   left: 100,
//                   child: const Opacity(
//                       opacity: 1,
//                       child:
//                       CustomImage(path: AppImages.packageVector1))),
//               Positioned(
//                   right: -getWidth(1),
//                   bottom: -getWidth(1),
//                   child: const Opacity(
//                       opacity: 0.3,
//                       child:
//                       CustomImage(path: AppImages.packageVector5))),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: getWidth(16),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: getWidth(16)),
//                     child: CustomText(
//                         text: "${controller.activeHealthCard.value
//                             ?.packageModel.packageVariation?.title}",
//                         fontSize: getWidth(16),
//                         fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: getWidth(16),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: getWidth(16),
//                         vertical: getWidth(10)
//                     ),
//                     decoration: BoxDecoration(
//                         color: const Color(0xffEB148C).withValues(alpha: 0.7)
//                     ),
//                     child: Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.start,
//                       crossAxisAlignment:
//                       CrossAxisAlignment.center,
//                       children: [
//                         CustomText(
//                             text:
//                             "${AppText().bdt} ${controller.activeHealthCard.value
//                                 ?.packageModel.packageVariation?.sellingPrice?.toStringAsFixed(
//                                 0)}",
//                             maxLines: 1,
//                             overflow:
//                             TextOverflow.ellipsis,
//                             fontSize: getWidth(14),
//                             color:
//                             AppColors.white,
//                             fontWeight: FontWeight.w600),
//                         CustomText(
//                             text: "/${controller.activeHealthCard.value
//                                 ?.packageModel.packageVariation?.duration}",
//                             fontSize: getWidth(13),
//                             color: AppColors.white,
//                             fontWeight: FontWeight.w400),
//                         const Spacer(),
//                         Container(
//                           height: getWidth(35),
//                           alignment: Alignment.center,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: getWidth(10),
//                               vertical: getWidth(0)),
//                           decoration: BoxDecoration(
//                             color: AppColors.white,
//                             borderRadius:
//                             BorderRadius.circular(
//                                 getWidth(6)),
//                           ),
//                           child: CustomText(
//                               text: "Save ${controller.activeHealthCard
//                                   .value
//                                   ?.packageModel.packageVariation?.saveAmount
//                                   ?.toStringAsFixed(0)}%".convertEnglishToBangla(),
//                               fontSize: getWidth(13),
//                               fontWeight:
//                               FontWeight.w400),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: getWidth(20),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: getWidth(12)),
//                     child: CustomText(
//                         text: AppText().termsConditions,
//                         fontSize: getWidth(16),
//                         fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: getWidth(8),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: getWidth(12)),
//                     child: CustomText(
//                         text:
//                         "${controller.activeHealthCard.value?.packageModel
//                             .tac}",
//                         fontSize: getWidth(14),
//                         fontWeight: FontWeight.w400),
//                   ),
//                   SizedBox(
//                     height: getWidth(12),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: getWidth(30),),
//         // Padding(
//         //   padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
//         //   child: CustomButton(
//         //       title: "Download Card",
//         //       color: AppColors.mainColor,
//         //       borderRadius: getWidth(5),
//         //       verticalPadding: getWidth(8),
//         //       fontSize: getWidth(14),
//         //       fontWeight: FontWeight.w500,
//         //       onTap: () {}),
//         // ),
//       ],
//     );
//   }
// }
