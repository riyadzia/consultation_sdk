import 'dart:convert';

class InHouseDoctorModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final String degree;
  final String bmdcNumber;
  final String imagePath;
  final String personalDetails;
  final String fcmToken;
  final bool isActive;
  final bool isDeleted;
  final bool isAvailable;
  final int callCount;
  String get fullName => "$firstName $lastName".trim();

  InHouseDoctorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.degree,
    required this.bmdcNumber,
    required this.imagePath,
    required this.personalDetails,
    required this.fcmToken,
    required this.isActive,
    required this.isDeleted,
    required this.isAvailable,
    required this.callCount,
  });

  InHouseDoctorModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    String? degree,
    String? bmdcNumber,
    String? imagePath,
    String? personalDetails,
    String? fcmToken,
    bool? isActive,
    bool? isDeleted,
    bool? isAvailable,
    int? callCount,
  }) =>
      InHouseDoctorModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        role: role ?? this.role,
        degree: degree ?? this.degree,
        bmdcNumber: bmdcNumber ?? this.bmdcNumber,
        imagePath: imagePath ?? this.imagePath,
        personalDetails: personalDetails ?? this.personalDetails,
        fcmToken: fcmToken ?? this.fcmToken,
        isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
        isAvailable: isAvailable ?? this.isAvailable,
        callCount: callCount ?? this.callCount,
      );

  factory InHouseDoctorModel.fromRawJson(String str) => InHouseDoctorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InHouseDoctorModel.fromJson(Map<String, dynamic> json) => InHouseDoctorModel(
    id: json["_id"] ?? "",
    firstName: json["firstName"] ?? "",
    lastName: json["lastName"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    role: json["role"] ?? "",
    degree: json["degree"] ?? "",
    bmdcNumber: json["bmdc"] ?? "",
    imagePath: json["image"] ?? "",
    personalDetails: json["personalDetails"] ?? "",
    fcmToken: json["fcmToken"] == null
        || json["fcmToken"] == ""
        || json["fcmToken"] == "token" ? ""
        : json["fcmToken"],
    isActive: json["isActive"] ?? true,
    isDeleted: json["isDeleted"] ?? false,
    isAvailable: json["isAvailable"] ?? false,
    callCount: json["callCount"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "degree": degree,
    "bmdc": bmdcNumber,
    "role": role,
    "image": imagePath,
    "personalDetails": personalDetails,
    "fcmToken": fcmToken,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "isAvailable": isAvailable,
    "callCount": callCount,
  };
}