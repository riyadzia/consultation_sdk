import 'package:dartz/dartz.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/error/failure.dart';
import 'package:consultation_sdk/src/domain/repository/api_repository.dart';

String overrideBackofficePostUrl =
    "${BaseUrl().baseUrl}admin/ebl/payment/callback";
String overrideCustomCancelPage = "${BaseUrl().webSiteUrl}api/cancel-mobile";
// String overrideCustomReceiptPage = "${BaseUrl().webSiteUrl}api/ebl-receipt";
String overrideCustomReceiptPage = "${BaseUrl().webSiteUrl}api/ebl-receipt-mobile";

class EBLService {
  Map<String, String> getSignedData({
    required String trnId,
    required String amount,
    required String firstName,
    String lastName = "",
    required String phoneNumber,
    required String referenceNumber,
    required String dateTime,
    required String jamal,
    required String hasina,
    String email = "",
    String district = "Dhaka",
    String thana = "",
    String postalCode = "0000",
    String countryCode = "BD",
    String address = "",
    // for gitf user
    String userName = "",
    bool isGift = false,
  }) {
    return <String, String>{
      "access_key": jamal,
      "profile_id": hasina,
      "transaction_uuid": trnId,
      "consumer_id": "MONSUR_HOQ",
      "signed_field_names":
          "access_key,profile_id,transaction_uuid,consumer_id,signed_field_names,unsigned_field_names,signed_date_time,locale,transaction_type,reference_number,auth_trans_ref_no,amount,currency,bill_to_forename,bill_to_surname,bill_to_email,bill_to_phone,bill_to_address_line1,bill_to_address_city,bill_to_address_country,bill_to_postal_code,override_backoffice_post_url,override_custom_cancel_page,override_custom_receipt_page",
      "unsigned_field_names": "",
      "signed_date_time": dateTime,
      "locale": "en",
      "transaction_type": "sale",
      "reference_number": isGift ? 'gift,$phoneNumber,$userName' : referenceNumber,
      "auth_trans_ref_no": referenceNumber,
      "amount": "$amount",
      "currency": "BDT",
      "bill_to_forename": firstName,
      "bill_to_surname": lastName,
      "bill_to_email": email,
      "bill_to_phone": phoneNumber,
      "bill_to_address_line1": address.isEmpty ? "Gulshan" : address,
      "bill_to_address_city": district.isEmpty ? "Dhaka" : district,
      "bill_to_address_country": countryCode.isEmpty ? "BD" : countryCode,
      "bill_to_postal_code": postalCode.isEmpty ? "0000" : postalCode,
      "override_backoffice_post_url": overrideBackofficePostUrl,
      "override_custom_cancel_page": overrideCustomCancelPage,
      "override_custom_receipt_page": overrideCustomReceiptPage,
    };
  }

  Map<String, String> getPaymentData({
    required String trnId,
    required String amount,
    required String firstName,
    String lastName = "",
    required String phoneNumber,
    required String referenceNumber,
    required String dateTime,
    required String jamal,
    required String hasina,
    required String signature,
    String email = "",
    String district = "Dhaka",
    String thana = "",
    String postalCode = "0000",
    String countryCode = "BD",
    String address = "",
    String userName = "",
    bool isGift = false,
  }) {
    return <String, String>{
      "access_key": jamal,
      "profile_id": hasina,
      "reference_number": isGift ? 'gift,$phoneNumber,$userName' : referenceNumber,
      "auth_trans_ref_no": referenceNumber,
      "transaction_uuid": trnId,
      "consumer_id": "MONSUR_HOQ",
      "signed_field_names":
          "access_key,profile_id,transaction_uuid,consumer_id,signed_field_names,unsigned_field_names,signed_date_time,locale,transaction_type,reference_number,auth_trans_ref_no,amount,currency,bill_to_forename,bill_to_surname,bill_to_email,bill_to_phone,bill_to_address_line1,bill_to_address_city,bill_to_address_country,bill_to_postal_code,override_backoffice_post_url,override_custom_cancel_page,override_custom_receipt_page",
      "transaction_type": "sale",
      "currency": "BDT",
      "unsigned_field_names": "",
      "signed_date_time": dateTime,
      "locale": "en",
      "amount": "$amount",
      "bill_to_forename": firstName,
      "bill_to_surname": lastName,
      "bill_to_email": email,
      "bill_to_phone": phoneNumber,
      "bill_to_address_line1": address.isEmpty ? "Gulshan" : address,
      "bill_to_address_city": district.isEmpty ? "Dhaka" : district,
      "bill_to_address_country": countryCode.isEmpty ? "BD" : countryCode,
      "bill_to_postal_code": postalCode.isEmpty ? "0000" : postalCode,
      "signature": signature,
      "override_backoffice_post_url": overrideBackofficePostUrl,
      "override_custom_cancel_page": overrideCustomCancelPage,
      "override_custom_receipt_page": overrideCustomReceiptPage,
    };
  }

  Future<Either<Failure, String>> getSignature(
      Map<String, String> formData,ApiRepositoryInit repository) async {
    return await repository.getEBLSignature(formData);
  }
}
