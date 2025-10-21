import 'dart:async';
import 'package:consultation_sdk/src/presentation/pages/calling/call_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/domain/repository/api_repository.dart';
import 'package:consultation_sdk/src/model/inhouse_doctor_model.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_state.dart';
import 'package:consultation_sdk/src/screen/call_waiting_screen.dart';
import 'package:consultation_sdk/consultation_sdk.dart';

class HealthPackageCubit extends Cubit<HealthPackageState> {
  static final HealthPackageState _initialState = HealthPackageState();
  final ApiRepositoryInit _repository;
  final AuthCubit _authCubit;
  final CallingCubit _callingCubit;
  HealthPackageCubit(this._repository, this._authCubit,this._callingCubit) : super(_initialState) {
    // getServicePackage();
  }

  // Get Package list
  Future<void> getServicePackage() async {
    emit(state.copyWith(isLoading: true));
    final result = await _repository.getPackageList();
    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false));
      },
      (data) {
        // state.copyWith(isLoading: false);
        data.sort((a, b) => a.order!.compareTo(b.order!));
        int index = data.indexWhere(
          (package) =>
              package.type == "telemedicine" && package.showHome == true,
        );
        if (index != -1) {
          data[index] = data[index].copyWith(selectedIndex: 1);
        }
        emit(
          state.copyWith(
            isLoading: false,
            fulPackageList: data,
            packageList: data
                .where(
                  (element) =>
                      element.showHome == true && element.isInstant == false,
                )
                .toList(),
          ),
        );
      },
    );
  }

  // Get Active Health Card
  Future<void> getActiveHealthCard(String userId) async {
    emit(state.copyWith(isHealthCardLoading: true));
    final result = await _repository.getActiveHealthCard(userId);
    result.fold(
      (error) {
        emit(state.copyWith(isHealthCardLoading: false));
      },
      (data) {
        emit(
          state.copyWith(
            isHealthCardLoading: false,
            activeHealthCardModel: data,
          ),
        );
      },
    );
  }

  /// [Get check is Card Active For Call?]
  bool getIsCardActiveForAll() {
    if (state.activeHealthCardModel != null) {
      String expiryDateString =
          "${state.activeHealthCardModel?.packageExpiredDate}";
      DateTime expiredDate = DateTime.parse(expiryDateString);
      int days = expiredDate.compareTo(DateTime.now());
      if (days != -1 &&
          state.activeHealthCardModel?.paymentStatus == "success" &&
          state.activeHealthCardModel!.isActive) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // Call Doctor Action
  void callDoctor({
    required BuildContext context,
    required bool isVideo,
  }) async {
    try {
      Utils.loadingDialog(context);
      final result = await _repository.getAvailableDoctorForPackageCall();
      Utils.closeDialog(ConsultationSdk().navigatorKey.currentState!.context);
      // Utils.closeDialog(context);
      result.fold(
        (error) {
          // Utils.showMiddleToast(AppText().doctorBusyMessage);
          createCallLogForCallWaiting(isVideo, context);
        },
        (data) {
          createCallLogAndStart(data, isVideo, context);
        },
      );
    } catch (e) {
      Utils.showMiddleToast("Something went wrong!\nPlease try again.");
    }
  }

  Future<void> createCallLogAndStart(
    InHouseDoctorModel doctorModel,
    bool isVideo,
    BuildContext context, {
    bool onlyCallLog = false,
  }) async {
    String userId = _authCubit.state.userProfileModel!.id;
    // String userId = _authCubit.serviceToken;
    var body = <String, dynamic>{};
    body.addAll({"user": userId});
    body.addAll({"doctor": doctorModel.id});
    body.addAll({"callByDoctor": false});
    try {
      Utils.loadingDialog(context);
      final result = await _repository.createCallingHistory(body);
      Utils.closeDialog(ConsultationSdk().navigatorKey.currentState!.context);
      // Utils.closeDialog(context);
      result.fold(
        (error) {
          Utils.showMiddleToast("Something went wrong!\nPlease try again.");
        },
        (data) async {
          if (onlyCallLog) {
            return;
          }
          _callingCubit.onActionCalling(
            id: data,
            callerId: userId,
            receiverId: doctorModel.id,
            isVideo: isVideo,
            name: doctorModel.fullName,
            profileImage: doctorModel.imagePath,
            token: doctorModel.fcmToken,
          );
          String id = _authCubit.state.userProfileModel?.s75 ?? "";
          if(id.isEmpty){
            String? s75 = await _authCubit.getS75();
            if(s75 != null && s75.isNotEmpty){
              _callingCubit.startVideoCalling(s75);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CallScreen(),),
              );
            } else {
              Utils.showMiddleToast("Something went wrong!\nPlease try again.");
            }
          } else {
            _callingCubit.startVideoCalling(id);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CallScreen(),),
            );
          }

        },
      );
    } catch (e) {
      Utils.showMiddleToast("Something went wrong!\nPlease try again.");
    }
  }

  Future<void> createCallLogForCallWaiting(
    bool isVideo,
    BuildContext context, {
    bool onlyCallLog = false,
  }) async {
    String userId = _authCubit.state.userProfileModel!.id;
    var body = <String, dynamic>{};
    body.addAll({"user": userId});
    body.addAll({"callByDoctor": false});
    try {
      Utils.loadingDialog(context);
      final result = await _repository.createCallingHistory(body);
      Utils.closeDialog(ConsultationSdk().navigatorKey.currentState!.context);
      // Utils.closeDialog(context);
      result.fold(
        (error) {
          Utils.showMiddleToast("Something went wrong!\nPlease try again.");
        },
        (data) async {
          String id = _authCubit.state.userProfileModel?.s75 ?? "";
          if(id.isEmpty){
            String? s75 = await _authCubit.getS75();
            if(s75 != null && s75.isNotEmpty){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CallWaitingScreen(callId: data,isVideo: isVideo,)),
              );
            } else {
              Utils.showMiddleToast("Something went wrong!\nPlease try again.");
            }
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CallWaitingScreen(callId: data,isVideo: isVideo,)),
            );
          }
          },
      );
    } catch (e) {
      Utils.showMiddleToast("Something went wrong!\nPlease try again.");
    }
  }
}
