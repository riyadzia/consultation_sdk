import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:consultation_sdk/src/presentation/pages/settings/settings_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/helper.dart';
import 'package:consultation_sdk/src/core/services/ebl_service.dart';
import 'package:consultation_sdk/src/core/utils.dart';
import 'package:consultation_sdk/src/domain/repository/api_repository.dart';
import 'package:consultation_sdk/src/model/payment_type_model.dart';
import 'package:consultation_sdk/src/presentation/pages/app_webview/app_webview.dart';
import 'package:consultation_sdk/src/presentation/pages/app_webview/ebl_webview_screen.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/payment/payment_state.dart';
import 'package:consultation_sdk/consultation_sdk.dart';
import 'package:uuid/uuid.dart';

class PaymentCubit extends Cubit<PaymentState> {
  static final PaymentState _initialState = PaymentState(dataMap: {});
  final ApiRepositoryInit _repository;
  final AuthCubit _authCubit;
  final SettingsCubit _settingsCubit;
  PaymentCubit(this._repository, this._authCubit,this._settingsCubit) : super(_initialState);

  Map<String,dynamic> fuckMap = {};

  String get userId => "${_authCubit.state.userProfileModel?.id}";

  void paymentOpen(Map<String, dynamic> dataMap) {
    emit(
      state.copyWith(
        dataMap: dataMap,
        discountPercentage: dataMap["discountPercent"],
        discountedPrice: dataMap["discountedPrice"],
        amount: dataMap["amount"],
        startPayment: DateTime.now().millisecond,
        paymentType: null,
        paymentSuccess: null,
      ),
    );
  }

  void changePaymentType(BankTypeModel paymentType) {
    if(paymentType.bankName == "bkash"){
      int discount = _settingsCubit.state.settingModel!.bkashDiscount;
      emit(state.copyWith(paymentType: paymentType,discountPercentage: discount));
    } else {
      int discount = _settingsCubit.state.settingModel!.cardDiscount;
      emit(state.copyWith(paymentType: paymentType,discountPercentage: discount,));
    }
  }

  void paymentSuccessStatus(bool status){
    emit(state.copyWith(paymentSuccess: status));
  }

