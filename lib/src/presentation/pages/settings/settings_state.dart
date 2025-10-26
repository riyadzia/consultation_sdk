import 'dart:convert';

class SettingsState {
  final bool isLoading;
  final SettingModel? settingModel;

  SettingsState({
    this.isLoading = false,
    this.settingModel,
  });

  SettingsState copyWith({
    bool? isLoading,
    SettingModel? settingModel,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      settingModel: settingModel ?? this.settingModel,
    );
  }
}

class SettingModel {
  final String sdkBanner;

  SettingModel({
    required this.sdkBanner,
  });

  SettingModel copyWith({
    String? sdkBanner,
  }) =>
      SettingModel(
        sdkBanner: sdkBanner ?? this.sdkBanner,
      );

  factory SettingModel.fromRawJson(String str) => SettingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    sdkBanner: json["sdk_banner"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "sdk_banner": sdkBanner,
  };
}