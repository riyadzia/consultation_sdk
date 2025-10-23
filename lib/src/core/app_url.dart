class BaseUrl {
  // static const String _rootUrl = "http://192.168.10.10:5000/";
  static const String _rootUrl = "https://theclinicall.com/";
  static const String callingSocketUrl = "http://theclinicall.com:5006";
  // static const String callingSocketUrl = "http://192.168.10.10:5006";
  String get webSiteUrl => _rootUrl;
  // String get webSiteUrl => "http://192.168.10.230:3000/";
  final String _baseUrl = "${_rootUrl}bkapi/";
  String get baseUrl => _baseUrl;

  static String getEBLSignature = '${BaseUrl().baseUrl}admin/ebl/payment';
  String eblPaymentLive = 'https://secureacceptance.cybersource.com/pay';
  // String eblPaymentLive = 'https://testsecureacceptance.cybersource.com/pay';
  static String bKashPayemnt = '${BaseUrl().baseUrl}admin/bkash/payment/create';
}