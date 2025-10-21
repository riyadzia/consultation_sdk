// import 'package:flutter/material.dart';
// import 'package:consultation_sdk/src/core/app_colors.dart';
// import 'package:consultation_sdk/src/global_widget/custom_text.dart';
//
// import '../../../../core/app_sizes.dart';
// import 'discount_partner_tag.dart';
//
// class ActiveCardFooter extends StatelessWidget {
//   const ActiveCardFooter({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         //Footer-start
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: getWidth(8)),
//           color: AppColors.mainColor,
//           height: getWidth(5),
//           width: screenWidth(),
//         ),
//         Padding(
//           padding: EdgeInsets.only(
//               left: getWidth(12),
//               right: getWidth(12),
//               top: getWidth(10)),
//           child: Row(
//             children: [
//               // Office Contact info
//               Container(
//                 padding: EdgeInsets.all(getWidth(3)),
//                 decoration: ShapeDecoration(
//                     shape: const CircleBorder(),
//                     color: AppColors.mainColor),
//                 child: Icon(
//                   Icons.call,
//                   size: getWidth(8),
//                   color: AppColors.white,
//                 ),
//               ),
//               SizedBox(
//                 width: getWidth(2),
//               ),
//               CustomText(
//                 text: "09677601050",
//                 fontSize: getWidth(8),
//                 color: AppColors.secondaryColor,
//                 fontWeight: FontWeight.w400,
//               ),
//               // Office Contact info
//               SizedBox(
//                 width: getWidth(0),
//               ),
//               const Spacer(),
//               Container(
//                 padding: EdgeInsets.all(getWidth(3)),
//                 decoration: ShapeDecoration(
//                     shape: const CircleBorder(),
//                     color: AppColors.mainColor),
//                 child: Icon(
//                   Icons.mail_outline,
//                   size: getWidth(8),
//                   color: AppColors.white,
//                 ),
//               ),
//               SizedBox(
//                 width: getWidth(2),
//               ),
//               CustomText(
//                 text: "customer.service@theclinicall.com",
//                 fontSize: getWidth(8),
//                 color: AppColors.secondaryColor,
//                 fontWeight: FontWeight.w400,
//               ),
//               const Spacer(),
//               // ClinicCall website
//               SizedBox(
//                 width: getWidth(0),
//               ),
//               Container(
//                 padding: EdgeInsets.all(getWidth(3)),
//                 decoration: ShapeDecoration(
//                     shape: const CircleBorder(),
//                     color: AppColors.mainColor),
//                 child: FaIcon(
//                   FontAwesomeIcons.globe,
//                   size: getWidth(8),
//                   color: AppColors.white,
//                 ),
//               ),
//               SizedBox(
//                 width: getWidth(2),
//               ),
//               CustomText(
//                 text: "www.theclinicall.com",
//                 fontSize: getWidth(8),
//                 color: AppColors.secondaryColor,
//                 fontWeight: FontWeight.w400,
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: getWidth(4),
//         ),
//         Padding(
//           padding: EdgeInsets.only(
//               left: getWidth(8),
//               right: getWidth(8),
//               bottom: getWidth(8)),
//           child: const DiscountPartnerTag(isShowConditionText: true),
//         ),
//         SizedBox(
//           height: getWidth(6),
//         ),
//         //Footer-end
//       ],
//     );
//   }
// }
