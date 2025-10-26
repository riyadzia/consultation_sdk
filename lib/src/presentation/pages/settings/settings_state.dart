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
  final int cardDiscount;
  final int bkashDiscount;

  SettingModel({
    required this.sdkBanner,
    required this.cardDiscount,
    required this.bkashDiscount,
  });

  SettingModel copyWith({
    String? sdkBanner,
    int? cardDiscount,
    int? bkashDiscount,
  }) =>
      SettingModel(
        sdkBanner: sdkBanner ?? this.sdkBanner,
        cardDiscount: cardDiscount ?? this.cardDiscount,
        bkashDiscount: bkashDiscount ?? this.bkashDiscount,
      );

  factory SettingModel.fromRawJson(String str) => SettingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    sdkBanner: json["sdk_banner"] ?? "",
    cardDiscount: json["card_discount"] ?? 0,
    bkashDiscount: json["bkash_discount"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "sdk_banner": sdkBanner,
    "card_discount": cardDiscount,
    "bkash_discount": bkashDiscount,
  };
}