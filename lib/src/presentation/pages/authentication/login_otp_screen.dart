import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_icons.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/contants.dart';
import 'package:consultation_sdk/src/global_widget/app_pinky_circle_gradient.dart';
import 'package:consultation_sdk/src/global_widget/custom_button.dart';
import 'package:consultation_sdk/src/global_widget/custom_image.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/global_widget/loading_widget.dart';
import 'package:consultation_sdk/src/global_widget/page_back__border_button.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_state.dart';

class LoginOtpScreen extends StatefulWidget {
  const LoginOtpScreen({
    super.key,
    required this.countryLetterCode,
    required this.dialCode,
    required this.phoneNumber,
    required this.serviceToken,
    required this.onOtpVerified,
    required this.onError,
  });
  final String countryLetterCode;
  final String dialCode;
  final String phoneNumber;
  final String serviceToken;
  final void Function(String authToken) onOtpVerified;
  final void Function(String) onError;

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  var pinController = TextEditingController();
  var errorText = "";

  void validationForm(BuildContext context) {
    if (pinController.text.isEmpty) {
      setState(() {
        errorText = "Please Enter 4 Digit OTP";
      });
      return;
    } else if (pinController.text.length < 4) {
      setState(() {
        errorText = "Please Enter 4 Digit OTP";
      });
      return;
    } else {
      setState(() {
        errorText = "";
      });
      print(">>>>>>>>>>>>>>>>>>>serviceId call Otp verify: ${widget.serviceToken}<<<<<<<<<<<<<<<<");
      context.read<AuthCubit>().verifyOtp(
        context,
        countryCode: widget.countryLetterCode,
        dialCode: widget.dialCode,
        phoneNumber: widget.phoneNumber,
        otp: pinController.text.trim(),
        serviceId: widget.serviceToken,
      );
    }
    // login(email: emailController.text.trim(), password: passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.mainColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return BlocListener<AuthCubit,AuthState>(
      listenWhen: (previous, current) => previous.isLoaded != current.isLoaded || previous.error != current.error,
      listener: (context, state) {
        if(state.isLoaded){
          widget.onOtpVerified(state.userProfileModel!.accessToken);
        } else if(state.error.isNotEmpty){
          widget.onError(state.error);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              leading: const PageBackBorderButton(),
              title: CustomText(
                text: "OTP Verification",
                fontSize: getWidth(18),
                fontWeight: FontWeight.w600,
              ),
              surfaceTintColor: AppColors.transparent,
              expandedHeight: getWidth(150),
              flexibleSpace: const AppPinkyCircleGradient(),
              actions: [SizedBox(width: getWidth(16))],
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: getWidth(80), bottom: getWidth(20)),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomText(
                      text: "Enter 4 digit OTP Code",
                      fontSize: getWidth(16),
                      fontWeight: FontWeight.w600,
                    ),
                    Builder(
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
                          child: CustomText(
                            text: widget.dialCode.contains("880")
                                ? "We have sent a 4-digit OTP to your mobile number via SMS."
                                : "We have sent a 4-digit OTP to your Whats app number.",
                            // text: "We will send a one time SMS message to \n0${controller
                            //     .phoneNumber.value}. Carrier rates may apply.",
                            fontSize: getWidth(16),
                            textAlign: TextAlign.center,
                            color: AppColors.dark1,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(
                          builder: (context) {
                            if (widget.dialCode.contains("880")) {
                              return const SizedBox.shrink();
                            }
                            return CustomImage(
                              path: AppIcons.whatsAppIcon,
                              height: getWidth(20),
                              width: getWidth(20),
                            );
                          },
                        ),
                        Builder(
                          builder: (context) {
                            return SizedBox(
                              width: widget.dialCode.contains("880")
                                  ? 0
                                  : getWidth(8),
                            );
                          },
                        ),
                        Builder(
                          builder: (context) {
                            return CustomText(
                              text: "+${widget.dialCode}${widget.phoneNumber}",
                              // text: "We will send a one time SMS message to \n0${controller
                              //     .phoneNumber.value}. Carrier rates may apply.",
                              fontSize: getWidth(16),
                              textAlign: TextAlign.center,
                              color: AppColors.dark1,
                              fontWeight: FontWeight.w400,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(30)),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      child: Pinput(
                        controller: pinController,
                        keyboardType: TextInputType.number,
                        focusedPinTheme: otpPinFocusTheme,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) =>
                            SizedBox(width: getWidth(12)),
                        length: 4,
                        onCompleted: (pin) => {},
                        // smsRetriever: SmsRetriever().listenForMultipleSms,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Builder(
                      builder: (context) {
                        if (errorText.isEmpty) {
                          return SizedBox(height: getWidth(40));
                        }
                        return Container(
                          height: getWidth(40),
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(12),
                            vertical: getWidth(8),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            border: Border.all(color: const Color(0xffF43F5E)),
                            borderRadius: BorderRadius.circular(getWidth(30)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                size: getWidth(20),
                                color: const Color(0xffF43F5E),
                              ),
                              SizedBox(width: getWidth(8)),
                              CustomText(
                                text: errorText,
                                fontSize: getWidth(14),
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: getWidth(40)),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      height: getWidth(55),
                      width: screenWidth(),
                      child: BlocBuilder<AuthCubit, AuthState>(
                        buildWhen: (previous, current) =>
                        previous.isLoading != current.isLoading,
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(child: LoadingWidget());
                          }
                          return CustomButton(
                            title: "Continue",
                            onTap: () {
                              validationForm(context);
                            },
                            color: AppColors.mainColor,
                            borderRadius: getWidth(5),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CustomText(
                        //   text: "Didn't Receive OTP?  ",
                        //   fontSize: getWidth(14),
                        //   fontWeight: FontWeight.w400,
                        // ),
                        // StreamBuilder(
                        //   stream: controller.timeCounter,
                        //   builder: (context, snapshot) {
                        //     Widget widget = const CircularProgressIndicator();
                        //     if (snapshot.hasData) {
                        //       if (snapshot.data == 0) {
                        //         widget = widget = AppTextButton(
                        //           text: "Re-send",
                        //           onTap: () {
                        //             Utils.closeKeyBoard(context);
                        //             controller.getOtp(context);
                        //           },
                        //           textColor: AppColors.mainColor,
                        //         );
                        //       } else {
                        //         widget = CustomText(
                        //             text: " 00:${snapshot.data.toString().padLeft(
                        //                 2, '0')}",
                        //             fontSize: getWidth(14),
                        //             fontWeight: FontWeight.w600);
                        //       }
                        //     } else if (snapshot.hasError) {
                        //       widget = CustomText(
                        //           text: "00:00",
                        //           fontSize: getWidth(14),
                        //           fontWeight: FontWeight.w400);
                        //     } else {
                        //       widget = CustomText(
                        //           text: "00:00",
                        //           fontSize: getWidth(14),
                        //           fontWeight: FontWeight.w400);
                        //     }
                        //     return widget;
                        //   },
                        // ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
