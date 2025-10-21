import 'dart:convert';

import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/model/inhouse_doctor_model.dart';
import 'package:consultation_sdk/src/model/prescription_model.dart';
import 'package:consultation_sdk/src/model/user_profile_model.dart';

class AppointmentModel {
  final String id;
  final String date;
  final String time;
  final String fullName;
  final String gender;
  final String email;
  final String countryCode;
  final String dialCode;
  final String phone;
  final String paymentFee;
  final String age;
  final String weight;
  final String prescription;
  final String doctorId;
  final PrescriptionModel? prescriptionModel;
  final InHouseDoctorModel? doctorModel;
  final UserProfileModel? userProfileModel;
  final String userId;
  final String status;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  AppointmentModel({
    required this.id,
    required this.date,
    required this.time,
    required this.fullName,
    required this.gender,
    required this.email,
    required this.countryCode,
    required this.dialCode,
    required this.phone,
    required this.paymentFee,
    required this.prescription,
    required this.prescriptionModel,
    required this.doctorId,
    required this.doctorModel,
    required this.userProfileModel,
    required this.age,
    required this.weight,
    required this.userId,
    required this.status,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  AppointmentModel copyWith({
    String? id,
    String? date,
    String? time,
    String? fullName,
    String? gender,
    String? email,
    String? countryCode,
    String? dialCode,
    String? phone,
    String? paymentFee,
    String? age,
    String? weight,
    String? prescription,
    String? doctorId,
    PrescriptionModel? prescriptionModel,
    InHouseDoctorModel? doctorModel,
    UserProfileModel? userProfileModel,
    String? userId,
    String? status,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) =>
      AppointmentModel(
        id: id ?? this.id,
        date: date ?? this.date,
        time: time ?? this.time,
        fullName: fullName ?? this.fullName,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        countryCode: countryCode ?? this.countryCode,
        dialCode: dialCode ?? this.dialCode,
        phone: phone ?? this.phone,
        paymentFee: paymentFee ?? this.paymentFee,
        age: age ?? this.age,
        weight: weight ?? this.weight,
        prescription: prescription ?? this.prescription,
        prescriptionModel: prescriptionModel ?? this.prescriptionModel,
        doctorId: doctorId ?? this.doctorId,
        doctorModel: doctorModel ?? this.doctorModel,
        userProfileModel: userProfileModel ?? this.userProfileModel,
        userId: userId ?? this.userId,
        isActive: isActive ?? this.isActive,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AppointmentModel.fromRawJson(String str) => AppointmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => AppointmentModel(
    id: json["_id"] ?? "",
    // date: json["date"] == null || json["date"] == "" || json["date"] == "Invalid date" ? ymdDateFormat.format(DateTime.now().subtract(const Duration(days: 30))) : json["data"],
    date: json["date"] ?? "",
    time: json["time"] ?? "",
    fullName: json["fullName"] ?? "",
    gender: json["gender"] == null || json["gender"] == "" || json["gender"] == "null" ? "male" : json["gender"] ?? "male",
    email: json["email"] ?? "",
    countryCode: json["countryCode"] ?? "BD",
    dialCode: json["dialCode"] ?? "880",
    phone: json["phone"] ?? "",
    paymentFee: json["paymentFee"] == null || json["paymentFee"] == "" ? "" : "${json["paymentFee"]}",
    age: json["age"] == null || json["age"] == "" ? "" : json["age"].toString(),
    weight: json["weight"] == null || json["weight"] == "" ? "" : json["weight"].toString(),
    prescription: json["prescription"] ?? "",
    doctorId: json["doctorId"] ?? "",
    prescriptionModel: json["prescription_data"] == null || json["prescription_data"] == "" || json["prescription_data"] == "null" ? null : PrescriptionModel.fromJson(json["prescription_data"]),
    doctorModel: json["doctor"] == null || json["doctor"] == "" ? null : InHouseDoctorModel.fromJson(json["doctor"]),
    userProfileModel: Utils.checkIsNull(json["user"]) ? null : UserProfileModel.fromJson(json["user"]),
    userId: json["userId"] ?? "",
    status: json["status"] ?? "",
    isActive: json["isActive"] ?? true,
    createdAt: json["createdAt"] ?? "",
    updatedAt: json["updatedAt"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "date": date,
    "time": time,
    "fullName": fullName,
    "gender": gender,
    "email": email,
    "countryCode": countryCode,
    "dialCode": dialCode,
    "phone": phone,
    "age": age,
    "weight": weight,
    "prescription": prescription,
    "doctorId": doctorId,
    "userId": userId,
    "status": status,
    "isActive": isActive,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
