import 'package:consultation_sdk/src/core/utils.dart';

class PackageVariationModel {
  String? id;
  String? title;
  String? bnTitle;
  int? sellingPrice;
  int? premiumPerMonth;
  String? description;
  String? condition;
  String? duration;
  String? bnDuration;
  int? saveAmount;
  int? hospitalCashback;
  int? perClaimBenefit;
  int? perDayBenefit;
  int? isolationCoverage;
  int? opd;
  int? member;
  int? discountPrice;
  int? discountPercent;

  PackageVariationModel();

  PackageVariationModel.constructor({
    this.id,
    this.title,
    this.bnTitle,
    this.sellingPrice,
    this.premiumPerMonth,
    this.description,
    this.condition,
    this.duration,
    this.bnDuration,
    this.saveAmount,
    this.hospitalCashback,
    this.isolationCoverage,
    this.perClaimBenefit,
    this.perDayBenefit,
    this.opd,
    this.member,
    this.discountPrice,
    this.discountPercent,
  });

  PackageVariationModel copyWith({
    String? id,
    String? title,
    String? bnTitle,
    int? sellingPrice,
    int? premiumPerMonth,
    String? description,
    String? condition,
    String? duration,
    String? bnDuration,
    int? saveAmount,
    int? hospitalCashback,
    int? isolationCoverage,
    int? perClaimBenefit,
    int? perDayBenefit,
    int? opd,
    int? member,
    int? discountPrice,
    int? discountPercent,
  }) =>
      PackageVariationModel.constructor(
        id: id ?? this.id,
        title: title ?? this.title,
        bnTitle: bnTitle ?? this.bnTitle,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        premiumPerMonth: premiumPerMonth ?? this.premiumPerMonth,
        description: description ?? this.description,
        condition: condition ?? this.condition,
        duration: duration ?? this.duration,
        bnDuration: bnDuration ?? this.bnDuration,
        saveAmount: saveAmount ?? this.saveAmount,
        hospitalCashback: hospitalCashback ?? this.hospitalCashback,
        isolationCoverage: isolationCoverage ?? this.isolationCoverage,
        perClaimBenefit: perClaimBenefit ?? this.perClaimBenefit,
        perDayBenefit: perDayBenefit ?? this.perDayBenefit,
        opd: opd ?? this.opd,
        member: member ?? this.member,
        discountPrice: discountPrice ?? this.discountPrice,
        discountPercent: discountPercent ?? this.discountPercent,
      );

  factory PackageVariationModel.fromJson(Map<String, dynamic> json) =>
      PackageVariationModel.constructor(
        id: json["_id"] ?? json["id"] ?? "",
        title: json["title"] ?? "",
        bnTitle: json["bnTitle"] ?? "",
        sellingPrice: Utils.toInt(json["sellingPrice"]),
        premiumPerMonth: Utils.toInt(json["premiumPerMonth"]),
        description: json["description"] ?? "",
        condition: json["condition"] ?? "",
        duration: json["duration"] ?? "",
        bnDuration: json["bnDuration"] ?? "",
        saveAmount: json["saveAmount"] ?? 0,
        hospitalCashback: Utils.toInt(json["hospitalCashback"]),
        isolationCoverage: Utils.toInt(json["isolationCoverage"]),
        perClaimBenefit: Utils.toInt(json["perClaimBenefit"]),
        perDayBenefit: Utils.toInt(json["perDayBenefit"]),
        opd: Utils.toInt(json["opd"]),
        member: Utils.toInt(json["member"]),
        discountPrice: Utils.toInt(json["discountPrice"]),
        discountPercent: Utils.toInt(json["discountPercent"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "bnTitle": bnTitle,
    "sellingPrice": sellingPrice,
    "premiumPerMonth": premiumPerMonth,
    "description": description,
    "condition": condition,
    "duration": duration,
    "bnDuration": bnDuration,
    "saveAmount": saveAmount,
    "hospitalCashback": hospitalCashback,
    "isolationCoverage": isolationCoverage,
    "perClaimBenefit": perClaimBenefit,
    "perDayBenefit": perDayBenefit,
    "opd": opd,
    "member": member,
    "discountPrice": discountPrice,
    "discountPercent": discountPercent,
  };
}
