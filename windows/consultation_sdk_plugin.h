#ifndef FLUTTER_PLUGIN_CONSULTATION_SDK_PLUGIN_H_
#define FLUTTER_PLUGIN_CONSULTATION_SDK_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace consultation_sdk {

class ConsultationSdkPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  ConsultationSdkPlugin();

  virtual ~ConsultationSdkPlugin();

  // Disallow copy and assign.
  ConsultationSdkPlugin(const ConsultationSdkPlugin&) = delete;
  ConsultationSdkPlugin& operator=(const ConsultationSdkPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace consultation_sdk

#endif  // FLUTTER_PLUGIN_CONSULTATION_SDK_PLUGIN_H_
