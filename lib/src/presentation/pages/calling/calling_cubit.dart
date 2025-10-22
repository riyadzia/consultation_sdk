import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:consultation_sdk/src/core/contants.dart';
import 'package:consultation_sdk/src/core/enums.dart';
import 'package:consultation_sdk/src/di/seignalling_service.dart';
import 'package:consultation_sdk/src/domain/repository/api_repository.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/call_manager.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_state.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_state.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_state.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_state.dart';
import 'package:consultation_sdk/consultation_sdk.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../di/injector.dart';

class CallingCubit extends Cubit<CallingState> {
  static final CallingState _initialState = CallingState(id: "");
  var socket = SignallingService.instance.socket;
  final AuthCubit _cubit;
  final ApiRepositoryInit _repository;
  CallingCubit(this._repository, this._cubit) : super(_initialState);

  // for caller image avatar
  String avatar =
      "https://clinicall-files.obs.as-south-208.rcloud.reddotdigitalit.com/upload-file-17022025T093918-doctor.png";
  String get userImage {
    if (_cubit.state.userProfileModel == null) {
      return avatar;
    } else if (_cubit.state.userProfileModel!.image.isEmpty) {
      return avatar;
    }
    return _cubit.state.userProfileModel!.image;
  }

  void onActionCalling({
    String callerId = "",
    String receiverId = "",
    String id = "",
    String name = "",
    String profileImage = "",
    String token = "",
    bool isVideo = false,
  }) {
    emit(
      state.copyWith(
        callerId: callerId,
        receiverId: receiverId,
        id: id,
        name: name,
        profileImage: profileImage,
        receiverFcmToken: token,
        isVideoOn: isVideo,
        isVideoIconAvailable: isVideo,
        isRemoteVideoOn: isVideo,
        callingStatus: CallingStatus.initial,
        remoteUid: 0,
        duration: 0,
        durationInText: "00:00",
        isRemoteMute: false,
        isLoudSpeaker: isVideo,
        isAudioOn: true,
        isFrontCameraSelected: true,
        isRemoteCameraMirror: true,
      ),
    );
  }

  void assignedSocket() {
    socket = SignallingService.instance.socket;
  }

  // Initializes Agora SDK
  Future<void> startVideoCalling(String zz) async {
    if(state.isVideoOn == true){
      WakelockPlus.enable();
    }
    assignedSocket();
    onKernelStatus();
    await _requestPermissions();
    await _initializeAgoraVideoSDK(zz);
    await setupLocalVideo();
    _setupEventHandlers();
    await joinChannel();
  }

  Future<void> stopVideoCalling() async {
    // socket?.off("call-ended");
    // socket?.off("call-ringing");
    // socket?.off("call-waiting");
    // socket?.off("call-rejected");
    // socket?.off("kernel-status-change");
    await state.engine?.leaveChannel();
    await state.engine?.release();
    if(timer != null){
      timer?.cancel();
    }
    if(ringTimer != null){
      ringTimer?.cancel();
    }
    CallManager.stopForegroundCallService();
    stopOutgoingRingtone();
    WakelockPlus.disable();
    emit(
      state.copyWith(
        callingStatus: CallingStatus.initial,
        duration: 0,
        durationInText: "00:00",
        engine: null,
        localUserJoined: false,
        remoteUid: 0,
        remotePhone: "",
        callerId: "",
        receiverId: "",
        id: "",
        name: "",
        profileImage: "",
        receiverFcmToken: "",
        onTapEndButton: false,
      ),
    );
  }

  // Requests microphone and camera permissions
  Future<void> _requestPermissions() async {
    await [Permission.microphone, Permission.camera].request();
  }

