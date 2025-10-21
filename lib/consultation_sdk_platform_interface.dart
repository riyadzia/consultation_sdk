import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'consultation_sdk_method_channel.dart';

abstract class ConsultationSdkPlatform extends PlatformInterface {
  /// Constructs a ConsultationSdkPlatform.
  ConsultationSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static ConsultationSdkPlatform _instance = MethodChannelConsultationSdk();

  /// The default instance of [ConsultationSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelConsultationSdk].
  static ConsultationSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ConsultationSdkPlatform] when
  /// they register themselves.
  static set instance(ConsultationSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
