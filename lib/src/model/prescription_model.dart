import 'dart:convert';
import 'package:consultation_sdk/src/model/rx_item_model.dart';

class PrescriptionModel {
  final List<String> chiefComplaints;
  final List<String> recommendedTest;
  final List<String> advice;
  final List<RxItemModel> rx;
  final String history;
  final String probableDiagnosis;
  final String followUpWithin;
  final String gender;
  final String fullName;
  final String age;
  final String weight;
  final String referral;

  PrescriptionModel({
    required this.chiefComplaints,
    required this.recommendedTest,
    required this.advice,
    required this.rx,
    required this.history,
    required this.probableDiagnosis,
    required this.followUpWithin,
    required this.fullName,
    required this.gender,
    required this.age,
    required this.weight,
    required this.referral,
  });

  PrescriptionModel copyWith({
    List<String>? chiefComplaints,
    List<String>? recommendedTest,
    List<String>? advice,
    List<RxItemModel>? rx,
    String? history,
    String? probableDiagnosis,
    String? followUpWithin,
    String? fullName,
    String? gender,
    String? age,
    String? weight,
    String? referral,
  }) =>
      PrescriptionModel(
        chiefComplaints: chiefComplaints ?? this.chiefComplaints,
        recommendedTest: recommendedTest ?? this.recommendedTest,
        advice: advice ?? this.advice,
        rx: rx ?? this.rx,
        history: history ?? this.history,
        probableDiagnosis: probableDiagnosis ?? this.probableDiagnosis,
        followUpWithin: followUpWithin ?? this.followUpWithin,
        fullName: fullName ?? this.fullName,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        weight: weight ?? this.weight,
        referral: referral ?? this.referral,
      );

  factory PrescriptionModel.fromRawJson(String str) => PrescriptionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) => PrescriptionModel(
    chiefComplaints: json["chiefComplaints"] == null || json["chiefComplaints"] == "" ? [] : List<String>.from(json["chiefComplaints"].map((x) => x)),
    recommendedTest: json["recommendedTest"] == null || json["recommendedTest"] == "" ? [] : List<String>.from(json["recommendedTest"].map((x) => x)),
    advice: json["advice"] == null || json["advice"] == "" ? [] : List<String>.from(json["advice"].map((x) => x)),
    rx: json["rx"] == null || json["rx"] == "" ? [] : List<RxItemModel>.from(json["rx"].map((x) => RxItemModel.fromJson(x))),
    history: json["history"] ?? "",
    probableDiagnosis: json["probableDiagnosis"] ?? "",
    followUpWithin: json["followUpWithin"] ?? "",
    fullName: json["fullName"] ?? "",
    gender: json["gender"] ?? "",
    age: json["age"] ?? "",
    weight: json["weight"] ?? "",
    referral: json["referral"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    // "chiefComplaints": json.encode(List<dynamic>.from(chiefComplaints.map((x) => x))),
    // "recommendedTest": json.encode(List<dynamic>.from(recommendedTest.map((x) => x))),
    // "advice": json.encode(List<dynamic>.from(advice.map((x) => x))),
    // "rx": json.encode(List<dynamic>.from(rx.map((x) => x.toRawJson()))),
    "chiefComplaints": List<dynamic>.from(chiefComplaints.map((x) => x)),
    "recommendedTest": List<dynamic>.from(recommendedTest.map((x) => x)),
    "advice": List<dynamic>.from(advice.map((x) => x)),
    "rx": List<dynamic>.from(rx.map((x) => x.toJson())),
    "history": history,
    "probableDiagnosis": probableDiagnosis,
    "followUpWithin": followUpWithin,
    "fullName": fullName,
    "gender": gender,
    "age": age,
    "weight": weight,
    "referral": referral,
  };
}