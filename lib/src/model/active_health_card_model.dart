import 'dart:convert';
import 'package:consultation_sdk/src/model/package_model.dart';

class ActiveHealthCardModel {
  final String id;
  final PackageModel packageModel;
  final String packageTitle;
  final int healthCardId;
  final dynamic userId;
  final String invoiceNumber;
  final String packageActivateDate;
  final String packageExpiredDate;
  final bool isActive;
  final String paymentStatus;
  final String createdAt;
  final String updatedAt;

  ActiveHealthCardModel({
    required this.id,
    required this.packageModel,
    required this.packageTitle,
    required this.healthCardId,
    required this.userId,
    required this.invoiceNumber,
    required this.packageActivateDate,
    required this.packageExpiredDate,
    required this.isActive,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  ActiveHealthCardModel copyWith({
    String? id,
    PackageModel? packageModel,
    String? packageTitle,
    int? healthCardId,
    dynamic userId,
    String? invoiceNumber,
    String? packageActivateDate,
    String? packageExpiredDate,
    bool? isActive,
    String? paymentStatus,
    String? createdAt,
    String? updatedAt,
  }) =>
      ActiveHealthCardModel(
        id: id ?? this.id,
        packageModel: packageModel ?? this.packageModel,
        packageTitle: packageTitle ?? this.packageTitle,
        healthCardId: healthCardId ?? this.healthCardId,
        userId: userId ?? this.userId,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        packageActivateDate: packageActivateDate ?? this.packageActivateDate,
        packageExpiredDate: packageExpiredDate ?? this.packageExpiredDate,
        isActive: isActive ?? this.isActive,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ActiveHealthCardModel.fromRawJson(String str) => ActiveHealthCardModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActiveHealthCardModel.fromJson(Map<String, dynamic> json) => ActiveHealthCardModel(
    id: json["_id"] ?? "",
    packageModel: PackageModel.fromJson(json["packageId"]),
    packageTitle: json["packageTitle"] ?? "",
    healthCardId: json["healthCardId"] ?? 0,
    userId: json["userId"] ?? "",
    invoiceNumber: json["invoiceNumber"] ?? "",
    packageActivateDate: json["packageActivateDate"] ?? "",
    packageExpiredDate: json["packageExpiredDate"] ?? "",
    isActive: json["isActive"] ?? false,
    paymentStatus: json["paymentStatus"] ?? "",
    createdAt: json["createdAt"] ?? "",
    updatedAt: json["updatedAt"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "packageId": packageModel.toJson(),
    "packageTitle": packageTitle,
    "healthCardId": healthCardId,
    "userId": userId,
    "invoiceNumber": invoiceNumber,
    "packageActivateDate": packageActivateDate,
    "packageExpiredDate": packageExpiredDate,
    "isActive": isActive,
    "paymentStatus": paymentStatus,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}