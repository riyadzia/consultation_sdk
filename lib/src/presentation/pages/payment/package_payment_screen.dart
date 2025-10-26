import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/contants.dart';
import 'package:consultation_sdk/src/core/extensions.dart';
import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/global_widget/app_pinky_circle_gradient.dart';
import 'package:consultation_sdk/src/global_widget/custom_button.dart';
import 'package:consultation_sdk/src/global_widget/custom_image.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/global_widget/page_back__border_button.dart';
import 'package:consultation_sdk/src/presentation/pages/payment/payment_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/payment/payment_state.dart';

import '../../../model/payment_type_model.dart';

class PackagePaymentScreen extends StatefulWidget {
  const PackagePaymentScreen({super.key});

  @override
  State<PackagePaymentScreen> createState() => _PackagePaymentScreenState();
}

class _PackagePaymentScreenState extends State<PackagePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: BlocListener<PaymentCubit, PaymentState>(
        listenWhen: (previous, current) =>
            previous.paymentSuccess != current.paymentSuccess,
        listener: (context, state) {
          if (state.paymentSuccess) {
            String userId = context.read<PaymentCubit>().userId;
            context.read<HealthPackageCubit>().getActiveHealthCard(userId);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.pageBackground2,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                leading: const PageBackBorderButton(),
                title: CustomText(
                  text: "Payment",
                  fontSize: getWidth(15),
                  fontWeight: FontWeight.w600,
                ),
                pinned: true,
                expandedHeight: getWidth(100),
                flexibleSpace: const AppPinkyCircleGradient(),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(12),
                  vertical: getWidth(12),
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: getWidth(20)),
                      Column(
                        children: [
                          CustomText(
                            text: "Payment Amount:   ",
                            color: AppColors.secondaryColor,
                            fontSize: getWidth(16),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: getWidth(16)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<PaymentCubit, PaymentState>(
                                buildWhen: (previous, current) =>
                                    previous.discountPercentage !=
                                    current.discountPercentage,
                                builder: (context, state) {
                                  if (state.discountPercentage > 0) {
                                    return CustomText(
                                      text: "BDT ${state.dataMap["amount"]}  ",
                                      color: AppColors.secondaryColor,
                                      textDecoration:
                                          TextDecoration.lineThrough,
                                      fontSize: getWidth(20),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                              BlocBuilder<PaymentCubit, PaymentState>(
                                buildWhen: (previous, current) =>
                                    previous.discountPercentage !=
                                    current.discountPercentage,
                                builder: (context, state) {
                                  int discountedAmount =
                                      state.amount -
                                      (state.amount *
                                              state.discountPercentage) ~/
                                          100;
                                  return CustomText(
                                    // text: "${AppText().bdt} ${controller.dataMap["amount"] ?? ""}".convertEnglishToBangla(),
                                    text: "BDT $discountedAmount",
                                    color: AppColors.secondaryColor,
                                    fontSize: getWidth(22),
                                    fontWeight: FontWeight.w600,
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: getWidth(0)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getWidth(50),
                            ),
                            child: Divider(
                              color: AppColors.secondaryColor,
                              thickness: 1,
                              height: 30,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: getWidth(20)),
                      BlocBuilder<PaymentCubit, PaymentState>(
                        buildWhen: (previous, current) =>
                            previous.discountPercentage !=
                            current.discountPercentage,
                        builder: (context, state) {
                          if (state.discountPercentage > 0) {
                            int discountAmount =
                                (state.amount * state.discountPercentage) ~/
                                100;
                            return CustomText(
                              text: "💰 Saved: BDT $discountAmount",
                              color: AppColors.greenColor,
                              fontSize: getWidth(14),
                            );
                          } else {
                            return CustomText(text: "", fontSize: getWidth(14));
                          }
                        },
                      ),
                      SizedBox(height: getWidth(20)),
                      BlocBuilder<PaymentCubit, PaymentState>(
                        buildWhen: (previous, current) => previous.paymentType != current.paymentType,
                        builder: (context, state) {
                          return RadioGroup(
                            groupValue: state.paymentType,
                            onChanged: (type) {
                              context.read<PaymentCubit>().changePaymentType(
                                type!,
                              );
                            },
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(getWidth(10)),
                                  boxShadow: defaultBoxShadow(),
                                ),
                                child: Material(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(getWidth(10)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(getWidth(10)),
                                    onTap: () {
                                      context.read<PaymentCubit>().changePaymentType(
                                        bankTypeList[index],
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(12),
                                        vertical: getWidth(10),
                                      ),
                                      child: Row(
                                        children: [
                                          CustomText(
                                            text: bankTypeList[index].bankName
                                                .capitalizeFirstLetter(),
                                            color: AppColors.secondaryColor,
                                            fontSize: getWidth(14),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          const Spacer(),
                                          ...List.generate(
                                            bankTypeList[index].logoList.length,
                                                (iconIndex) {
                                              return CustomImage(
                                                path: bankTypeList[index]
                                                    .logoList[iconIndex],
                                                height: getWidth(30),
                                              );
                                            },
                                          ),
                                          SizedBox(width: getWidth(8)),
                                          Radio(
                                            activeColor: AppColors.mainColor,
                                            value: bankTypeList[index],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: getWidth(12)),
                              itemCount: bankTypeList.length,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: getWidth(30)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Pay Button
          extendBody: false,
          bottomNavigationBar: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: getWidth(12),
                horizontal: getWidth(12),
              ),
              padding: EdgeInsets.symmetric(
                vertical: getWidth(0),
                horizontal: getWidth(0),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getWidth(30)),
                color: AppColors.mainColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                    color: AppColors.mainColor.withValues(alpha: 0.1),
                  ),
                ],
              ),
              child: SizedBox(
                height: getWidth(50),
                child: CustomButton(
                  title: "Pay",
                  verticalPadding: 0,
                  onTap: () {
                    if (context.read<PaymentCubit>().state.paymentType ==
                        null) {
                      Utils.showMiddleToast("Select payment method");
                      return;
                    }
                    context.read<PaymentCubit>().buyPackage(context);
                  },
                  titleColor: AppColors.white,
                  borderRadius: getWidth(5),
                  fontSize: getWidth(14),
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
