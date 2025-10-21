import 'package:agora_rtc_engine/agora_rtc_engine.dart';
enum CallingStatus { initial, calling, ringing, waiting, running, endCall }

class CallingState {
  final String id;
  final RtcEngine? engine;
  final bool localUserJoined;
  final int remoteUid;
  final CallingStatus callingStatus;
  final String callerId;
  final String receiverId;
  final String name;
  final String profileImage;
  final String remotePhone;
  final String receiverFcmToken;
  // Calling function
  final bool isVideoIconAvailable;
  final bool isAudioOn;
  final bool isVideoOn;
  final bool isRemoteVideoOn;
  final bool isRemoteMute;
  final bool isFrontCameraSelected;
  final bool isRemoteCameraMirror;
  final bool isLoudSpeaker;
  // timer
  final int duration;
  final String durationInText;
  final bool onTapEndButton;

  CallingState({
    required this.id,
    this.engine,
    this.localUserJoined = false,
    this.remoteUid = 0,
    this.callingStatus = CallingStatus.initial,
    this.callerId = "",
    this.receiverId = "",
    this.name = "",
    this.profileImage = "",
    this.remotePhone = "",
    this.receiverFcmToken = "",
    this.isVideoIconAvailable = false,
    this.isAudioOn = true,
    this.isVideoOn = true,
    this.isRemoteVideoOn = true,
    this.isRemoteMute = false,
    this.isFrontCameraSelected = true,
    this.isRemoteCameraMirror = true,
    this.isLoudSpeaker = false,
    this.duration = 0,
    this.durationInText = "00:00",
    this.onTapEndButton = false,
  });

  CallingState copyWith({
    String? id,
    RtcEngine? engine,
    bool? localUserJoined,
    int? remoteUid,
    CallingStatus? callingStatus,
    String? callerId,
    String? receiverId,
    String? name,
    String? profileImage,
    String? remotePhone,
    String? receiverFcmToken,
    // Calling function
    bool? isVideoIconAvailable,
    bool? isAudioOn,
    bool? isVideoOn,
    bool? isRemoteVideoOn,
    bool? isRemoteMute,
    bool? isFrontCameraSelected,
    bool? isRemoteCameraMirror,
    bool? isLoudSpeaker,
    // timer
    int? duration,
    String? durationInText,
    bool? onTapEndButton,
  }) {
    return CallingState(
      id: id ?? this.id,
      engine: engine ?? this.engine,
      receiverId: receiverId ?? this.receiverId,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      remotePhone: remotePhone ?? this.remotePhone,
      remoteUid: remoteUid ?? this.remoteUid,
      callerId: callerId ?? this.callerId,
      localUserJoined: localUserJoined ?? this.localUserJoined,
      callingStatus: callingStatus ?? this.callingStatus,
      receiverFcmToken: receiverFcmToken ?? this.receiverFcmToken,
      isVideoIconAvailable: isVideoIconAvailable ?? this.isVideoIconAvailable,
      isAudioOn: isAudioOn ?? this.isAudioOn,
      isVideoOn: isVideoOn ?? this.isVideoOn,
      isRemoteVideoOn: isRemoteVideoOn ?? this.isRemoteVideoOn,
      isRemoteMute: isRemoteMute ?? this.isRemoteMute,
      isFrontCameraSelected: isFrontCameraSelected ?? this.isFrontCameraSelected,
      isRemoteCameraMirror: isRemoteCameraMirror ?? this.isRemoteCameraMirror,
      isLoudSpeaker: isLoudSpeaker ?? this.isLoudSpeaker,
      duration: duration ?? this.duration,
      durationInText: durationInText ?? this.durationInText,
      onTapEndButton: onTapEndButton ?? this.onTapEndButton,
    );
  }
}
