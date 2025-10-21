#include "include/consultation_sdk/consultation_sdk_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "consultation_sdk_plugin.h"

void ConsultationSdkPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  consultation_sdk::ConsultationSdkPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
