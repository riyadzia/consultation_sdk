import 'package:consultation_sdk/consultation_sdk_auth.dart';
import 'package:consultation_sdk/src/di/data_source_module.dart';
import 'package:flutter/material.dart';

import 'consultation_sdk_platform_interface.dart';

class ConsultationSdk {
  static final ConsultationSdk _instance = ConsultationSdk._internal();
  factory ConsultationSdk() => _instance;
  ConsultationSdk._internal();

  GlobalKey<NavigatorState>? _navigatorKey;
  String? _serviceKey;

  /// Initialize SDK with key from host app
  void initialize({
    required GlobalKey<NavigatorState> navigatorKey,
    required String serviceKey,
  }) {
    _serviceKey = serviceKey;
    _navigatorKey = navigatorKey;
    initDataSourceModule();
  }

  /// Closes the SDK and returns to host app
  void close() {
    try {
      if (navigatorKey.currentState?.canPop() ?? false) {
        navigatorKey.currentState?.pop();
      } else {
        // If can't pop, forcefully exit SDK screens
        Navigator.of(navigatorKey.currentContext!).pop();
      }
      debugPrint("✅ Consultation SDK closed successfully");
    } catch (e) {
      debugPrint("❌ Error while closing SDK: $e");
    }
  }

  Future<bool> onBackPressed() async {
    try {
      if (navigatorKey.currentState?.canPop() ?? false) {
        navigatorKey.currentState?.pop();
        return false;
      } else {
        Navigator.of(navigatorKey.currentContext!).pop();
        return false;
      }
    } catch (e) {
      debugPrint("❌ Error while closing SDK: $e");
      return true;
    }
  }

  String? get serviceKey => _serviceKey;
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey!;

  Future<String?> getPlatformVersion() {
    return ConsultationSdkPlatform.instance.getPlatformVersion();
  }

  /// Authenticate method in platform interface style
  Future<String> authenticate({
    required String countryLetterCode,
    required String dialCode,
    required String phoneNumber,
    String? authToken,
  }) {
    return ConsultationSdkAuth.instance.authenticate(
      countryLetterCode: countryLetterCode,
      dialCode: dialCode,
      phoneNumber: phoneNumber,
      authToken: authToken,
      serviceToken: serviceKey!,
    );
  }
}
