import 'dart:math';

import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/enums.dart';

extension DeviceSize on BuildContext {
  bool get isTab {
    final width = MediaQuery.of(this).size.width;
    return width > 500;
  }
}

extension DoubleExtensions on double {
  double toScaleFactor() {
    return textScaler().scale(toDouble());
  }

  String toDecimalString() {
    if(toDouble() % 1 != 0){
      String decimalPart = toStringAsFixed(2);
      if(decimalPart.endsWith("0")){
        return decimalPart.substring(0,decimalPart.length - 1);
      }
      return decimalPart;
    } else {
      return toDouble().toStringAsFixed(0);
    }
  }

  double toDecimalPrecision(int fractionDigits) {
    var mod = pow(10, fractionDigits.toDouble()).toDouble();
    return ((this * mod).round().toDouble() / mod);
  }

}

bool isNull(dynamic value) => value == null;
bool? isBlank(dynamic value) {
  return _isEmpty(value);
}
bool? _isEmpty(dynamic value) {
  if (value is String) {
    return value.toString().trim().isEmpty;
  }
  if (value is Iterable || value is Map) {
    return value.isEmpty as bool?;
  }
  return false;
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (toString().isEmpty) return toString();
    return toString()[0].toUpperCase() + toString().substring(1).toLowerCase();
  }

  String? capitalizeFirst() {
    if (isNull(toString())) return null;
    if (isBlank(toString())!) return toString();
    return toString()[0].toUpperCase() + toString().substring(1).toLowerCase();
  }

  bool isValidMobile() {
    final RegExp bangladeshiMobileNumberRegExp = RegExp(r'^(01[3-9]\d{8})$');
    return bangladeshiMobileNumberRegExp.hasMatch(toString());
  }

  String convert24CharIdToUUID() {
    // Append extra characters to make it 32 characters
    String paddedId = toString().padRight(32, '0'); // Add trailing zeros

    return '${paddedId.substring(0, 8)}-'
        '${paddedId.substring(8, 12)}-'
        '${paddedId.substring(12, 16)}-'
        '${paddedId.substring(16, 20)}-'
        '${paddedId.substring(20, 32)}';
  }

  int dayOfWeek() {
    const daysMap = {
      'saturday': 0,
      'sunday': 1,
      'monday': 2,
      'tuesday': 3,
      'wednesday': 4,
      'thursday': 5,
      'friday': 6,
    };

    return daysMap[toString().toLowerCase()] ?? -1;
  }

}

extension UserRoleExtension on UserRole {
  // Convert enum to snake_case
  String toSnakeCase() {
    return name
        .replaceAllMapped(RegExp(r'([a-z])([A-Z0-9])'),
            (match) => '${match.group(1)}_${match.group(2)}')
        .toLowerCase();
  }

  // Convert enum to camelCase
  String toCamelCase() {
    List<String> parts = name.split('_');
    return parts[0] +
        parts.sublist(1).map((word) {
          if (RegExp(r'^\d+$').hasMatch(word)) {
            return word; // Keep numbers as-is
          }
          return word[0].toUpperCase() + word.substring(1);
        }).join();
  }

  // Convert snake_case or camelCase string to enum (handles single-word cases)
  static UserRole fromString(String input) {
    String formatted = input.contains('_')
        ? input.replaceAllMapped(
            RegExp(r'_([a-zA-Z0-9])'), (match) => match.group(1)!.toUpperCase())
        : input;

    return UserRole.values.firstWhere(
        (e) => e.name.toLowerCase() == formatted.toLowerCase(),
        orElse: () => throw Exception('Invalid BongoType value: $input'));
  }

  static String value(UserRole role) {
    switch (role) {
      case UserRole.generalDoctor:
        return "general_doctor";
      case UserRole.inhouseDoctor:
        return "inhouse_doctor";
      case UserRole.patient:
        return "patient";
      case UserRole.b2bPatient:
        return "b2b_patient";
      case UserRole.b2cAgent:
        return "b2c_agent";
      case UserRole.operationNamage:
        return "operation_namage";
      case UserRole.partnerAgent:
        return "partner_agent";
      case UserRole.pharmacyAgent:
        return "pharmacy_agent";
      case UserRole.operationReport:
        return "operation_report";
      case UserRole.pharmacyPartner:
        return "pharmacy_partner";
      case UserRole.clinicPartner:
        return "clinic_partner";
    }
  }
}

// user type
extension UserTypeExtension on UserType {
  String get value => toString().split('.').last;

  static UserType fromString(String type) {
    return UserType.values.firstWhere(
        (e) => e.value.toLowerCase() == type.toLowerCase(),
        orElse: () => throw Exception('Invalid BongoType: $type'));
  }
}
