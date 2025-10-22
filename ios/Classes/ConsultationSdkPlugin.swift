import Flutter
import UIKit
import AVFoundation

public class ConsultationSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "consultation_sdk", binaryMessenger: registrar.messenger())
    let instance = ConsultationSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "startOutgoingCallTone":
      self.playOutgoingCallTone()
      result(nil)
    case "stopOutgoingCallTone":
      self.stopOutgoingCallTone()
      result(nil)
    case "setEarpiece":
      if let useEarpiece = call.arguments as? Bool {
        self.setAudioRoute(useEarpiece: useEarpiece)
      }
      result(nil)
    case "startForegroundService":
      if let args = call.arguments as? [String: Any],
      let callType = args["call_type"] as? String {
        if callType == "audio" {
          ProximityHelper.enableProximityMonitoring(true)
        } else {
          ProximityHelper.enableProximityMonitoring(false)
        }
      }
      result(nil)
    case "stopForegroundService":
      ProximityHelper.enableProximityMonitoring(false)
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }


  // for Outgoing tone
  var audioPlayer: AVAudioPlayer?
  func playOutgoingCallTone() {
    let path = "/System/Library/Audio/UISounds/nano/3rdParty_DialerRing.caf"

    let fileManager = FileManager.default
    if !fileManager.fileExists(atPath: path) {
      print("File does not exist at path: \(path)")
      return
    }

    let url = URL(fileURLWithPath: path)

    do {
      audioPlayer = try AVAudioPlayer(contentsOf: url)
      audioPlayer?.numberOfLoops = -1  // Loop indefinitely
      audioPlayer?.play()
    } catch {
      print("Error playing outgoing tone: \(error.localizedDescription)")
    }
  }

  func stopOutgoingCallTone() {
    audioPlayer?.stop()
  }

  func setAudioRoute(useEarpiece: Bool) {
    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(.playAndRecord, mode: .voiceChat, options: [.allowBluetooth, .defaultToSpeaker])
      try session.overrideOutputAudioPort(useEarpiece ? .none : .speaker)
      if session.isOtherAudioPlaying {
        try session.setActive(false)
      }
      try session.setActive(true)
    } catch {
      print("Failed to set audio route: \(error)")
    }
  }

}
