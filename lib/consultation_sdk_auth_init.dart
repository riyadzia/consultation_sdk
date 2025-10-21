import 'dart:async';

import 'package:consultation_sdk/consultation_sdk.dart';
import 'package:consultation_sdk/consultation_sdk_auth.dart';
import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/screen/main_screen.dart';
import 'package:flutter/material.dart';

class ConsultationSdkAuthInit extends ConsultationSdkAuth {

  @override
  Future<String> authenticate({
    required String countryLetterCode,
    required String dialCode,
    required String phoneNumber,
    String? authToken,
    required String serviceToken,
  }) async {
    final completer = Completer<String>();
    if(authToken == null || authToken == ""){
      Utils.loadingDialog(ConsultationSdk().navigatorKey!.currentState!.context);
      try {
        final response = await MyApi().sendOtp(
          countryLetterCode: countryLetterCode,
          dialCode: dialCode,
          phoneNumber: phoneNumber,
          serviceToken: serviceToken,
        );
        Utils.closeDialog(ConsultationSdk().navigatorKey!.currentState!.context);
        response.fold((error){
          Utils.showMiddleToast(error.message);
          completer.completeError(error.message);
          return completer.future;
        }, (data){
          ConsultationSdk().navigatorKey?.currentState?.push(
            MaterialPageRoute(
              builder: (_) => MainScreen(
                countryLetterCode: countryLetterCode,
                dialCode: dialCode,
                phoneNumber: phoneNumber,
                setServiceToken: serviceToken,
                onOtpVerified: (token) {
                  completer.complete(token);
                },
                onError: (err) {
                  completer.completeError(err);
                },
              ),
            ),
          );
        });
      } catch (e) {
        completer.completeError(e.toString());
      } finally {

      }
    } else {
      ConsultationSdk().navigatorKey?.currentState?.push(
        MaterialPageRoute(
          builder: (_) => MainScreen(
            countryLetterCode: countryLetterCode,
            dialCode: dialCode,
            phoneNumber: phoneNumber,
            authToken: authToken,
            setServiceToken: serviceToken,
            onOtpVerified: (token) {
              completer.complete(token);
            },
            onError: (err) {
              completer.completeError(err);
            },
          ),
        ),
      );
    }
    return completer.future;
  }

  @override
  Future<String?> getPlatformVersion() {
    // TODO: implement getPlatformVersion
    throw UnimplementedError();
  }
}
