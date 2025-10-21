import 'package:flutter_test/flutter_test.dart';
import 'package:consultation_sdk/consultation_sdk.dart';
import 'package:consultation_sdk/consultation_sdk_platform_interface.dart';
import 'package:consultation_sdk/consultation_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockConsultationSdkPlatform
    with MockPlatformInterfaceMixin
    implements ConsultationSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ConsultationSdkPlatform initialPlatform = ConsultationSdkPlatform.instance;

  test('$MethodChannelConsultationSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelConsultationSdk>());
  });

  test('getPlatformVersion', () async {
    ConsultationSdk consultationSdkPlugin = ConsultationSdk();
    MockConsultationSdkPlatform fakePlatform = MockConsultationSdkPlatform();
    ConsultationSdkPlatform.instance = fakePlatform;

    expect(await consultationSdkPlugin.getPlatformVersion(), '42');
  });
}
