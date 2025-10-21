
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:consultation_sdk/src/core/contants.dart';

class CallManager {
  // For Outgoing tone
  static Future<void> playOutgoingTone() async {
    try {
      await nativePlatform.invokeMethod('startOutgoingCallTone');
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error playing tone: ${e.message}");
      }
    }
  }
  static Future<void> stopOutgoingTone() async {
    try {
      await nativePlatform.invokeMethod('stopOutgoingCallTone');
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error stopping tone: ${e.message}");
      }
    }
  }

  static Future<void> setEarpiece({bool isEarpiece = true}) async {
    try {
      await nativePlatform.invokeMethod('setEarpiece',isEarpiece);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error stopping tone: ${e.message}");
      }
    }
  }

  static Future<void> startForegroundCallService(String title, String text,String callType) async {
    try {
      await nativePlatform.invokeMethod("startForegroundService", {
        "title": title,
        "text": text,
        "call_type": callType,
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error startForegroundService: ${e.message}");
      }
    }
  }

  static Future<void> stopForegroundCallService() async {
    try {
      await nativePlatform.invokeMethod("stopForegroundService");
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error stopForegroundService: ${e.message}");
      }
    }
  }


}