  Future<void> _initializeAgoraVideoSDK(String zz) async {
    emit(state.copyWith(engine: createAgoraRtcEngine()));
    await state.engine?.initialize(
      RtcEngineContext(
        appId: zz,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
    await setAudioCallOrVideoCall(state.isVideoOn);
    CallManager.startForegroundCallService(state.name,"Calling",state.isVideoOn ? "video" : "audio");
  }

  // Join a channel
  Future<void> joinChannel() async {
    state.engine?.leaveChannel();
    await state.engine?.joinChannel(
      token: "",
      channelId: state.id,
      options: ChannelMediaOptions(
        autoSubscribeVideo: state.isVideoOn,
        // Automatically subscribe to all video streams
        autoSubscribeAudio: true,
        // Automatically subscribe to all audio streams
        publishCameraTrack: state.isVideoOn,
        // Publish camera-captured video
        publishMicrophoneTrack: true,
        // Publish microphone-captured audio
        // Use clientRoleBroadcaster to act as a host or clientRoleAudience for audience
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      uid: 0,
    );
  }

  // Register an event handler for Agora RTC
  void _setupEventHandlers() {
    state.engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          emit(state.copyWith(localUserJoined: true));
          // make a call to remote peer over signalling
          socket!.emit('make-call', {
            "callerId": state.callerId,
            "receiverId": state.receiverId,
            "offer": {},
            "pushOffer": "push",
            "token": state.receiverFcmToken,
            "callerName": _cubit.state.userProfileModel?.fullName,
            "phone": _cubit.state.userProfileModel?.number,
            "dialCode": _cubit.state.userProfileModel?.dialCode,
            "countryCode": _cubit.state.userProfileModel?.countryCode,
            "callerImage": userImage,
            "callerOrganization": _cubit.state.userProfileModel?.organization,
            "id": state.id,
            "agoraChannel": state.id,
            "isVideo": state.isVideoOn ? 1 : 0,
          });
          emit(state.copyWith(callingStatus: CallingStatus.calling));
          setLoudSpeaker(state.isVideoOn);
          startRingingTimer();
          playOutgoingRingtone();
          onRinging();
          onWaiting();
          onRejectCall();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          ringTimer?.cancel();
          emit(
            state.copyWith(
              callingStatus: CallingStatus.running,
              remoteUid: remoteUid,
            ),
          );
          stopOutgoingRingtone();
          startTimer();
          onEndCall();
          // disableFreeCall();
          updateCallHistory({"callReceived": true});
          // getUserDataById();
          postBookAppointment();
          CallManager.startForegroundCallService(state.name,"Connected",state.isVideoOn ? "video" : "audio");
        },
        onUserOffline:
            (
              RtcConnection connection,
              int remoteUid,
              UserOfflineReasonType reason,
            ) {
              debugPrint("Remote user $remoteUid left");
              if (reason == UserOfflineReasonType.userOfflineQuit) {
                updateCallHistory({"duration": state.duration});
              } else if (reason == UserOfflineReasonType.userOfflineDropped) {
                updateCallHistory({"duration": state.duration});
              }
              emit(state.copyWith(remoteUid: 0));
            },
        onUserMuteAudio: (connection, remoteUid, muted) {
          emit(state.copyWith(isRemoteMute: muted));
        },
        onUserMuteVideo: (connection, remoteUid, muted) {
          // print("onUserMuteVideo((((((((((${(muted)}/ $remoteUid/ ${connection.channelId}))))))))))");
          emit(state.copyWith(isRemoteVideoOn: !muted));
        },
        onUserStateChanged: (connection, remoteUid, state) {},
      ),
    );
  }

  Future<void> setupLocalVideo() async {
    await state.engine?.enableVideo();
    await state.engine?.startPreview();
  }

  Future<void> setAudioCallOrVideoCall(bool isVideoCall) async {
    if (isVideoCall) {
      await state.engine?.enableVideo();
      await state.engine?.enableAudio();
    } else {
      // await state.engine?.disableVideo();
      // await state.engine?.enableVideo();
      await state.engine?.enableAudio();
    }
  }

  void onEndCall() {
    socket!.on("call-ended", (data) {
      updateCallHistory({"duration": state.duration});
      // onPageBack();
      emit(state.copyWith(onTapEndButton: true));
    });
  }

  void emitEndCall() {
    socket!.emit("end-call", {
      "callerId": state.callerId,
      "receiverId": state.receiverId,
      "id": state.id,
    });
    updateCallHistory({"duration": state.duration});
    // onPageBack();
    emit(state.copyWith(onTapEndButton: true));
  }

  /// Engage Ringtone
  void playOutgoingRingtone() async {
    CallManager.playOutgoingTone();
  }

  void stopOutgoingRingtone() async {
    CallManager.stopOutgoingTone();
  }

  void setLoudSpeaker(bool enable) async {
    emit(state.copyWith(isLoudSpeaker: enable));
    try {
      await state.engine?.setEnableSpeakerphone(enable);
      if (kDebugMode) {
        print("Speakerphone ${enable ? "ON" : "OFF"}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error toggling speaker: $e");
      }
    }
  }

  /// todo: Add this method in Video Service-Backend
  void onRinging() {
    // callingStatus(CallingStatus.calling);
    socket!.on("call-ringing", (data) {
      emit(state.copyWith(callingStatus: CallingStatus.ringing));
      updateCallHistory({"callReached": true});
      CallManager.startForegroundCallService(state.name, "Ringing",state.isVideoOn ? "video" : "audio");
    });
  }

  /// todo: Add this method in Video Service-Backend
  void onWaiting() {
    socket!.on("call-waiting", (data) {
      stopOutgoingRingtone();
      emit(state.copyWith(callingStatus: CallingStatus.waiting));
      updateCallHistory({"callReached": true});
      Future.delayed(const Duration(seconds: 2)).then((value) {
        emit(state.copyWith(onTapEndButton: true));
      });
    });
  }

