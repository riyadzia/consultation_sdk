import '../core/app_icons.dart';

class PaymentTypeModel {
  final String paymentName;
  final String icon;

  const PaymentTypeModel(this.paymentName, this.icon);
}

class BankTypeModel {
  final String bankName;
  final List<String> logoList;

  const BankTypeModel(this.bankName, this.logoList);
}

const List<BankTypeModel> bankTypeList = [
  BankTypeModel("bkash",[AppIcons.bkashLogo]),
  BankTypeModel("Card Payment",[AppIcons.masterCard,AppIcons.visa]),
];