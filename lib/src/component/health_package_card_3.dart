import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/animation/animated_text_shader.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_images.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/extensions.dart';
import 'package:consultation_sdk/src/core/helper.dart';
import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/global_widget/custom_button.dart';
import 'package:consultation_sdk/src/global_widget/custom_image.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/model/package_model.dart';
import 'package:consultation_sdk/src/model/package_variation_model.dart';
import 'package:consultation_sdk/src/model/user_profile_model.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/payment/payment_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/payment/package_payment_screen.dart';

class NewHealthPackageCard3 extends StatefulWidget {
  const NewHealthPackageCard3({
    super.key,
    required this.packageModel,
    this.isFromBanner = false,
    required this.index,
  });

  final PackageModel packageModel;
  final bool isFromBanner;
  final int index;

  @override
  State<NewHealthPackageCard3> createState() => _NewHealthPackageCard3State();
}

class _NewHealthPackageCard3State extends State<NewHealthPackageCard3> {
  // int index = Random().nextInt(packageBackgrounds.length);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        PackageVariationModel variationModel = widget
            .packageModel
            .packageVariation![widget.packageModel.selectedIndex!];
        return Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(4)),
          height: screenWidth() * 1.24,
          child: InkWell(
            borderRadius: BorderRadius.circular(getWidth(14)),
            onTap: () async {
              Utils.closeKeyBoard(context);
              // Get.toNamed(Routes.packageDetailsScreen,
              //     arguments: {"package": packageModel});
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(getWidth(14)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(getWidth(14)),
                  border: Border.all(color: AppColors.travelBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: constraints.maxWidth * 0.43,
                      child: Stack(
                        children: [
                          Container(
                            height: constraints.maxWidth * 0.43,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("${widget.packageModel.image}")
                                // image: AssetImage(
                                //   Helper.getPackageBackground(
                                //     widget.packageModel.type!,
                                //   ),
                                // ),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: getWidth(12),
                                      ),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: getWidth(100),
                                            offset: const Offset(0, 0),
                                            color: AppColors.black87.withValues(
                                              alpha: 0.6,
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: CustomImage(
                                        path: AppImages.healthSolutionText,
                                        height: getWidth(70),
                                      ),
                                    ),
                                    SizedBox(height: getWidth(0)),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: getWidth(12),
                                        top: getWidth(8),
                                        bottom: getWidth(8),
                                        right: getWidth(50),
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.white.withValues(
                                          alpha: 0.6,
                                        ),
                                        borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(getWidth(50)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          CustomText(
                                            text: "${getPackageTypeIntl().capitalizeFirst()}/",
                                            fontSize: getWidth(16),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          CustomText(
                                            text: getDurationIntl(
                                              variationModel,
                                            ).capitalizeFirstLetter(),
                                            fontSize: getWidth(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (widget.packageModel.type == 'gold') ...[
                            const Positioned(
                              top: 0,
                              right: 0,
                              child: AnimatedTextShader(),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: getWidth(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: getWidth(10)),
                        CustomText(
                          text: "${getDurationIntl(variationModel)} Price - ".capitalizeFirstLetter(),
                          fontSize: getWidth(14),
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                        CustomText(
                          text:
                              "BDT ${widget.packageModel.packageVariation![widget.packageModel.selectedIndex!].sellingPrice}",
                          // text: "BDT ${packageModel.price?.toStringAsFixed(0)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: getWidth(14),
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.travelBorderColor,
                      height: getWidth(30),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(6)),
                      child: Row(
                        children: [
                          ...List.generate(
                            widget.packageModel.packageVariation!.length,
                            (index) {
                              PackageVariationModel packageVariationModel =
                                  widget.packageModel.packageVariation![index];
                              return Expanded(
                                child: SizedBox(
                                  height: getWidth(40),
                                  child: CustomButton(
                                    verticalPadding: 0,
                                    horizontalPadding: 0,
                                    elevation: 0,
                                    title: getDurationIntl(
                                      packageVariationModel,
                                    ).capitalizeFirstLetter(),
                                    onTap: () {
                                      setState(() {
                                        widget.packageModel.selectedIndex =
                                            index;
                                      });
                                    },
                                    titleColor:
                                        widget.packageModel.selectedIndex! ==
                                            index
                                        ? AppColors.white
                                        : AppColors.secondaryColor,
                                    color:
                                        widget.packageModel.selectedIndex! ==
                                            index
                                        ? AppColors.mainColor
                                        : AppColors.white,
                                    fontSize: getWidth(12),
                                    borderRadius: getWidth(5),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColors.travelBorderColor,
                      height: getWidth(30),
                    ),
                    // Feature
                    if (widget.packageModel.type != "telemedicine") ...[
                      Builder(
                        builder: (context) {
                          String name = "${widget.packageModel.title}";
                          if (name.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getWidth(16),
                            ),
                            child: CustomText(
                              text: name,
                              // text: "${packageModel.description}",
                              color: AppColors.secondaryColor,
                              fontSize: getWidth(12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        },
                      ),
                    ],
                    Padding(
                      padding: EdgeInsets.only(
                        left: getWidth(6),
                        right: getWidth(3),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_box,
                            size: getWidth(16),
                            color: AppColors.greenColor,
                          ),
                          SizedBox(width: getWidth(6)),
                          // CustomText(text: "${AppText().unlimitedDoctorCall} ${variationModel.member} ${AppText().person}".convertEnglishToBangla(), fontSize: getWidth(12))
                          CustomText(
                            text: getTitleIntl(variationModel),
                            fontSize: getWidth(12),
                          ),
                        ],
                      ),
                    ),
                    // for telemedicine
                    if (widget.packageModel.type == "telemedicine") ...[
                      Padding(
                        padding: EdgeInsets.only(
                          left: getWidth(6),
                          right: getWidth(3),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_box,
                              size: getWidth(16),
                              color: AppColors.greenColor,
                            ),
                            SizedBox(width: getWidth(6)),
                            CustomText(
                              text: "Unlimited Doctor Call for",
                              fontSize: getWidth(12),
                            ),
                            // CustomText(text: "24/7 ${AppText().audio}/${AppText().video}", fontSize: getWidth(12))
                          ],
                        ),
                      ),
                    ],
                    // for insurance
                    if (widget.packageModel.type != "telemedicine") ...[
                      Padding(
                        padding: EdgeInsets.only(
                          left: getWidth(6),
                          right: getWidth(3),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_box,
                              size: getWidth(16),
                              color: AppColors.greenColor,
                            ),
                            SizedBox(width: getWidth(6)),
                            CustomText(
                              text:
                                  "Hospital Cashback Up to BDT ${variationModel.hospitalCashback}",
                              fontSize: getWidth(12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getWidth(6),
                          right: getWidth(3),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_box,
                              size: getWidth(16),
                              color: AppColors.greenColor,
                            ),
                            SizedBox(width: getWidth(6)),
                            CustomText(
                              text:
                                  "Per Claim Benefit BDT ${variationModel.perClaimBenefit}",
                              fontSize: getWidth(12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getWidth(6),
                          right: getWidth(3),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_box,
                              size: getWidth(16),
                              color: AppColors.greenColor,
                            ),
                            SizedBox(width: getWidth(6)),
                            CustomText(
                              text:
                                  "Per Day Benefit BDT ${variationModel.perDayBenefit}",
                              fontSize: getWidth(12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getWidth(6),
                          right: getWidth(3),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_box,
                              size: getWidth(16),
                              color: AppColors.greenColor,
                            ),
                            SizedBox(width: getWidth(6)),
                            CustomText(
                              text:
                                  "Isolation Coverage BDT ${variationModel.isolationCoverage}",
                              fontSize: getWidth(12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getWidth(6),
                          right: getWidth(3),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_box,
                              size: getWidth(16),
                              color: AppColors.greenColor,
                            ),
                            SizedBox(width: getWidth(6)),
                            CustomText(
                              text: "OPD BDT ${variationModel.opd}",
                              fontSize: getWidth(12),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const Spacer(),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: getWidth(40),
                              child: CustomButton(
                                verticalPadding: 0,
                                title: "Buy Now",
                                onTap: () {
                                  if(context
                                      .read<AuthCubit>()
                                      .state.isLoaded){
                                    UserProfileModel user = context
                                        .read<AuthCubit>()
                                        .state
                                        .userProfileModel!;
                                    int discountPercentage =
                                    variationModel.discountPercent!;
                                    int discountedPrice =
                                        variationModel.sellingPrice! -
                                            ((variationModel.sellingPrice! *
                                                discountPercentage) ~/
                                                100);
                                    // Utils.closeKeyBoard(context);
                                    var dataMap = <String, dynamic>{
                                      // "invoiceNumber": data.invoiceNumber,
                                      "amount": variationModel.sellingPrice,
                                      "discountedPrice": discountedPrice,
                                      "discountPercent":
                                      variationModel.discountPercent,
                                      "firstName": user.firstName.isEmpty
                                          ? "Name"
                                          : user.firstName,
                                      "lastName": user.lastName.isEmpty
                                          ? "Last Name"
                                          : user.lastName,
                                      // use when international number
                                      // "phoneNumber": "${user.dialCode}${user.number}",
                                      "phoneNumber": user.number,
                                      "address": "Baradhaka Bloc - J",
                                      "email": user.email.isEmpty
                                          ? "customer.service@theclinicall.com"
                                          : user.email,
                                      "countryCode": "BD",
                                      "district": "Dhaka",
                                      "thana": "Vatara",
                                      "postalCode": "1212",
                                    };

                                    String userId = user.id;
                                    dataMap.addAll({"userId": userId});
                                    dataMap.addAll({
                                      "package": widget.packageModel,
                                    });
                                    dataMap.addAll({
                                      "packageId": "${widget.packageModel.id}",
                                    });
                                    dataMap.addAll({
                                      "packageVariationId":
                                      "${variationModel.id}",
                                    });
                                    if (discountPercentage != 0) {
                                      dataMap.addAll({
                                        "discountPercentage": discountPercentage,
                                      });
                                    }
                                    dataMap.addAll({
                                      "packageTitle":
                                      "${widget.packageModel.type}",
                                    });
                                    if (kDebugMode) {
                                      print(dataMap);
                                    }
                                    context.read<PaymentCubit>().paymentOpen(dataMap);
                                  } else {
                                    Utils.showMiddleToast("Your Token is expired. Please login again");
                                  }
                                },
                                color: AppColors.mainColor,
                                fontSize: getWidth(14),
                                borderRadius: getWidth(5),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getWidth(6),
                            ),
                            child: CustomText(
                              text: "* Condition Apply",
                              fontSize: getWidth(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getWidth(10)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String getPackageTypeIntl() {
    String type = "${widget.packageModel.type}";
    return type;
  }

  String getDurationIntl(PackageVariationModel variationModel) {
    String duration = "${variationModel.duration}";
    return duration;
  }

  String getTitleIntl(PackageVariationModel variationModel) {
    // final loginController = Get.find<LoginController>();
    String title = "${variationModel.title}";
    // if (loginController.selectedLanguage.value != "English" &&
    //     variationModel.bnTitle!.isNotEmpty) {
    //   title = "${variationModel.bnTitle}";
    // }
    return title;
  }

  bool isExtra() {
    int price = widget
        .packageModel
        .packageVariation![widget.packageModel.selectedIndex!]
        .sellingPrice!;
    if (price == 110 || price == 1299) {
      return true;
    }
    return false;
  }

  Widget packageData(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getWidth(8),
              vertical: getWidth(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // title and save amount
                Row(
                  children: [
                    CustomText(
                      text: widget.packageModel.type!,
                      // text: packageTypeText[index],
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      fontSize: getWidth(14),
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: isExtra() ? "  (Doctor Consultation)" : "",
                      // text: packageTypeText[index],
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontSize: getWidth(12),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),

                /// Price and duration
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text:
                          "BDT ${widget.packageModel.packageVariation![widget.packageModel.selectedIndex!].sellingPrice}",
                      // text: "BDT ${packageModel.price?.toStringAsFixed(0)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontSize: getWidth(14),
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text:
                          "/${widget.packageModel.packageVariation![widget.packageModel.selectedIndex!].duration?.toLowerCase()}",
                      fontSize: getWidth(12),
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    // GetBuilder<LoginController>(
                    //   builder: (loginController) {
                    //     String duration = "${packageModel.duration}";
                    //     if(loginController.selectedLanguage.value != "English" && packageModel.bnDuration!.isNotEmpty) {
                    //       duration = "${packageModel.bnDuration}";
                    //     }
                    //     return CustomText(
                    //         text: "/$duration",
                    //         fontSize: getWidth(12),
                    //         color: AppColors.secondaryColor,
                    //         fontWeight: FontWeight.w400);
                    //   }
                    // ),
                  ],
                ),
                // const Spacer(),
                SizedBox(height: getWidth(5)),
                // description
                Builder(
                  builder: (context) {
                    String name =
                        "${widget.packageModel.packageVariation![widget.packageModel.selectedIndex!].description}";
                    return CustomText(
                      text: name,
                      // text: "${packageModel.description}",
                      color: AppColors.dark1,
                      fontSize: getWidth(12),
                      maxLines: isSmallDevice() ? 6 : 7,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                    );
                  },
                ),
                const Spacer(),
                // price and buy button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///[used static code]
                    // SizedBox(
                    //   height: getWidth(34),
                    //   child: PackageBuyNowButton(
                    //     packageModel: packageModel, index: index,),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                            color: AppColors.black87.withValues(alpha: 0.25),
                          ),
                        ],
                      ),
                      child: Material(
                        color: AppColors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            Utils.closeKeyBoard(context);
                            // Get.toNamed(Routes.packageDetailsScreen,
                            //     arguments: {"package": packageModel});
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CustomImage(
                                  path: Helper.getPackageButtonBackground(
                                    widget.packageModel.type!,
                                  ),
                                  // path: packageButtonBackgrounds[index > 5 ? 5 : index],
                                  height: getWidth(26),
                                ),
                              ),
                              CustomText(
                                text: "Details",
                                fontSize: getWidth(12),
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Health Card Images
        SizedBox(
          width: screenWidth() * 0.26,
          child: Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.passthrough,
            children: [
              // Women Image
              Positioned(
                bottom: 0,
                right: getWidth(8),
                child: CustomImage(
                  path: AppImages.packageCardWomen,
                  // height: getWidth(150),
                  width: screenWidth() * 0.23,
                ),
              ),
              // Text Image
              Positioned(
                top: getWidth(10),
                // left: getWidth(10),
                right: 0,
                child: CustomImage(
                  path: AppImages.healthSolutionText,
                  height: getWidth(48),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
