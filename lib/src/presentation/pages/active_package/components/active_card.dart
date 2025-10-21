// import 'package:clinicall/app/core/app_sizes.dart';
// import 'package:clinicall/app/modules/user_app/account_pages/components/active_card_back_page.dart';
// import 'package:clinicall/app/modules/user_app/account_pages/components/active_card_front_page.dart';
// import 'package:clinicall/app/modules/user_app/packages/controller/service_package_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ActiveCard extends GetView<ServicePackageController> {
//   const ActiveCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ActiveCardFrontPage(
//           activeHealthCardModel: controller.activeHealthCard.value!,
//         ),
//         // SizedBox(height: getWidth(12)),
//         // Back Page
//         ActiveCardBackPage(
//           activeHealthCardModel: controller.activeHealthCard.value!,
//         ),
//         SizedBox(height: getWidth(30)),
//
//         // todo: Member add
//         // Container(
//         //   margin: EdgeInsets.symmetric(horizontal: getWidth(16),vertical: getWidth(16)),
//         //   padding: EdgeInsets.only(left: getWidth(12),top: getWidth(12),bottom: getWidth(12)),
//         //   decoration: BoxDecoration(
//         //     borderRadius: BorderRadius.circular(getWidth(10)),
//         //     border: Border.all(color: const Color(0xffC2A44F)),
//         //   ),
//         //   child: Row(
//         //     children: [
//         //       Container(
//         //         height: getWidth(50),
//         //         width: getWidth(50),
//         //         decoration: BoxDecoration(
//         //           borderRadius: BorderRadius.circular(getWidth(5)),
//         //         ),
//         //         child: Stack(
//         //           alignment: Alignment.center,
//         //           children: [
//         //             ClipRRect(
//         //               borderRadius: BorderRadius.circular(getWidth(5)),
//         //               child: CustomImage(
//         //                   path: AppImages.goldButtonBack,
//         //                 height: getWidth(50),
//         //                 width: getWidth(50),
//         //                 fit: BoxFit.cover,
//         //               )
//         //             ),
//         //             const Icon(Icons.person_outlined)
//         //           ],
//         //         ),
//         //       ),
//         //       SizedBox(width: getWidth(8),),
//         //       Expanded(
//         //         child: Column(
//         //           crossAxisAlignment: CrossAxisAlignment.start,
//         //           children: [
//         //             CustomText(text: "Name: _______________", fontSize: getWidth(14)),
//         //             SizedBox(height: getWidth(8),),
//         //             CustomText(text: "Relation: _____________", fontSize: getWidth(14)),
//         //           ],
//         //         ),
//         //       ),
//         //       Container(
//         //         decoration: BoxDecoration(
//         //           color: AppColors.white,
//         //           borderRadius: BorderRadius.horizontal(left: Radius.circular(getWidth(30))),
//         //           border: const Border(
//         //             top: BorderSide(color: Color(0xffC2A44F),),
//         //             left: BorderSide(color: Color(0xffC2A44F),),
//         //             bottom: BorderSide(color: Color(0xffC2A44F),),
//         //             right: BorderSide.none, // No border here
//         //           ),
//         //         ),
//         //         child: Material(
//         //           color: AppColors.white,
//         //             borderRadius: BorderRadius.horizontal(left: Radius.circular(getWidth(30))),
//         //             child: InkWell(
//         //                 borderRadius: BorderRadius.horizontal(left: Radius.circular(getWidth(30))),
//         //                 onTap: (){},
//         //                 child: Padding(
//         //                   padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
//         //                   child: Icon(Icons.add),
//         //                 ))),
//         //       )
//         //     ],
//         //   ),
//         // ),
//         // Container(
//         //   margin: EdgeInsets.symmetric(horizontal: getWidth(16),vertical: getWidth(16)),
//         //   padding: EdgeInsets.only(left: getWidth(12),top: getWidth(12),bottom: getWidth(12)),
//         //   decoration: BoxDecoration(
//         //     borderRadius: BorderRadius.circular(getWidth(10)),
//         //     border: Border.all(color: const Color(0xffC2A44F)),
//         //   ),
//         //   child: Row(
//         //     children: [
//         //       Container(
//         //         height: getWidth(50),
//         //         width: getWidth(50),
//         //         decoration: BoxDecoration(
//         //           borderRadius: BorderRadius.circular(getWidth(5)),
//         //         ),
//         //         child: Stack(
//         //           alignment: Alignment.center,
//         //           children: [
//         //             ClipRRect(
//         //               borderRadius: BorderRadius.circular(getWidth(5)),
//         //               child: CustomImage(
//         //                   path: AppImages.goldButtonBack,
//         //                 height: getWidth(50),
//         //                 width: getWidth(50),
//         //                 fit: BoxFit.cover,
//         //               )
//         //             ),
//         //             const Icon(Icons.person_outlined)
//         //           ],
//         //         ),
//         //       ),
//         //       SizedBox(width: getWidth(8),),
//         //       Expanded(
//         //         child: Column(
//         //           crossAxisAlignment: CrossAxisAlignment.start,
//         //           children: [
//         //             CustomEditText().figmaTextField(
//         //               TextEditingController(),
//         //               AppText().name,
//         //               TextInputType.text,
//         //               height: getWidth(50),
//         //               borderColor: AppColors.travelBorderColor,
//         //               borderRadius: 5,
//         //               isShadow: false,
//         //               // prefixIcon: CustomImage(
//         //               //   path: AppIcons.account,
//         //               //   height: getWidth(18),
//         //               //   width: getWidth(22),
//         //               // ),
//         //               inputAction: TextInputAction.next,
//         //             ),
//         //             SizedBox(height: getWidth(8),),
//         //             SizedBox(
//         //               height: getWidth(50),
//         //               child: DropdownButtonFormField<String>(
//         //                 dropdownColor: AppColors.light5,
//         //                 value: "Parents",
//         //                 padding: EdgeInsets.zero,
//         //                 borderRadius: BorderRadius.circular(
//         //                     getWidth(10)),
//         //                 icon: const Icon(Icons.keyboard_arrow_down),
//         //                 // underline: const SizedBox.shrink(),
//         //                 hint: CustomText(
//         //                     text: "${AppText().select} ${AppText()
//         //                         .gender}",
//         //                     color: AppColors.travelBorderColor,
//         //                     fontSize: getWidth(14),
//         //                     fontWeight: FontWeight.w500),
//         //                 items: ["Parents", "Children"]
//         //                     .map<DropdownMenuItem<String>>((
//         //                     String value) {
//         //                   return DropdownMenuItem<String>(
//         //                     value: value,
//         //                     child: CustomText(
//         //                         color: value ==
//         //                             "Parents"
//         //                             ? AppColors.greyTextColor2
//         //                             : AppColors.secondaryColor,
//         //                         text: value,
//         //                         fontSize: getWidth(14)),
//         //                   );
//         //                 }).toList(),
//         //                 onChanged: (value) {
//         //                   // controller.patientCondition(value);
//         //                 },
//         //                 selectedItemBuilder: (context) =>
//         //                     [
//         //                       "Parents",
//         //                       "Children"
//         //                     ].map<DropdownMenuItem<String>>((
//         //                         String value) {
//         //                       return DropdownMenuItem<String>(
//         //                         value: value,
//         //                         child: CustomText(
//         //                             text: value,
//         //                             fontSize: getWidth(14)),
//         //                       );
//         //                     }).toList(),
//         //                 decoration: InputDecoration(
//         //                   fillColor: AppColors.white,
//         //                   filled: true,
//         //                   contentPadding: EdgeInsets.symmetric(horizontal: getWidth(16)),
//         //                   border: OutlineInputBorder(
//         //                     borderRadius: BorderRadius.circular(5),
//         //                     borderSide: BorderSide(
//         //                         color: AppColors.greyBorderColor),
//         //                   ),
//         //                   enabledBorder: OutlineInputBorder(
//         //                     borderRadius: BorderRadius.circular(5),
//         //                     borderSide: BorderSide(
//         //                         color: AppColors.travelBorderColor),
//         //                   ),
//         //                   disabledBorder: InputBorder.none,
//         //                   errorBorder: OutlineInputBorder(
//         //                     borderRadius: BorderRadius.circular(
//         //                         CupertinoContextMenu
//         //                             .kOpenBorderRadius),
//         //                     borderSide: BorderSide(
//         //                         color: AppColors.red),
//         //                   ),
//         //                   focusedBorder: OutlineInputBorder(
//         //                     borderRadius: BorderRadius.circular(5),
//         //                     borderSide: BorderSide(
//         //                         color: AppColors.travelBorderColor),
//         //                   ),
//         //                   focusedErrorBorder: OutlineInputBorder(
//         //                     borderRadius: BorderRadius.circular(5),
//         //                     borderSide: BorderSide(
//         //                         color: AppColors.red),
//         //                   ),
//         //                 ),
//         //               ),
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //       SizedBox(width: getWidth(8),),
//         //       Container(
//         //         decoration: BoxDecoration(
//         //           color: AppColors.white,
//         //           borderRadius: BorderRadius.horizontal(left: Radius.circular(getWidth(30))),
//         //           border: const Border(
//         //             top: BorderSide(color: Color(0xffC2A44F),),
//         //             left: BorderSide(color: Color(0xffC2A44F),),
//         //             bottom: BorderSide(color: Color(0xffC2A44F),),
//         //             right: BorderSide.none, // No border here
//         //           ),
//         //         ),
//         //         child: Material(
//         //           color: AppColors.white,
//         //             borderRadius: BorderRadius.horizontal(left: Radius.circular(getWidth(30))),
//         //             child: InkWell(
//         //                 borderRadius: BorderRadius.horizontal(left: Radius.circular(getWidth(30))),
//         //                 onTap: (){},
//         //                 child: Padding(
//         //                   padding: EdgeInsets.symmetric(horizontal: getWidth(16),vertical: getWidth(3)),
//         //                   child: CustomText(text: "Save", fontSize: getWidth(14)),
//         //                 ))),
//         //       )
//         //     ],
//         //   ),
//         // ),
//         // Container(
//         //   margin: EdgeInsets.symmetric(horizontal: getWidth(16),vertical: getWidth(16)),
//         //   padding: EdgeInsets.only(left: getWidth(12),top: getWidth(12),bottom: getWidth(12)),
//         //   decoration: BoxDecoration(
//         //     borderRadius: BorderRadius.circular(getWidth(10)),
//         //     border: Border.all(color: const Color(0xffC2A44F)),
//         //   ),
//         //   child: Row(
//         //     children: [
//         //       Container(
//         //         height: getWidth(50),
//         //         width: getWidth(50),
//         //         decoration: BoxDecoration(
//         //           borderRadius: BorderRadius.circular(getWidth(5)),
//         //         ),
//         //         child: Stack(
//         //           alignment: Alignment.center,
//         //           children: [
//         //             ClipRRect(
//         //                 borderRadius: BorderRadius.circular(getWidth(5)),
//         //                 child: CustomImage(
//         //                   path: AppImages.goldButtonBack,
//         //                   height: getWidth(50),
//         //                   width: getWidth(50),
//         //                   fit: BoxFit.cover,
//         //                 )
//         //             ),
//         //             const Icon(Icons.person_outlined)
//         //           ],
//         //         ),
//         //       ),
//         //       SizedBox(width: getWidth(8),),
//         //       Expanded(
//         //         child: Column(
//         //           crossAxisAlignment: CrossAxisAlignment.start,
//         //           children: [
//         //             CustomText(text: "Name: Jayed Hasan", fontSize: getWidth(14)),
//         //             SizedBox(height: getWidth(8),),
//         //             CustomText(text: "Relation: Children", fontSize: getWidth(14)),
//         //           ],
//         //         ),
//         //       ),
//         //       Container(
//         //         decoration: BoxDecoration(
//         //           color: AppColors.white,
//         //           borderRadius: BorderRadius.horizontal(left: Radius.circular(getWidth(30))),
//         //           border: const Border(
//         //             top: BorderSide(color: Color(0xffC2A44F),),
//         //             left: BorderSide(color: Color(0xffC2A44F),),
//         //             bottom: BorderSide(color: Color(0xffC2A44F),),
//         //             right: BorderSide.none, // No border here
//         //           ),
//         //         ),
//         //         child: Material(
//         //             color: AppColors.white,
//         //             borderRadius: BorderRadius.horizontal(left: Radius.circular(getWidth(30))),
//         //             child: InkWell(
//         //                 borderRadius: BorderRadius.horizontal(left: Radius.circular(getWidth(30))),
//         //                 onTap: (){},
//         //                 child: Padding(
//         //                   padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
//         //                   child: Icon(Icons.add),
//         //                 ))),
//         //       )
//         //     ],
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
