//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <consultation_sdk/consultation_sdk_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) consultation_sdk_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ConsultationSdkPlugin");
  consultation_sdk_plugin_register_with_registrar(consultation_sdk_registrar);
}
