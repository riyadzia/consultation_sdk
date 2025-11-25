import 'dart:async';
import 'package:consultation_sdk/src/model/active_health_card_model.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/call_screen.dart';
import 'package:consultation_sdk/src/presentation/pages/my_appointment/appointment_state.dart';
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

class AppointmentCubit extends Cubit<AppointmentState> {
  static final AppointmentState _initialState = AppointmentState();
  final ApiRepositoryInit _repository;
  final AuthCubit _authCubit;
  AppointmentCubit(this._repository, this._authCubit) : super(_initialState) {
    // getAppointment();
  }

  // Get Appointment list
  Future<void> getAppointment() async {
    String id = "${_authCubit.state.userProfileModel?.id}";
    emit(state.copyWith(isLoading: true));
    final result = await _repository.getAppointmentList(id);
    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false));
      },
      (data) {
        emit(state.copyWith(isLoading: false, appointmentList: data));
      },
    );
  }
}
