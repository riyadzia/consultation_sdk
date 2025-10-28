import 'dart:async';
import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/error/exception.dart';
import 'package:consultation_sdk/src/core/error/failure.dart';
import 'package:consultation_sdk/src/core/helper.dart';
import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/di/injector.dart';
import 'package:consultation_sdk/src/di/seignalling_service.dart';
import 'package:consultation_sdk/src/domain/repository/api_repository.dart';
import 'package:consultation_sdk/src/domain/repository/remote_database.dart';
import 'package:consultation_sdk/src/model/user_profile_model.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_state.dart';
import 'package:consultation_sdk/src/screen/home_screen.dart';

String token = "";

class AuthCubit extends Cubit<AuthState> {
  static final AuthState _initialState = AuthState();
  final ApiRepositoryInit _repository;
  AuthCubit(this._repository) : super(_initialState) {
    // getUserProfileData();
  }

  String? _serviceToken;
  String get serviceToken => _serviceToken ?? "";
  setServiceToken(String? value) {
    _serviceToken = value;
  }

  Future<String?> getS75() async {
    final result = await _repository.getS75(serviceToken);
    result.fold((error) {
      return null;
    }, (data) {
      UserProfileModel user = state.userProfileModel!.copyWith(s75: data);
      emit(state.copyWith(userProfileModel: user));
      return data;
    });
    return null;
  }

  // Get Active Health Card
  Future<void> getUserProfileData() async {
    SignallingService.instance.disconnect();
    emit(state.copyWith(isLoading: true, isLoaded: false, error: ""));
    final result = await _repository.getUserDataById();
    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error.message));
      },
      (data) {
        Utils.initSignallingService(data.id);
        emit(
          state.copyWith(
            isLoading: false,
            userProfileModel: data,
            isLoaded: true,
          ),
        );
        getS75();
      },
    );
  }

  // Get Active Health Card
  Future<void> verifyOtp(
    BuildContext context, {
    required String countryCode,
    required String dialCode,
    required String phoneNumber,
    required String otp,
    required String serviceId,
  }) async {
    _serviceToken = serviceId;
    SignallingService.instance.disconnect();
    emit(state.copyWith(isLoading: true, isLoaded: false, error: ""));
    final body = <String, dynamic>{};

    body.addAll({"dialCode": dialCode.trim()});
    body.addAll({"phone": phoneNumber.trim()});
    body.addAll({"otp": otp});

    String url = "${BaseUrl().baseUrl}auth/user/otp/signin/check";

    final result = await _repository.verifyLoginOtp(body, url);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            error: error.message,
            isLoaded: false,
          ),
        );
      },
      (data) {
        Utils.initSignallingService(data.id);
        token = data.accessToken;
        emit(
          state.copyWith(
            isLoading: false,
            userProfileModel: data,
            isLoaded: true,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(
              countryLetterCode: countryCode,
              dialCode: dialCode,
              phoneNumber: phoneNumber,
              authToken: data.accessToken,
              serviceToken: serviceId,
            ),
          ),
        );
      },
    );
  }
}

class MyApi {
  Future<Either<Failure, String>> sendOtp({
    required String countryLetterCode,
    required String dialCode,
    required String phoneNumber,
    required String serviceToken,
  }) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final salt = Random().nextInt(1 << 32).toString();

    final body = <String, String>{};
    body.addAll({"countryCode": countryLetterCode.trim()});
    body.addAll({"dialCode": dialCode.replaceAll("+", "")});
    body.addAll({"phone": "${phoneNumber.trim()}:$salt:$time"});
    body.addAll({"provider": "sdk"});
    final String? country = await Utils.encryptText(
      phoneNumber.trim(),
      salt,
      time,
      serviceToken,
    );
    if (country == null) {
      return Left(ServerFailure("Invalid Token,Try again!", 410));
    }
    body.addAll({"country": country});
    String url = "${BaseUrl().baseUrl}auth/user/otp/signin";

    try {
      final response = await getIt.get<RemoteDataSourceInit>().postRequest(
        body: body,
        url: url,
      );
      if (Utils.checkIsNull(response["success"]) != true &&
          response["success"] == true) {
        return Right(response["message"]);
      } else {
        return Left(ServerFailure(response["message"], 410));
      }
    } on TooManyRequestException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      print("send otp: ${e.toString()}");
      return Left(ServerFailure(e.toString(), 410));
    }
  }
}