  int bkashCallCount = 0;
  Future<void> getBkashPayment(
    BuildContext context, {
    bool canLoading = true,
  }) async {
    if (canLoading) {
      Utils.loadingDialog(context);
    }

    String callBackUrl =
        "${BaseUrl().webSiteUrl}mobilereceipt?invoiceNumber=${state.dataMap["invoiceNumber"]}";
    // if (dataMap["gift"] != null) {
    //   callBackUrl =
    //   "${BaseUrl().webSiteUrl}mobilereceipt?gift=true&invoiceNumber=${dataMap["invoiceNumber"]}&giftBy=${dataMap["dialCode"]}${dataMap["phoneNumber"]}";
    // }

    var body = <String, String>{
      // "callBackUrl": "${BaseUrl().webSiteUrl}receipt",
      "callBackUrl": callBackUrl,
      "amount": "${state.amount - getOfferAmount()}", // dataMap["amount"],
      "invoiceNumber": state.dataMap["invoiceNumber"],
    };

    final result = await _repository.bKashPayemnt(body);
    result.fold(
      (error) {
        if (bkashCallCount <= 1) {
          bkashCallCount++;
          getBkashPayment(context, canLoading: false);
        } else {
          Utils.closeDialog(ConsultationSdk().navigatorKey.currentState!.context);
          Utils.showMiddleToast(error.message);
          Future.delayed(const Duration(seconds: 1)).then((value) {
            // Get.find<CartController>().clearCart();
            // Get.offAndToNamed(Routes.myOrderScreen);
          });
        }
      },
      (data) {
        Utils.closeDialog(ConsultationSdk().navigatorKey.currentState!.context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CliniCallWebView(
              title: "Bkash Payment",
              url: data,
              isBackHome: true,
            ),
          ),
        );
      },
    );
  }

  Future<Map<String, dynamic>> getHamzaLa() async {
    String id = _authCubit.serviceToken;
    try {
      final result = await _repository.getHamzaLa(id);
      result.fold(
        (error) {
          return {};
        },
        (data) {
          fuckMap = data;
          return data;
        },
      );
    } catch (e) {
      return {};
    }
    return {};
  }

  int xx = 0;
  Future<void> makeEblSignature(BuildContext context) async {
    if(fuckMap.isEmpty){
      Map<String,dynamic>? xyz = await getHamzaLa();
      if(xyz.isEmpty){
        if(xx == 0){
          xx++;
          await makeEblSignature(context);
          return;
        }
        Utils.showMiddleToast("Token is invalid!Try again");
        return;
      }
    }
    var uuid = const Uuid();
    String trId = uuid.v4();
    String referenceNumber = state.dataMap["invoiceNumber"];
    String dateTime = DateTime.now().toUtc().toIso8601String().replaceAll(
      RegExp(r'\.\d{6}Z$'),
      'Z',
    );

    Map<String, String> signedData = EBLService().getSignedData(
      trnId: trId,
      amount: "${state.amount - getOfferAmount()}", // dataMap["amount"],
      firstName: state.dataMap["firstName"],
      lastName: state.dataMap["lastName"],
      phoneNumber: state.dataMap["phoneNumber"],
      referenceNumber: referenceNumber,
      dateTime: dateTime,
      hasina: fuckMap["khaleda"],
      jamal: fuckMap["hamza"],
      address: state.dataMap["address"],
      email: state.dataMap["email"],
      countryCode: state.dataMap["countryCode"],
      district: state.dataMap["district"],
      thana: state.dataMap["thana"],
      postalCode: state.dataMap["postalCode"],
      userName: state.dataMap["userName"] ?? "",
      isGift: state.dataMap["gift"] != null,
    );

    Utils.loadingDialog(context);

    final result = await EBLService().getSignature(signedData, _repository);
    result.fold(
      (error) {
        Utils.closeDialog(ConsultationSdk().navigatorKey.currentState!.context);
        Utils.showMiddleToast(error.message);
        Future.delayed(const Duration(seconds: 1)).then((value) {
          // Get.find<CartController>().clearCart();
          // Get.offAndToNamed(Routes.myOrderScreen);
        });
      },
      (data) {
        Utils.closeDialog(ConsultationSdk().navigatorKey.currentState!.context);
        // makeEBLPayment(orderModel,data,referenceNumber,dateTime,context);
        makeEBLPayment(data, referenceNumber, trId, dateTime, context);
      },
    );
  }

  void makeEBLPayment(
    String signature,
    String referenceNumber,
    String trId,
    String dateTime,
    BuildContext context,
  ) async {
    Map<String, String> paymentData = EBLService().getPaymentData(
      trnId: trId,
      amount: "${state.amount - getOfferAmount()}", // dataMap["amount"],
      firstName: state.dataMap["firstName"],
      lastName: state.dataMap["lastName"],
      phoneNumber: state.dataMap["phoneNumber"],
      referenceNumber: referenceNumber,
      dateTime: dateTime,
      hasina: fuckMap["khaleda"],
      jamal: fuckMap["hamza"],
      address: state.dataMap["address"],
      email: state.dataMap["email"],
      countryCode: state.dataMap["countryCode"],
      district: state.dataMap["district"],
      thana: state.dataMap["thana"],
      postalCode: state.dataMap["postalCode"],
      signature: signature,
      userName: state.dataMap["userName"] ?? "",
      isGift: state.dataMap["gift"] != null,
    );

    if (kDebugMode) {
      dev.log(
        name: "Payment Data",
        "payment data: ${json.encode(paymentData)}",
      );
    }

    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EblPaymentScreen(paymentData: paymentData, signature: signature),
      ),
    );
  }

  Future<void> buyPackage(context) async {
    var body = <String, dynamic>{};
    body.addAll({"userId": state.dataMap["userId"]});
    body.addAll({"packageId": "${state.dataMap["packageId"]}"});
    body.addAll({
      "packageVariationId": "${state.dataMap["packageVariationId"]}",
    });
    if (state.dataMap['gift'] != null) {
      body.addAll({"senderId": state.dataMap["userId"]});
      if (state.dataMap["userName"].isNotEmpty) {
        body.addAll({"userName": state.dataMap["userName"]});
      }
      body.addAll({"userPhone": state.dataMap["userPhone"]});
      body.addAll({"userCountryCode": state.dataMap["userCountryCode"]});
      body.addAll({"userDialCode": state.dataMap["userDialCode"]});
      body.addAll({"gift": "gift"});
    }
    if (state.discountPercentage > 0) {
      body.addAll({"discountedPrice": state.amount - getOfferAmount()});
      body.addAll({"discountPercent": state.discountPercentage});
    }
    if (getDiscountPercentReason().isNotEmpty) {
      body.addAll({"discountReason": getDiscountPercentReason().trim()});
    }
    body.addAll({"packageTitle": "${state.dataMap["packageTitle"] ?? ""}"});
    Utils.loadingDialog(context);
    final result = await _repository.buyPackage(body);
    result.fold(
      (error) {
        Future.delayed(const Duration(milliseconds: 1500)).then((value) {
          Utils.closeDialog(ConsultationSdk().navigatorKey.currentState!.context);
          // Utils.showSnackBar(title: AppText().error, message: error.message,);
          String message = error.message;
          if (message.toLowerCase().contains("already running")) {
            Helper.customAlertDialog(
              ConsultationSdk().navigatorKey.currentState!.context,
              message:
                  "You already have an active package. You don’t need to buy another one. But you can gift a package to someone else from the Package section by selecting “Send as Gift.",
              title: "Warning",
              height: screenWidth(),
              okButtonText: "Cancel",
            );
          } else {
            Helper.customAlertDialog(
              ConsultationSdk().navigatorKey.currentState!.context,
              message: error.message,
              title: "Warning",
              okButtonText: "Cancel",
            );
          }
        });
      },
      (data) {
        Future.delayed(const Duration(milliseconds: 1500)).then((value) async {
          Utils.closeDialog(ConsultationSdk().navigatorKey.currentState!.context);
          //todo: get active health card
          // Get.find<ServicePackageController>().getActiveHealthCard();
          // call payment
          var dataMap = state.dataMap;
          dataMap.addAll({"invoiceNumber": data.invoiceNumber});
          emit(state.copyWith(dataMap: dataMap));
          if (state.paymentType?.bankName == "bkash") {
            getBkashPayment(context);
          } else {
            makeEblSignature(context);
          }
        });
      },
    );
  }

  int getOfferAmount() {
    int offerPrice = 0;
    if (state.discountPercentage > 0) {
      offerPrice = (state.amount * state.discountPercentage) ~/ 100;
    }
    return offerPrice;
  }

  String getDiscountPercentReason(){
    String reason = "";
    if(state.discountPercentage > 0){
      if(state.paymentType?.bankName == "bkash"){
        reason = "Bkash - Flat ${state.discountPercentage}%";
      } else {
        reason = "Card - Flat ${state.discountPercentage}%";
      }
    }
    return reason;
  }
}
