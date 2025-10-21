import 'dart:convert';

import 'package:flutter/material.dart';

class RxItemModel {
  final TextEditingController name;
  final String medicineType;
  final bool morning;
  final bool afternoon;
  final bool night;
  final TextEditingController doseTime;
  final String afterBefore;
  final TextEditingController duration;
  final TextEditingController comment;

  RxItemModel({
    required this.name,
    required this.medicineType,
    required this.morning,
    required this.afternoon,
    required this.night,
    required this.doseTime,
    required this.afterBefore,
    required this.duration,
    required this.comment,
  });

  RxItemModel copyWith({
    TextEditingController? name,
    String? medicineType,
    bool? morning,
    bool? afternoon,
    bool? night,
    TextEditingController? doseTime,
    String? afterBefore,
    TextEditingController? duration,
    TextEditingController? comment,
  }) =>
      RxItemModel(
        name: name ?? this.name,
        medicineType: medicineType ?? this.medicineType,
        morning: morning ?? this.morning,
        afternoon: afternoon ?? this.afternoon,
        night: night ?? this.night,
        doseTime: doseTime ?? this.doseTime,
        afterBefore: afterBefore ?? this.afterBefore,
        duration: duration ?? this.duration,
        comment: comment ?? this.comment,
      );

  factory RxItemModel.fromRawJson(String str) => RxItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RxItemModel.fromJson(Map<String, dynamic> json) => RxItemModel(
    name: TextEditingController(text: json["rx"]),
    medicineType: "${json["doseForm"] ?? ""}",
    morning: json["morning"] ?? false,
    afternoon: json["afternoon"] ?? false,
    night: json["night"] ?? false,
    doseTime: TextEditingController(text: json["doseTime"]),
    afterBefore: "${json["doseWithMeal"] ?? ""}",
    duration: TextEditingController(text: json["containueUntil"]),
    comment: TextEditingController(text: json["note"]),
  );

  Map<String, dynamic> toJson() => {
    "rx": name.text,
    "doseForm": medicineType,
    // "morning": morning,
    // "afternoon": afternoon,
    // "night": night,
    "doseTime": doseTime.text,
    "doseWithMeal": afterBefore,
    "containueUntil": duration.text.trim(),
    "note": comment.text,
  };
}
