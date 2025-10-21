import 'package:consultation_sdk/consultation_sdk_auth_init.dart';

abstract class ConsultationSdkAuth {
  static ConsultationSdkAuth instance = ConsultationSdkAuthInit();

  Future<String?> getPlatformVersion();
  Future<String> authenticate({
    required String countryLetterCode,
    required String dialCode,
    required String phoneNumber,
    String? authToken,
    required String serviceToken,
  });
}