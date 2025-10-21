import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/model/package_variation_model.dart';

class ActivePackageModel {
  String? id;
  String? type;
  String? bnType;
  int? order;
  String? tac;
  String? bnTac;
  String? packageType;
  PackageVariationModel? packageVariation;
  bool? isInstant;

  ActivePackageModel();

  ActivePackageModel.constructor({
    this.id,
    this.type,
    this.bnType,
    this.order,
    this.tac,
    this.bnTac,
    this.packageType,
    this.packageVariation,
    this.isInstant,
  });

  ActivePackageModel copyWith({
    String? id,
    String? type,
    String? bnType,
    int? order,
    String? tac,
    String? bnTac,
    String? packageType,
    PackageVariationModel? packageVariation,
    bool? isInstant,
  }) =>
      ActivePackageModel.constructor(
        id: id ?? this.id,
        type: type ?? this.type,
        bnType: bnType ?? this.bnType,
        order: order ?? this.order,
        tac: tac ?? this.tac,
        bnTac: bnTac ?? this.bnTac,
        packageType: packageType ?? this.packageType,
        packageVariation: packageVariation ?? this.packageVariation,
        isInstant: isInstant ?? this.isInstant,
      );

  factory ActivePackageModel.fromJson(Map<String, dynamic> json) =>
      ActivePackageModel.constructor(
        id: json["_id"] ?? json["id"] ?? "",
        type: json["type"] ?? "",
        bnType: json["bnType"] ?? "",
        order: json["order"] ?? 1,
        tac: json["tac"] ?? "",
        bnTac: json["bnTac"] ?? "",
        packageType: json["packageType"] ?? "",
        isInstant: json["isInstant"] ?? false,
        packageVariation: Utils.checkIsNull(json["packageVariation"]) ? null : PackageVariationModel.fromJson(json["packageVariation"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "bnType": type,
    "order": order,
    "tac": tac,
    "bnTac": bnTac,
    "packageType": packageType,
    "isInstant": isInstant,
    "packageVariation": packageVariation?.toJson(),
  };
}
