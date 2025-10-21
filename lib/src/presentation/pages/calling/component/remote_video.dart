import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/global_widget/agora_caller_avater.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_state.dart';

class RemoteVideo extends StatelessWidget {
  const RemoteVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallingCubit, CallingState>(
      buildWhen: (previous, current) =>
          previous.remoteUid != current.remoteUid ||
          previous.callingStatus != current.callingStatus ||
          previous.isRemoteVideoOn != current.isRemoteVideoOn ||
          previous.isVideoOn != current.isVideoOn ||
          previous.isVideoIconAvailable != current.isVideoIconAvailable,
      builder: (context, state) {
        print("remoteUid: ${state.remoteUid}");
        print("callingStatus: ${state.callingStatus}");
        print("isRemoteVideoOn: ${state.isRemoteVideoOn}");
        print("isVideoOn: ${state.isVideoOn}");
        print("isVideoIconAvailable: ${state.isVideoIconAvailable}");
        if (state.remoteUid != 0 &&
            state.callingStatus == CallingStatus.running &&
            state.isRemoteVideoOn &&
            state.isVideoIconAvailable) {
          print("/////////////////showing remote video///////////////////");
          return AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: state.engine!, // Uses the Agora engine instance
              canvas: VideoCanvas(
                uid: state.remoteUid,
                backgroundColor: 0x00000000,
                mirrorMode: state.isRemoteCameraMirror
                    ? VideoMirrorModeType.videoMirrorModeEnabled
                    : VideoMirrorModeType.videoMirrorModeDisabled,
                position: VideoModulePosition.positionPreEncoder,
              ),
              connection: RtcConnection(
                channelId: state.id,
              ), // Specifies the channel
            ),
          );
        } else if (state.callingStatus == CallingStatus.calling || state.callingStatus == CallingStatus.ringing &&
            state.isVideoOn) {
          print("///////////////// showing local video ///////////////////");
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
          print("///////////////// showing video avater ///////////////////");
          return const AgoraCallerAvatar();
        }
      },
    );
  }
}
