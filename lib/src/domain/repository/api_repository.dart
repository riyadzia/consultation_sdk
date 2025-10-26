import 'package:consultation_sdk/src/presentation/pages/settings/settings_state.dart';
import 'package:dartz/dartz.dart';
import 'package:consultation_sdk/src/core/error/failure.dart';
import 'package:consultation_sdk/src/model/active_health_card_model.dart';
import 'package:consultation_sdk/src/model/appointment_model.dart';
import 'package:consultation_sdk/src/model/inhouse_doctor_model.dart';
import 'package:consultation_sdk/src/model/package_model.dart';
import 'package:consultation_sdk/src/model/user_profile_model.dart';

abstract class ApiRepositoryInit {
  /// User Related...
  Future<Either<Failure, UserProfileModel>> verifyLoginOtp(Map<String, dynamic> body,String url);
  Future<Either<Failure, String>> getS75(String data);
  Future<Either<Failure, UserProfileModel>> getUserDataById();
  Future<Either<Failure, Map<String,dynamic>>> getHamzaLa(String data);

  /// Package Related...
  Future<Either<Failure, List<PackageModel>>> getPackageList();
  Future<Either<Failure, ActiveHealthCardModel>> buyPackage(Map<String,dynamic> body);
  Future<Either<Failure, String>> updateBookedPackage(Map<String,dynamic> body,String bpId);
  Future<Either<Failure, ActiveHealthCardModel>> getActiveHealthCard(String userId);

  /// Calling Related...
  Future<Either<Failure, InHouseDoctorModel>> getAvailableDoctorForPackageCall();
  Future<Either<Failure, String>> bookAppointment(Map<String,dynamic> body);
  Future<Either<Failure, List<AppointmentModel>>> getAppointmentList(String userId);
  Future<Either<Failure, String>> createCallingHistory(Map<String,dynamic> body);
  Future<Either<Failure, String>> updateCallingHistoryDuration(Map<String,dynamic> body,String historyId);
  /// Payment Related...
  Future<Either<Failure, String>> getEBLSignature(Map<String, String> formData);
  Future<Either<Failure, String>> eblPayment(Map<String, String> formData);
  Future<Either<Failure, String>> bKashPayemnt(Map<String, String> body);
  /// banner
  Future<Either<Failure, SettingModel>> getBanner();

}