import 'dart:convert';

import 'package:consultation_sdk/src/core/enums.dart';
import 'package:consultation_sdk/src/core/extensions.dart';

class UserProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String dob;
  final String email;
  final String emailVerifiedAt;
  final String number;
  final String organization;
  final String dialCode;
  final String countryCode;
  final UserRole role1;
  final UserType type;
  final String nid;
  final String bloodGroup;
  final String address;
  final String image;
  final int activeStatus;
  final bool isDeleted;
  final bool hasFreeCall;
  final String picture;
  final String referCode;
  final String referralCode;
  final String bio;
  final String usedReferCode;
  final String referBalance;
  final String totalUsedMyCode;
  final String gender;
  final String provider;
  final String s75;
  final String fcmToken;
  final String accessToken;
  String get fullName => "$firstName $lastName".trim();

  UserProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
    required this.emailVerifiedAt,
    required this.number,
    required this.organization,
    required this.dialCode,
    required this.countryCode,
    required this.role1,
    required this.type,
    required this.nid,
    required this.image,
    required this.address,
    required this.bloodGroup,
    required this.activeStatus,
    required this.isDeleted,
    required this.hasFreeCall,
    required this.picture,
    required this.referCode,
    required this.referralCode,
    required this.bio,
    required this.usedReferCode,
    required this.referBalance,
    required this.totalUsedMyCode,
    required this.gender,
    required this.s75,
    required this.fcmToken,
    required this.provider,
    required this.accessToken,
  });

  UserProfileModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? dob,
    String? email,
    String? emailVerifiedAt,
    String? number,
    String? organization,
    String? dialCode,
    String? countryCode,
    String? role,
    UserRole? role1,
    UserType? type,
    String? nid,
    String? bloodGroup,
    String? address,
    String? image,
    int? activeStatus,
    bool? isDeleted,
    bool? hasFreeCall,
    String? picture,
    String? referCode,
    String? referralCode,
    String? bio,
    String? usedReferCode,
    String? referBalance,
    String? totalUsedMyCode,
    String? gender,
    String? s75,
    String? fcmToken,
    String? provider,
    String? accessToken,
  }) =>
      UserProfileModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        dob: dob ?? this.dob,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        number: number ?? this.number,
        organization: organization ?? this.organization,
        dialCode: dialCode ?? this.dialCode,
        countryCode: countryCode ?? this.countryCode,
        role1: role1 ?? this.role1,
        type: type ?? this.type,
        nid: nid ?? this.nid,
        image: image ?? this.image,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        address: address ?? this.address,
        activeStatus: activeStatus ?? this.activeStatus,
        isDeleted: isDeleted ?? this.isDeleted,
        hasFreeCall: hasFreeCall ?? this.hasFreeCall,
        picture: picture ?? this.picture,
        referCode: referCode ?? this.referCode,
        referralCode: referralCode ?? this.referralCode,
        bio: bio ?? this.bio,
        usedReferCode: usedReferCode ?? this.usedReferCode,
        referBalance: referBalance ?? this.referBalance,
        totalUsedMyCode: totalUsedMyCode ?? this.totalUsedMyCode,
        gender: gender ?? this.gender,
        s75: s75 ?? this.s75,
        fcmToken: fcmToken ?? this.fcmToken,
        provider: provider ?? this.provider,
        accessToken: accessToken ?? this.accessToken,
      );

  factory UserProfileModel.fromRawJson(String str) =>
      UserProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["_id"] ?? "",
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        dob: json["dob"] ?? '',
        email: json["email"] ?? '',
        emailVerifiedAt: json["email_verified_at"] ?? '',
        number: json["phone"] ?? '',
        organization: json["organization"] ?? '',
        dialCode: json["dialCode"] ?? '880',
        countryCode: json["countryCode"] ?? 'BD',
        role1: UserRoleExtension.fromString(json["role"] ?? 'patient'),
        type: UserTypeExtension.fromString(json["type"] ?? 'user'),
        nid: json["nid"] == null ? "" : "${json["nid"]}",
        image: json["image"] ?? '',
        bloodGroup: json["bloodGroup"] ?? '',
        address: json["address"] ?? '',
        activeStatus: json["active_status"] ?? 0,
        isDeleted: json["isDeleted"] ?? true,
        hasFreeCall: json["hasFreeCall"] ?? true,
        picture: json["picture"] ?? "",
        referCode: json['my_reffer_code'] ?? "",
        referralCode: json['referralCode'] ?? "",
        bio: json['bio'] ?? "",
        usedReferCode: json['used_reffer_code'] ?? "",
        referBalance: json['referrel_balance'] == null
            ? "0.0"
            : json['referrel_balance'].toString(),
        totalUsedMyCode: json['total_used_reffer_code'] == null
            ? "0"
            : json['total_used_reffer_code'].toString(),
        gender: json["gender"] ?? "",
        s75: json["s75"] ?? "",
        fcmToken: json["fcmToken"] ?? "",
        provider: json["provider"] ?? "",
        accessToken: json["accessToken"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone": number,
        "organization": organization,
        "dialCode": dialCode,
        "role": UserRoleExtension.value(role1),
        "type": type.value,
        "bloodGroup": bloodGroup,
        "nid": nid,
        "address": address,
        "image": image,
        "countryCode": countryCode,
        "active_status": activeStatus,
        "isDeleted": isDeleted,
        "hasFreeCall": hasFreeCall,
        "picture": picture,
        "my_reffer_code": referCode,
        "bio": bio,
        "used_reffer_code": usedReferCode,
        "referralCode": referralCode,
        "referrel_balance": referBalance,
        "total_used_reffer_code": totalUsedMyCode,
        "gender": gender,
        "s75": s75,
        "fcmToken": fcmToken,
        "provider": provider,
        "accessToken": accessToken,
      };
}
