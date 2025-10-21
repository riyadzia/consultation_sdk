// import 'package:clinicall/app/core/app_colors.dart';
// import 'package:clinicall/app/core/app_sizes.dart';
// import 'package:clinicall/app/core/app_text.dart';
// import 'package:clinicall/app/global_widgets/app_pinky_circle_gradient.dart';
// import 'package:clinicall/app/global_widgets/custom_button.dart';
// import 'package:clinicall/app/global_widgets/custom_text.dart';
// import 'package:clinicall/app/global_widgets/page_back__border_button.dart';
// import 'package:clinicall/app/global_widgets/page_refresh.dart';
// import 'package:clinicall/app/modules/user_app/account_pages/components/active_card.dart';
// import 'package:clinicall/app/modules/user_app/packages/controller/service_package_controller.dart';
// import 'package:clinicall/app/routes/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ActivePackageCardScreen extends GetView<ServicePackageController> {
//   const ActivePackageCardScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: PageRefresh(
//         onRefresh: controller.getActiveHealthCard,
//         child: CustomScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//           slivers: [
//             SliverAppBar(
//               centerTitle: false,
//               title: CustomText(
//                 text: "${AppText().activeBn} ${AppText().healthCard}",
//                 fontWeight: FontWeight.w600,
//                 fontSize: getWidth(16),
//                 color: AppColors.secondaryColor,
//               ),
//               leading: const PageBackBorderButton(),
//               surfaceTintColor: AppColors.transparent,
//               // pinned: false,
//               // floating: true,
//               expandedHeight: getWidth(100),
//               flexibleSpace: const AppPinkyCircleGradient(),
//               actions: [
//                 // const NotificationCircleBorderIcon(),
//                 SizedBox(
//                   width: getWidth(16),
//                 )
//               ],
//             ),
//             SliverToBoxAdapter(
//               child: Obx(() {
//                 if(!controller.isCardActiveForShow){
//                   return Padding(
//                     padding: EdgeInsets.symmetric(horizontal: getWidth(16),vertical: getWidth(30)),
//                     child: Column(
//                       children: [
//                         CustomText(text: "You didn't buy any package, please buy a package to open all our services. Thank you", fontSize: getWidth(14),
//                             textAlign: TextAlign.center,
//                             fontWeight: FontWeight.w400),
//                         SizedBox(height: getWidth(16),),
//                         CustomButton(
//                             title: AppText().buyPackage,
//                             color: AppColors.mainColor,
//                             verticalPadding: 8,
//                             fontSize: getWidth(15),
//                             onTap: () async {
//                               Get.toNamed(Routes.allPackagesScreen);
//                             }),
//                       ],
//                     ),
//                   );
//                 }
//                 return const ActiveCard();
//               }),
//             ),
//             SliverToBoxAdapter(
//               child: SizedBox(height: getWidth(50),),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
