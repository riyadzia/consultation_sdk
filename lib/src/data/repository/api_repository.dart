import 'dart:convert';

import 'package:consultation_sdk/src/presentation/pages/settings/settings_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/contants.dart';
import 'package:consultation_sdk/src/core/error/exception.dart';
import 'package:consultation_sdk/src/core/error/failure.dart';
import 'package:consultation_sdk/src/domain/repository/api_repository.dart';
import 'package:consultation_sdk/src/domain/repository/remote_database.dart';
import 'package:consultation_sdk/src/model/active_health_card_model.dart';
import 'package:consultation_sdk/src/model/appointment_model.dart';
import 'package:consultation_sdk/src/model/inhouse_doctor_model.dart';
import 'package:consultation_sdk/src/model/package_model.dart';
import 'package:consultation_sdk/src/model/user_profile_model.dart';
import 'package:consultation_sdk/src/data/repository/remote_database.dart';

class ApiRepository extends ApiRepositoryInit {
  final RemoteDataSourceInit _remoteDataSource;
  ApiRepository(this._remoteDataSource,);

  /// User Related...
  @override
  Future<Either<Failure, UserProfileModel>> verifyLoginOtp(Map<String, dynamic> body,String url) async {
    try {
      //final result = await remoteDataSource.userRegister(body);
      final responseResult = await _remoteDataSource.postRequest(
        body: body,
        url: url,
      );
      if (responseResult["success"] == false) {
        final errorMsg = responseResult["message"];
        throw UnauthorisedException(errorMsg, 401);
      } else {
        return Right(UserProfileModel.fromJson(responseResult["data"]));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> getS75(String data) async {
    try {
      final headers = {'Accept': 'application/json', 'authorization': data};
      final responseResult = await _remoteDataSource.getRequest(
        body: {SHAKIB: YES},
        url: "${BaseUrl().baseUrl}girls-minds/read",
        customHeader: headers
      );
      if (responseResult["success"] == false) {
        final errorMsg = responseResult["message"];
        throw UnauthorisedException(errorMsg, 401);
      } else {
        return Right(responseResult["data"]["shakib"]);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> getUserDataById() async {
    try {
      final result = await _remoteDataSource.getRequest(
        url: "${BaseUrl().baseUrl}auth/user/getByToken",
      );
      if(result["success"] == true){
        UserProfileModel userProfileModel = UserProfileModel.fromJson(result["data"]);
        return Right(userProfileModel);
      } else {
        return const Left(ServerFailure("User not found!", 410));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    catch (e){
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString(), 410));
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> getHamzaLa(String data) async {
    try {
      final headers = {'Accept': 'application/json', 'authorization': data};
      final responseResult = await _remoteDataSource.getRequest(
          body: {HAMZA: YES,KHALEDA: YES},
          url: "${BaseUrl().baseUrl}girls-minds/read",
          customHeader: headers
      );
      if (responseResult["success"] == false) {
        final errorMsg = responseResult["message"];
        throw UnauthorisedException(errorMsg, 401);
      } else {
        return Right(responseResult["data"]);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }


  /// Package Related...
  @override
  Future<Either<Failure, List<PackageModel>>> getPackageList() async {
    try {
      final result = await _remoteDataSource.getRequest(
        url: "${BaseUrl().baseUrl}package/getall",
        body: {"packageType": "b2c","showHome": 'true'},
      );
      if(result["success"] == true){
        List<PackageModel> packageList =
        List<PackageModel>.from(result['data']?.map((x) => PackageModel.fromJson(x)));
        return Right(packageList);
      } else {
        return const Right([]);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    catch (e){
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString(), 410));
    }
  }

  @override
  Future<Either<Failure, ActiveHealthCardModel>> buyPackage(Map<String, dynamic> body) async {
    try {
      final result = await _remoteDataSource.postRequest(
          url: "${BaseUrl().baseUrl}package/book/new",
          body: body
      );
      if(result["success"] == true){
        ActiveHealthCardModel healthCard = ActiveHealthCardModel.fromJson(result["data"]);
        return Right(healthCard);
      } else {
        return Left(ServerFailure(result["message"], 410));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    catch (e){
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString(), 410));
    }
  }
  @override
  Future<Either<Failure, ActiveHealthCardModel>> getActiveHealthCard(String userId) async {
    try {
      final result = await _remoteDataSource.getRequest(
        url: "${BaseUrl().baseUrl}bookedPackage/getByUid/$userId",
      );
      if(result["success"] == true){
        ActiveHealthCardModel healthCard = ActiveHealthCardModel.fromJson(result["data"]);
        return Right(healthCard);
      } else {
        return Left(ServerFailure(result["message"], 410));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    catch (e){
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString(), 410));
    }
  }
  @override
  Future<Either<Failure, String>> updateBookedPackage(Map<String, dynamic> body, String bpId) async {
    try {
      final result = await _remoteDataSource.patchRequest(
          url: "",
          body: body
      );
      if(result["success"] == true){
        return Right(result["message"]);
      } else {
        return Left(ServerFailure(result["message"], 410));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    catch (e){
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString(), 410));
    }
  }

  /// Call Related...
  @override
  Future<Either<Failure, InHouseDoctorModel>> getAvailableDoctorForPackageCall() async {
    try {
      final result = await _remoteDataSource.getRequest(
        url: "${BaseUrl().baseUrl}doctor/get/available",
      );
      if(result["success"] == true){
        InHouseDoctorModel doctorModel = InHouseDoctorModel.fromJson(result["data"]);
        return Right(doctorModel);
      } else {
        return const Left(ServerFailure("All Doctor's are busy, Please try later", 410));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    ///todo will be remove the comment
    catch (e){
      debugPrint("${e.toString()}, in");
      return Left(ServerFailure(e.toString(), 410));
    }
  }
  @override
  Future<Either<Failure, String>> createCallingHistory(Map<String, dynamic> body) async {
    try {
      final result = await _remoteDataSource.postRequest(
          url: "${BaseUrl().baseUrl}doctor/call-history/create",
          body: body
      );
      if(result["success"] == true){
        return Right(result["data"]["_id"]);
      } else {
        return Left(ServerFailure("Something went wrong!\nTry Again", 410));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    ///todo will be remove the comment
    catch (e){
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString(), 410));
    }
  }
  @override
  Future<Either<Failure, String>> updateCallingHistoryDuration(Map<String, dynamic> body, String historyId) async {
    try {
      final result = await _remoteDataSource.patchRequest(
          url: "${BaseUrl().baseUrl}doctor/call-history/update/$historyId",
          body: body
      );
      if(result["success"] == true){
        return Right(result["message"]);
      } else {
        return Left(ServerFailure("Something went wrong!\nTry Again", 410));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    catch (e){
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString(), 410));
    }
  }
  @override
  Future<Either<Failure, String>> bookAppointment(Map<String, dynamic> body) async {
    try {
      final result = await _remoteDataSource.postRequest(
          url: "${BaseUrl().baseUrl}doctor/book/appointment",
          body: body
      );
      if(result["success"] == true){
        return Right(result["data"]["invoiceNumber"]);
      } else {
        return Left(ServerFailure("Something went wrong!\nTry Again", 410));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    catch (e){
      debugPrint("${e.toString()}, in ");
      return Left(ServerFailure(e.toString(), 410));
    }
  }
  @override
  Future<Either<Failure, List<AppointmentModel>>> getAppointmentList(String userId) async {
    try {
      final result = await _remoteDataSource.getRequest(
        url: "RemoteUrls.getAppointment(userId)",
      );
      if(result["success"] == true){
        List<AppointmentModel> appointmentList =
        List<AppointmentModel>.from(result['data']?.map((x) => AppointmentModel.fromJson(x)));
        return Right(appointmentList);
      } else {
        return Left(ServerFailure("Something went wrong!\nTry Again", 410));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    catch (e){
      debugPrint("${e.toString()}, in ");
      return Left(ServerFailure(e.toString(), 410));
    }
  }


  /// Payment Related...
  @override
  Future<Either<Failure, String>> getEBLSignature(Map<String, String> formData) async {
    try {
      final result = await _remoteDataSource.postRequest(
          url: BaseUrl.getEBLSignature,
          body: formData
      );
      if(result["success"] == true){
        return Right(result["data"]["signature"]);
      } else {
        return const Right("Payment Failed");
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    catch (e){
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString(), 410));
    }
  }
  @override
  Future<Either<Failure, String>> bKashPayemnt(Map<String, String> body) async {
    try {
      final result = await _remoteDataSource.postRequest(
          url: BaseUrl.bKashPayemnt,
          body: body
      );
      if(result["success"] == true){
        return Right(result["data"]["bkashURL"]);
      } else {
        return const Right("Payment Failed");
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    ///todo will be remove the comment
    catch (e){
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString(), 410));
    }
  }

  @override
  Future<Either<Failure, String>> eblPayment(Map<String, String> formData) async {
    try {
      final result = await _remoteDataSource.postRequest(
          url: BaseUrl().eblPaymentLive,
          body: formData
      );
      if(result["success"] == true){
        return const Right("Payment Success");
      } else {
        return const Right("Payment Failed");
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    catch (e){
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString(), 410));
    }
  }

  @override
  Future<Either<Failure, SettingModel>> getBanner() async {
    try {
      final result = await _remoteDataSource.getRequest(
          url: "${BaseUrl().baseUrl}settings/find-all",
      );
      if(result["success"] == true){
        SettingModel settingModel = SettingModel.fromJson(result["data"]);
        return Right(settingModel);
      } else {
        return Left(ServerFailure(result["message"], 410));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
    catch (e){
      debugPrint(e.toString());
      return Left(ServerFailure(e.toString(), 410));
    }
  }
}