  void onRejectCall() {
    socket!.on("call-rejected", (data) {
      stopOutgoingRingtone();
      updateCallHistory({"callRejected": true});
      // onPageBack();
      emit(state.copyWith(onTapEndButton: true));
      // localRTCVideoRenderer.value?.dispose();
      // remoteRTCVideoRenderer.value?.dispose();
      // localStream.value?.dispose();
      // _rtcPeerConnection?.dispose();
      // Utils.showSnackBar(message: "Line Busy");
      // Get.back();
    });
  }

  void emitRejectCall() {
    socket!.emit("reject-call", {
      "callerId": state.callerId,
      "receiverId": state.receiverId,
      "id": state.id,
    });
    updateCallHistory({"callRejected": true});
  }

  void emitCancelCall({bool isAction = true}) {
    socket!.emit("cancell-call", {
      "callerId": state.callerId,
      "receiverId": state.receiverId,
      "id": state.id,
    });
    if (isAction) {
      // onPageBack();
      emit(state.copyWith(onTapEndButton: true));
    }
  }

  void onTapEndButton() {
    if (timer == null) {
      stopOutgoingRingtone();
      updateCallHistory({"callCancelled": true});
      emitCancelCall();
    } else {
      emitEndCall();
    }
  }

  void onPageBack1() {
    // Navigator.of(TestSdk.navigatorKey.currentState!.context).pop();
    // localRTCVideoRenderer.value?.dispose();
    // remoteRTCVideoRenderer.value?.dispose();
    // localStream.value?.dispose();
    // _rtcPeerConnection?.dispose();
    // Get.back();
  }

  toggleMicrophone() async {
    emit(state.copyWith(isAudioOn: !state.isAudioOn));
    await state.engine?.muteLocalAudioStream(state.isAudioOn == false);
    emitKernelStatus();
  }

  toggleCamera() async {
    emit(state.copyWith(isVideoOn: !state.isVideoOn));
    await state.engine?.muteLocalVideoStream(state.isVideoOn == false);
    emitKernelStatus();
  }

  switchCamera() async {
    // change status
    emit(state.copyWith(isFrontCameraSelected: !state.isFrontCameraSelected));
    await state.engine?.switchCamera();
    emitKernelStatus();
  }

  void emitKernelStatus() {
    socket!.emit("kernel-status-change", {
      "targetedId": state.receiverId,
      "id": state.id,
      "isFrontCameraSelected": state.isFrontCameraSelected ? true : false,
      "isCameraOff": state.isVideoOn ? false : true,
      "isMute": state.isAudioOn ? false : true,
    });
  }

  void onKernelStatus() {
    socket!.on("kernel-status-change", (data) {
      // print("onKernelStatus((((((((($data)))))))))");
      emit(
        state.copyWith(
          isRemoteVideoOn: !data["isCameraOff"],
          isRemoteCameraMirror: data["isFrontCameraSelected"],
          isRemoteMute: data["isMute"],
        ),
      );
    });
  }

  /// for call timer
  Timer? timer;
  void startTimer() async {
    if (timer != null) {
      timer?.cancel();
    }
    // await FlutterCallkitIncoming.setCallConnected(id.value);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final time = Duration(seconds: timer.tick);
      emit(
        state.copyWith(
          duration: timer.tick,
          durationInText: time.toString().substring(2, 7),
        ),
      );
    });
  }

  /// For ringingTimer
  Timer? ringTimer;
  void startRingingTimer() async {
    ringTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (ringTimer?.tick == 30) {
        emitCancelCall();
      }
    });
  }

  /// Create Appointment by doctor after receive call
  Future<void> postBookAppointment() async {
    if (_cubit.state.userProfileModel!.role1 == UserRole.patient ||
        _cubit.state.userProfileModel!.role1 == UserRole.b2bPatient) {
      var body = <String, dynamic>{};
      body.addAll({"date": ymdDateFormat.format(DateTime.now())});
      // body.addAll({"time": TimeOfDay.now().format(Get.context!)});
      body.addAll({"fullName": "${_cubit.state.userProfileModel?.fullName}"});
      body.addAll({"gender": "${_cubit.state.userProfileModel?.gender}"});
      body.addAll({"age": ""});
      body.addAll({"weight": ""});
      body.addAll({"phone": "${_cubit.state.userProfileModel?.number}"});
      body.addAll({"dialCode": "${_cubit.state.userProfileModel?.dialCode}"});
      body.addAll({
        "countryCode": "${_cubit.state.userProfileModel?.countryCode}",
      });
      body.addAll({"email": "${_cubit.state.userProfileModel?.email}"});
      body.addAll({"user": state.callerId});
      body.addAll({"doctor": state.receiverId});
      body.addAll({"amount": "0"});
      body.addAll({"isForFreeCall": true});

      if (kDebugMode) {
        print(body);
      }
      final result = await _repository.bookAppointment(body);
      result.fold((error) {}, (data) {});
    }
  }

  /// update Call duration for doctor
  Future<void> updateCallHistory(Map<String, dynamic> body) async {
    final result = await _repository.updateCallingHistoryDuration(
      body,
      state.id,
    );
    result.fold((error) {}, (data) {});
  }
}
