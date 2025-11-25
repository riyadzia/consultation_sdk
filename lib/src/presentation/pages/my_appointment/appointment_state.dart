import 'package:consultation_sdk/src/model/active_health_card_model.dart';
import 'package:consultation_sdk/src/model/appointment_model.dart';
import 'package:consultation_sdk/src/model/package_model.dart';

class AppointmentState {
  final List<AppointmentModel> appointmentList;
  final bool isLoading;

  AppointmentState({
    this.appointmentList = const [],
    this.isLoading = false,
  });

  AppointmentState copyWith({
    List<AppointmentModel>? appointmentList,
    bool? isLoading,
  }) {
    return AppointmentState(
      appointmentList: appointmentList ?? this.appointmentList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
