import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/model/package_variation_model.dart';

class PackageModel {
  String? id;
  String? type;
  String? bnType;
  int? order;
  String? tac;
  String? bnTac;
  String? packageType;
  List<PackageVariationModel>? packageVariation;
  bool? isInstant;
  String? title;
  String? bnTitle;
  String? image;
  bool? showHome;

  int? selectedIndex = 0;

  PackageModel();

  PackageModel.constructor({
    this.id,
    this.type,
    this.bnType,
    this.order,
    this.tac,
    this.bnTac,
    this.packageType,
    this.packageVariation,
    this.isInstant,
    this.title,
    this.bnTitle,
    this.image,
    this.selectedIndex,
    this.showHome,
  });

  PackageModel copyWith({
    String? id,
    String? type,
    String? bnType,
    int? order,
    String? tac,
    String? bnTac,
    String? packageType,
    List<PackageVariationModel>? packageVariation,
    bool? isInstant,
    String? title,
    String? bnTitle,
    String? image,
    int? selectedIndex,
    bool? showHome,
  }) =>
      PackageModel.constructor(
        id: id ?? this.id,
        type: type ?? this.type,
        bnType: bnType ?? this.bnType,
        order: order ?? this.order,
        tac: tac ?? this.tac,
        bnTac: bnTac ?? this.bnTac,
        packageType: packageType ?? this.packageType,
        packageVariation: packageVariation ?? this.packageVariation,
        isInstant: isInstant ?? this.isInstant,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        title: title ?? this.title,
        image: image ?? this.image,
        bnTitle: bnTitle ?? this.bnTitle,
        showHome: showHome ?? this.showHome,
      );

  factory PackageModel.fromJson(Map<String, dynamic> json) =>
      PackageModel.constructor(
        id: json["_id"] ?? json["id"] ?? "",
        type: json["type"] ?? "",
        bnType: json["bnType"] ?? "",
        order: json["order"] ?? 1,
        tac: json["tac"] ?? "",
        bnTac: json["bnTac"] ?? "",
        packageType: json["packageType"] ?? "",
        isInstant: json["isInstant"] ?? false,
        // selectedIndex: json["isInstant"] == null || json["isInstant"] == true ? 0.obs : 1.obs,
        selectedIndex: getSelectedIndex(json["isInstant"], json["type"]),
        title: json["title"] ?? "",
        bnTitle: json["bnTitle"] ?? "",
        image: json["image"] ?? "",
        packageVariation: Utils.checkIsNull(json["packageVariation"])
            ? []
            : List<PackageVariationModel>.from(json["packageVariation"]
            .map((x) => PackageVariationModel.fromJson(x))),
        showHome: json["showHome"] ?? false,
      );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "type": type,
        "bnType": type,
        "order": order,
        "tac": tac,
        "bnTac": bnTac,
        "packageType": packageType,
        "isInstant": isInstant,
        "packageVariation": packageVariation?.map((e) => e.toJson()).toList(),
        "title": title,
        "bnTitle": bnTitle,
        "image": image,
        "showHome": showHome,
      };

}

int getSelectedIndex(bool? isInstant, String? type) {
  var index = 0;
  if (isInstant == null || isInstant == true) {
    return index;
  } else {
    if (type == "telemedicine") {
      return 1;
    }
  }
  return index;
}
