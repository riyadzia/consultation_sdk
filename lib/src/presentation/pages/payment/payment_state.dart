import 'package:consultation_sdk/src/model/payment_type_model.dart';

class PaymentState {
  final Map<String, dynamic> dataMap;
  final BankTypeModel? paymentType;
  final int amount;
  final int discountedPrice;
  final int discountPercentage;
  final bool isLoading;
  final int? startPayment;

  PaymentState({
    required this.dataMap,
    this.paymentType,
    this.amount = 0,
    this.discountedPrice = 0,
    this.discountPercentage = 0,
    this.isLoading = false,
    this.startPayment = 0,
  });

  PaymentState copyWith({
    Map<String, dynamic>? dataMap,
    BankTypeModel? paymentType,
    int? amount,
    int? discountedPrice,
    int? discountPercentage,
    bool? isLoading,
    int? startPayment,
  }) {
    return PaymentState(
      dataMap: dataMap ?? this.dataMap,
      paymentType: paymentType ?? this.paymentType,
      amount: amount ?? this.amount,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      isLoading: isLoading ?? this.isLoading,
      startPayment: startPayment ?? this.startPayment,
    );
  }
}
