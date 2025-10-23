import 'dart:ui';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:consultation_sdk/consultation_sdk.dart';
import 'package:consultation_sdk/consultation_sdk_auth.dart';
import 'package:consultation_sdk/src/global_widget/page_back__border_button.dart';
import 'package:consultation_sdk/src/global_widget/page_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/component/call_option_dialog.dart';
import 'package:consultation_sdk/src/component/home_call_package_card.dart';
import 'package:consultation_sdk/src/component/home_health_slider.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_icons.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/di/seignalling_service.dart';
import 'package:consultation_sdk/src/global_widget/app_pinky_circle_gradient.dart';
import 'package:consultation_sdk/src/global_widget/appbar_profile_image.dart';
import 'package:consultation_sdk/src/global_widget/appbar_profile_name.dart';
import 'package:consultation_sdk/src/global_widget/custom_image.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_state.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/call_screen.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_state.dart';
import 'package:consultation_sdk/src/presentation/pages/payment/package_payment_screen.dart';
import 'package:consultation_sdk/src/presentation/pages/payment/payment_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/payment/payment_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.countryLetterCode,
    required this.dialCode,
    required this.phoneNumber,
    this.authToken,
    required this.serviceToken,
  });
  final String countryLetterCode;
  final String dialCode;
  final String phoneNumber;
  final String? authToken;
  final String serviceToken;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (mounted) {
      if (widget.authToken != null && widget.authToken!.isNotEmpty) {
        token = widget.authToken!;
      }
      context.read<AuthCubit>().getUserProfileData();
      context.read<AuthCubit>().setServiceToken(widget.serviceToken);
    }
    super.initState();
  }

  Future<void> onRefresh() async {
    context.read<AuthCubit>().getUserProfileData();
    context.read<HealthPackageCubit>().getServicePackage();
  }

  @override
  void dispose() {
    SignallingService.instance.disconnect();
    super.dispose();
  }

  int apiCallCount = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(didPop){
          ConsultationSdk().close();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: PageRefresh(
          onRefresh: onRefresh,
          child: MultiBlocListener(
            listeners: [
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.isLoaded) {
                    context.read<HealthPackageCubit>().getActiveHealthCard(
                      state.userProfileModel!.id,
                    );
                    // Utils.showMiddleToast("User Data Found");
                  } else if (state.isLoading == false && state.error.isNotEmpty){
                    Utils.showMiddleToast(state.error);
                    Future.delayed(Duration(seconds: 2)).then((value){
                      if(apiCallCount == 0){
                        apiCallCount++;
                        context.read<AuthCubit>().getUserProfileData();
                        return;
                      }
                      ConsultationSdk().close();
                      ConsultationSdk().authenticate(
                          countryLetterCode: widget.countryLetterCode,
                          dialCode: widget.dialCode,
                          phoneNumber: widget.phoneNumber,
                      );
                    });
                  }
                },
                listenWhen: (previous, current) =>
                    previous.isLoaded != current.isLoaded || previous.error != current.error,
              ),
              BlocListener<PaymentCubit, PaymentState>(
                listenWhen: (previous, current) =>
                    previous.startPayment != current.startPayment,
                listener: (context, state) {
                  if (state.dataMap.isNotEmpty && state.startPayment != 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PackagePaymentScreen(),
                      ),
                    ).then((value){
                      String userId = "${context.read<AuthCubit>().state.userProfileModel?.id}";
                      context.read<HealthPackageCubit>().getActiveHealthCard(userId);
                    });
                  }
                },
              ),
            ],
            child: CustomScrollView(
              slivers: [
                /// AppBar
                SliverAppBar(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PageBackBorderButton(
                        onPressed: (){
                          ConsultationSdk().close();
                        },
                      ),
                      SizedBox(width: getWidth(10),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!isMobile()) ...[SizedBox(height: getWidth(12))],
                          CustomImage(path: AppIcons.logoText, height: getWidth(26)),
                          CustomText(
                            text: "Complete Healthcare in One App",
                            color: AppColors.secondaryColor,
                            fontSize: getWidth(12),
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  titleSpacing: getWidth(8),
                  clipBehavior: Clip.none,
                  backgroundColor: AppColors.white,
                  surfaceTintColor: AppColors.transparent,
                  centerTitle: false,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actions: [SizedBox(width: getWidth(10))],
                  collapsedHeight: isSmallDevice() ? getWidth(180) : getWidth(140),
                  expandedHeight: isSmallDevice() ? getWidth(180) : getWidth(140),
                  flexibleSpace: Stack(
                    children: [
                      const AppPinkyCircleGradient(),
                      Padding(
                        padding: EdgeInsets.all(getWidth(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const AppbarProfileImage(),
                                SizedBox(width: getWidth(12)),
                                const Expanded(child: AppbarProfileName()),
                              ],
                            ),
                            SizedBox(height: getWidth(8)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Call Button
                SliverPadding(
                  padding: EdgeInsets.only(
                    left: getWidth(16),
                    right: getWidth(16),
                    top: getWidth(16),
                    bottom: getWidth(8),
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(8),
                        vertical: getWidth(8),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.light5.withValues(alpha: 1),
                        borderRadius: BorderRadius.circular(getWidth(5)),
                        border: Border.all(color: AppColors.light5),
                      ),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      getWidth(5),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 20,
                                        sigmaY: 20,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.35,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            getWidth(5),
                                          ),
                                          border: Border.all(
                                            color: Colors.white.withValues(
                                              alpha: 0.6,
                                            ),
                                            width: 1.8,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: getWidth(6),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AvatarGlow(
                                                glowColor: AppColors.mainColor500,
                                                duration: const Duration(
                                                  milliseconds: 2000,
                                                ),
                                                repeat: true,
                                                glowCount: 1,
                                                startDelay: const Duration(
                                                  milliseconds: 100,
                                                ),
                                                animate: true,
                                                child: CircleAvatar(
                                                  backgroundColor: AppColors.white,
                                                  // backgroundColor: AppColors.mainColor.withValues(alpha: 0.05),
                                                  radius: getWidth(28),
                                                  child: Material(
                                                    color: AppColors.white,
                                                    shape: const CircleBorder(),
                                                    elevation: 1,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        // return;
                                                        if (await Utils.checkInternetConnection()) {
                                                          CallOptionDialog.openCallOptionDialog(
                                                            context,
                                                            (value) {
                                                              context
                                                                  .read<
                                                                    HealthPackageCubit
                                                                  >()
                                                                  .callDoctor(
                                                                    context:
                                                                        context,
                                                                    isVideo: value,
                                                                  );
                                                            },
                                                            isActive: false,
                                                          );
                                                        }
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            getWidth(100),
                                                          ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.call,
                                                          color: Colors.green,
                                                          size: getWidth(30),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: getWidth(8)),
                                              CustomText(
                                                text: "Call Doctor",
                                                fontSize: getWidth(14),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              CustomText(
                                                text: "24/7 Audio/Video",
                                                fontSize: getWidth(12),
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: getWidth(6)),
                                Expanded(flex: 3, child: HomeCallPackageCard()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// All Health Package...
                SliverToBoxAdapter(
                  child: HomeHealthSlider(heading: "Health Package"),
                ),
                // Service Button
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(26),
                    vertical: getWidth(16),
                  ),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: screenWidth() > 390 ? 1.4 : 1.1,
                      crossAxisSpacing: getWidth(12),
                      mainAxisSpacing: getWidth(12),
                    ),
                    delegate: SliverChildListDelegate([
                      //health Package
                      // HomeCategoryCard(
                      //   categoryName: "Health Package",
                      //   slogan: "Cashback up to BDT 200K on hospitalization *",
                      //   icon: AppIcons.healthPackage2,
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const PackagePaymentScreen(),
                      //       ),
                      //     );
                      //     // Get.toNamed(Routes.allPackagesScreen);
                      //   },
                      // ),
                      // Gift Package
                      // HomeCategoryCard(
                      //   categoryName: AppText().giftPackage.tr,
                      //   slogan: "gift_package_slogan".tr,
                      //   icon: AppIcons.giftPackage,
                      //   onPressed: () {
                      //     FBEventsHelper().logEvent(eventName: allPackageView);
                      //     Get.find<ServicePackageController>().isFromGift = true;
                      //     // Get.toNamed(Routes.giftPackageScreen);
                      //     Get.toNamed(Routes.allPackagesScreen)?.then((value){
                      //       Get.find<ServicePackageController>().isFromGift = false;
                      //     });
                      //   },
                      // ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
