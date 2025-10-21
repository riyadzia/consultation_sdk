import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/global_widget/agora_caller_avater.dart';
import 'package:consultation_sdk/src/global_widget/custom_image.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/global_widget/page_pinky_background.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_state.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/component/agora_self_video.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/component/calling_bottom_options.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/component/local_video.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/component/remote_video.dart';
import 'package:consultation_sdk/src/screen/message_screen.dart';

import '../../../di/injector.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  // final CallingCubit _cubit = getIt.get();

  @override
  void initState() {
    // context.read<CallingCubit>().startVideoCalling();
    super.initState();
  }

  @override
  void dispose() {
    // context.read<CallingCubit>().stopVideoCalling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top],
    );
    return Scaffold(
      body: BlocListener<CallingCubit,CallingState>(
        listenWhen: (previous, current) => previous.onTapEndButton != current.onTapEndButton,
        listener: (context, state) async {
          if(state.onTapEndButton){
            context.read<CallingCubit>().stopVideoCalling();
            Navigator.of(context).pop();
          }
        },
        child: SizedBox(
          height: screenHeight(),
          width: screenWidth(),
          child: Stack(
            children: [
              Positioned.fill(
                child: PagePinkyBackground(),
                // child: CustomImage(
                //   path: "assets/images/women.png",
                //   fit: BoxFit.cover,
                // ),
              ),
              /// Remote Video
              Positioned.fill(
                  child: RemoteVideo()
              ),
              /// Name and category/status
              Container(
                width: screenWidth(),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      AppColors.transparent,
                      AppColors.greyColor.withValues(alpha: 0.1),
                      AppColors.greyColor.withValues(alpha: 0.2),
                      AppColors.greyColor.withValues(alpha: 0.3),
                      AppColors.greyColor.withValues(alpha: 0.3),
                      AppColors.greyColor.withValues(alpha: 0.2),
                      AppColors.greyColor.withValues(alpha: 0.1),
                      AppColors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: getWidth(50)),
                    BlocBuilder<CallingCubit, CallingState>(
                        buildWhen: (previous, current) =>
                        previous.name != current.name,
                        builder: (context, state) {
                        return CustomText(
                          text: state.name,
                          fontSize: getWidth(22),
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        );
                      }
                    ),
                    CustomText(
                      text: "",
                      fontSize: getWidth(14),
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    BlocBuilder<CallingCubit, CallingState>(
                      buildWhen: (previous, current) =>
                          previous.callingStatus != current.callingStatus || previous.duration != current.duration,
                      builder: (context, state) {
                        String text = "Calling";
                        if (state.callingStatus == CallingStatus.ringing) {
                          text = "Ringing";
                        } else if(state.callingStatus == CallingStatus.waiting){
                          text = "Busy";
                        } else if(state.callingStatus == CallingStatus.running){
                          text = state.durationInText;
                        }
                        return CustomText(
                          text: text,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: getWidth(14),
                        );
                      },
                    ),
                    // SizedBox(
                    //   height: getWidth(8),
                    // ),
                    // Obx(() {
                    //   if (controller.remotePhone.value.isEmpty) {
                    //     return const SizedBox.shrink();
                    //   } else {
                    //     return Builder(builder: (context) {
                    //       if (controller.user?.role1 ==
                    //           UserRole.inhouseDoctor) {
                    //         return CustomText(
                    //             text: controller.remotePhone.value,
                    //             fontSize: getWidth(14));
                    //       } else {
                    //         return const SizedBox.shrink();
                    //       }
                    //     });
                    //   }
                    // }),
                    // SizedBox(
                    //   height: getWidth(8),
                    // ),
                    // Obx(() {
                    //   if (!controller.isRemoteMute.value) {
                    //     return const SizedBox.shrink();
                    //   } else {
                    //     return Icon(
                    //       Icons.mic_off,
                    //       size: getWidth(20),
                    //     );
                    //   }
                    // }),
                    SizedBox(height: getWidth(50)),
                  ],
                ),
              ),

              /// All Bottom Buttons
              Positioned(
                bottom: getWidth(50),
                left: 0,
                right: 0,
                child: CallingBottomOptions(),
              ),

              /// Self Video..
              Positioned(
                top: getWidth(80),
                right: getWidth(12),
                child: AgoraSelfVideo(),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: DraggableFab(
      //   securityBottom: getWidth(50),
      //   initPosition: Offset(
      //     screenWidth() - getWidth(12),
      //     getWidth(
      //       controller.draggablePTop.value,
      //     ),
      //   ),
      //   // child: const AgoraSelfVideo(),
      //   child: Obx(() {
      //     if (controller.callingStatus.value == CallingStatus.running &&
      //         controller.isVideoIconAvailable.value) {
      //       return const AgoraSelfVideo();
      //     } else {
      //       return const SizedBox.shrink();
      //     }
      //   }),
      // ),
    );
  }
}
