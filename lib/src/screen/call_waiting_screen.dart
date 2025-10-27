import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/di/seignalling_service.dart';
import 'package:consultation_sdk/src/domain/repository/api_repository.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/global_widget/page_pinky_background.dart';
import 'package:consultation_sdk/src/model/inhouse_doctor_model.dart';
import 'package:consultation_sdk/src/model/user_profile_model.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/call_manager.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/call_screen.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_cubit.dart';

class CallWaitingScreen extends StatefulWidget {
  const CallWaitingScreen({
    super.key,
    required this.callId,
    required this.isVideo,
  });

  final String callId;
  final bool isVideo;

  @override
  State<CallWaitingScreen> createState() => _CallWaitingScreenState();
}

class _CallWaitingScreenState extends State<CallWaitingScreen> {
  // final callWaitingController = Get.find<CallWaitingController>();

  final socket = SignallingService.instance.socket;
  UserProfileModel? user;

  @override
  void initState() {
    user = context.read<AuthCubit>().state.userProfileModel;
    emitAddQueue();
    playWaitingTone();
    super.initState();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  void emitAddQueue(){
    socket!.emit('add-to-queue', {
      "userId": "${user?.id}",
    });
    waitingForDoctorAvailable();
  }

  void waitingForDoctorAvailable() {
    socket!.on("available-doctor", (data) async {
      socket!.off("available-doctor");
      InHouseDoctorModel doctorModel = InHouseDoctorModel.fromJson(
        data["doctor"],
      );
      String userId = context.read<AuthCubit>().state.userProfileModel!.id;
      var body = <String,dynamic>{};
      body.addAll({"user": userId});
      body.addAll({"doctor": doctorModel.id});
      body.addAll({"callByDoctor": false});
      context.read<ApiRepositoryInit>().updateCallingHistoryDuration(body, widget.callId);
      context.read<CallingCubit>().onActionCalling(
        id: data,
        callerId: userId,
        receiverId: doctorModel.id,
        isVideo: widget.isVideo,
        name: doctorModel.fullName,
        profileImage: doctorModel.imagePath,
        token: doctorModel.fcmToken,
      );
      String id = context.read<AuthCubit>().state.userProfileModel?.s75 ?? "";
      context.read<CallingCubit>().startVideoCalling(id);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CallScreen(),),
      );
    });
  }

  final audioPlayer = AudioPlayer();
  void playWaitingTone()async {
    try{
      // await audioPlayer.setUrl("http://clinicall-files.obs.as-south-208.rcloud.reddotdigitalit.com/upload-file-22102025T113906-call_waiting.wav");
      await audioPlayer.setUrl("http://clinicall-files.obs.as-south-208.rcloud.reddotdigitalit.com/upload-file-27102025T181055-call_waiting.mp3");
      audioPlayer.setLoopMode(LoopMode.one);

      if(widget.isVideo){
        audioPlayer.setVolume(0.6);
        // CallManager.setEarpiece(isEarpiece: false);
      } else {
        audioPlayer.setVolume(1);
        CallManager.setEarpiece();
      }
      audioPlayer.play();
    } catch (e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
  void pause(){
    if(audioPlayer.playing){
      audioPlayer.pause();
    }
  }
  void stop(){
    if(audioPlayer.playing){
      audioPlayer.stop();
    }
  }

  /// update Call duration for doctor
  Future<void> callHistoryUpdateOnCancel() async {
    context.read<ApiRepositoryInit>().updateCallingHistoryDuration({"callCancelled": true},widget.callId);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top],
    );
    return Scaffold(
      body: SizedBox(
        height: screenHeight(),
        width: screenWidth(),
        child: Stack(
          children: [
            Positioned.fill(child: PagePinkyBackground()),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: SizedBox(height: screenHeight(), width: screenWidth()),
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
                  CustomText(
                    text: "CliniCall",
                    fontSize: getWidth(22),
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text: "",
                    fontSize: getWidth(14),
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    text: "Waiting...",
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: getWidth(14),
                  ),
                  SizedBox(height: getWidth(8)),
                  CustomText(text: "08000444777", fontSize: getWidth(14)),
                  SizedBox(height: getWidth(8)),
                ],
              ),
            ),

            /// All Bottom Buttons
            Positioned(
              bottom: getWidth(50),
              left: 0,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    shape: const CircleBorder(),
                    color: AppColors.red,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(getWidth(50)),
                      onTap: () {
                        callHistoryUpdateOnCancel();
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
