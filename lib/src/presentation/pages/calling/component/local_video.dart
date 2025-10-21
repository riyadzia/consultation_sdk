import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_state.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/component/agora_camera_off_avater.dart';

class LocalVideo extends StatefulWidget {
  const LocalVideo({super.key});

  @override
  State<LocalVideo> createState() => _LocalVideoState();
}

class _LocalVideoState extends State<LocalVideo> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallingCubit, CallingState>(
      buildWhen: (previous, current) =>
          previous.localUserJoined != current.localUserJoined ||
          previous.callingStatus != current.callingStatus ||
          previous.isVideoOn != current.isVideoOn,
      builder: (context, state) {
        if (state.callingStatus == CallingStatus.running && state.isVideoOn) {
          return AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: state.engine!,
              canvas: VideoCanvas(
                uid: 0, // Specifies the local user
                mirrorMode: state.isFrontCameraSelected
                    ? VideoMirrorModeType.videoMirrorModeEnabled
                    : VideoMirrorModeType.videoMirrorModeDisabled,
                renderMode: RenderModeType
                    .renderModeHidden, // Sets the video rendering mode
              ),
            ),
          );
        } else {
          return const AgoraCameraOffAvatar();
        }
      },
    );
  }
}
