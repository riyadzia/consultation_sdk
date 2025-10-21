import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_state.dart';

class CallingBottomOptions extends StatelessWidget {
  const CallingBottomOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<CallingCubit, CallingState>(
          buildWhen: (previous, current) =>
              previous.isAudioOn != current.isAudioOn,
          builder: (context, state) {
            return Material(
              shape: const CircleBorder(),
              color: AppColors.greyCircleButton,
              child: InkWell(
                borderRadius: BorderRadius.circular(getWidth(50)),
                onTap: () {
                  context.read<CallingCubit>().toggleMicrophone();
                },
                child: Padding(
                  padding: EdgeInsets.all(getWidth(12)),
                  child: BlocBuilder<CallingCubit, CallingState>(
                    buildWhen: (previous, current) =>
                        previous.isAudioOn != current.isAudioOn,
                    builder: (context, state) {
                      IconData icon = Icons.mic;
                      if (!state.isAudioOn) {
                        icon = Icons.mic_off_rounded;
                      }
                      return Icon(
                        icon,
                        size: getWidth(24),
                        color: AppColors.white,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        // SizedBox(width: getWidth(8),),

        /// it will be use during audio call loudSpeaker on/off ...
        BlocBuilder<CallingCubit, CallingState>(
          buildWhen: (previous, current) =>
              previous.isVideoIconAvailable != current.isVideoIconAvailable,
          builder: (context, state) {
            if (state.isVideoIconAvailable) {
              return const SizedBox.shrink();
            }
            return SizedBox(width: getWidth(8));
          },
        ),
        BlocBuilder<CallingCubit, CallingState>(
          buildWhen: (previous, current) =>
              previous.isVideoIconAvailable != current.isVideoIconAvailable ||
              previous.isLoudSpeaker != current.isLoudSpeaker,
          builder: (context, state) {
            if (state.isVideoIconAvailable) {
              return const SizedBox.shrink();
            }
            return Material(
              shape: const CircleBorder(),
              color: state.isLoudSpeaker
                  ? AppColors.white
                  : AppColors.greyCircleButton,
              child: InkWell(
                borderRadius: BorderRadius.circular(getWidth(50)),
                onTap: () {
                  context.read<CallingCubit>().setLoudSpeaker(
                    !state.isLoudSpeaker,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(getWidth(12)),
                  child: Icon(
                    Icons.volume_up,
                    size: state.isLoudSpeaker ? getWidth(24) : getWidth(24),
                    color: state.isLoudSpeaker
                        ? AppColors.secondaryColor
                        : AppColors.white,
                  ),
                ),
              ),
            );
          },
        ),

        /// it will be use during audio transfer to video call ...
        // Obx(() {
        //   if (controller.isVideoIconAvailable.value) {
        //     return const SizedBox.shrink();
        //   }
        //   return SizedBox(width: getWidth(8),);
        // }),
        // Obx(() {
        //   if (controller.isVideoIconAvailable.value) {
        //     return const SizedBox.shrink();
        //   }
        //   return Material(
        //     shape: const CircleBorder(),
        //     color: AppColors.greyCircleButton,
        //     child: InkWell(
        //         borderRadius: BorderRadius.circular(
        //             getWidth(50)),
        //         onTap: () async {
        //           controller.switchAudioToVideo();
        //         },
        //         child: Padding(
        //           padding: EdgeInsets.all(getWidth(12)),
        //           child: Icon(
        //             Icons.videocam,
        //             size: getWidth(24),
        //             color: AppColors.white,),
        //         )),
        //   );
        // }),
        BlocBuilder<CallingCubit, CallingState>(
          buildWhen: (previous, current) =>
              previous.isVideoOn != current.isVideoOn,
          builder: (context, state) {
            if (!state.isVideoOn) {
              return const SizedBox.shrink();
            }
            return SizedBox(width: getWidth(8));
          },
        ),
        BlocBuilder<CallingCubit, CallingState>(
          buildWhen: (previous, current) =>
              previous.isVideoOn != current.isVideoOn,
          builder: (context, state) {
            if (!state.isVideoOn) {
              return const SizedBox.shrink();
            }
            return Material(
              shape: const CircleBorder(),
              color: AppColors.greyCircleButton,
              child: InkWell(
                borderRadius: BorderRadius.circular(getWidth(50)),
                onTap: () {
                  context.read<CallingCubit>().switchCamera();
                },
                child: Padding(
                  padding: EdgeInsets.all(getWidth(12)),
                  child: Icon(
                    Icons.cameraswitch,
                    size: getWidth(24),
                    color: AppColors.white,
                  ),
                ),
              ),
            );
          },
        ),
        // SizedBox(width: getWidth(8),),
        // Material(
        //   shape: const CircleBorder(),
        //   color: AppColors.greyCircleButton,
        //   child: InkWell(
        //       borderRadius: BorderRadius.circular(getWidth(50)),
        //       onTap: () {
        //         // controller.newMessageCount(0);
        //         // Get.toNamed(Routes.chatScreen);
        //       },
        //       child: Padding(
        //         padding: EdgeInsets.all(getWidth(12)),
        //         child: Obx(() {
        //           if (controller.newMessageCount.value == 0) {
        //             return const Icon(Icons.chat,
        //               color: Colors.white,
        //               size: 24,
        //             );
        //           }
        //           return Badge(
        //             label: CustomText(
        //                 text: "${controller.newMessageCount
        //                     .value}",
        //                 color: AppColors.white,
        //                 fontSize: 12
        //             ),
        //             child: const Icon(Icons.chat,
        //               color: Colors.white,
        //               size: 24,
        //             ),
        //           );
        //         }),
        //       )),
        // ),
        BlocBuilder<CallingCubit, CallingState>(
          buildWhen: (previous, current) =>
              previous.isVideoIconAvailable != current.isVideoIconAvailable,
          builder: (context, state) {
            if (!state.isVideoIconAvailable) {
              return const SizedBox.shrink();
            }
            return SizedBox(width: getWidth(8));
          },
        ),
        BlocBuilder<CallingCubit, CallingState>(
          buildWhen: (previous, current) =>
              previous.isVideoIconAvailable != current.isVideoIconAvailable ||
              previous.isVideoOn != current.isVideoOn,
          builder: (context, state) {
            if (!state.isVideoIconAvailable) {
              return const SizedBox.shrink();
            }
            return Material(
              shape: const CircleBorder(),
              color: !state.isVideoOn
                  ? AppColors.white
                  : AppColors.greyCircleButton,
              child: InkWell(
                borderRadius: BorderRadius.circular(getWidth(50)),
                onTap: () {
                  context.read<CallingCubit>().toggleCamera();
                },
                child: Padding(
                  padding: EdgeInsets.all(getWidth(12)),
                  child: Icon(
                    Icons.videocam_off,
                    size: !state.isVideoOn ? getWidth(24) : getWidth(24),
                    color: !state.isVideoOn
                        ? AppColors.secondaryColor
                        : AppColors.white,
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(width: getWidth(8)),
        Material(
          shape: const CircleBorder(),
          color: AppColors.red,
          child: InkWell(
            borderRadius: BorderRadius.circular(getWidth(50)),
            onTap: () {
              context.read<CallingCubit>().onTapEndButton();
            },
            child: Padding(
              padding: EdgeInsets.all(getWidth(20)),
              child: Icon(
                Icons.call_end_rounded,
                size: getWidth(24),
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
