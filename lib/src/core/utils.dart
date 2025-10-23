import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/core/contants.dart';
import 'package:consultation_sdk/src/di/injector.dart';
import 'package:consultation_sdk/src/di/seignalling_service.dart';
import 'package:consultation_sdk/src/domain/repository/remote_database.dart';
import 'package:consultation_sdk/src/global_widget/custom_button.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/global_widget/loading_widget.dart';
import 'package:consultation_sdk/src/global_widget/svg_asset_image.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'app_icons.dart';
// import 'app_sizes.dart';

class Utils {
  static void copiedToClipBoard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    // showSnackBar(message: "Copied to clipboard");
  }

  static bool checkIsNull(value) {
    if (value == null) {
      return true;
    } else if (value == "") {
      return true;
    } else if (value == "null") {
      return true;
    }
    return false;
  }

  static showMiddleToast(
    String message, {
    ToastGravity gravity = ToastGravity.CENTER,
    Toast? toastLength = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withValues(alpha: 0.7),
      textColor: Colors.white,
      fontSize: 14,
    );
  }

  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static loadingDialog(
    BuildContext context, {
    bool barrierDismissible = false,
  }) {
    showCustomDialog(
      context,
      child: const SizedBox(height: 100, child: Center(child: LoadingWidget())),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future showCustomDialog(
    BuildContext context, {
    Widget? child,
    bool barrierDismissible = false,
    int delay = 400,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: delay),
      pageBuilder: (context, animation, secondaryAnimation) =>
          Align(alignment: Alignment.center, child: child!),
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ).animate(animation),
            child: child,
          ),
    );
  }

  static void closeDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static String getLoggedInUserToken() {
    // var loginController = Get.find<LoginController>();

    // if ((loginController.user?.accessToken ?? "").isEmpty) {
    //   Utils.showSnackBar(message: AppText().pleaseLoginFirst);
    //   Get.offAndToNamed(Routes.login);
    // }

    String token1 = "Bearer $token";

    return token1;
  }

  static Color getColor(int type) {
    if (type == 1) {
      return Colors.green;
    } else if (type == 2) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }

  static double statusBarHeight(BuildContext context) {
    return MediaQuery.paddingOf(context).top;
  }

  static BoxDecoration defaultBoxDecoration() {
    return BoxDecoration(
      boxShadow: defaultBoxShadow(3),
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    );
  }

  static zeroPxBoxShadow({double value = 0}) => <BoxShadow>[
    BoxShadow(
      color: Colors.grey.withValues(alpha: 0.2),
      blurRadius: 4,
      offset: Offset(value, value),
    ),
  ];

  static zeroPxBoxShadowWithDark({double value = 0}) => <BoxShadow>[
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.25),
      blurRadius: 4,
      offset: Offset(value, value),
    ),
  ];

  static defaultBoxShadow(double value) => <BoxShadow>[
    BoxShadow(
      color: Colors.grey.withValues(alpha: 0.05),
      blurRadius: 6,
      offset: Offset(value, value),
    ),
    BoxShadow(
      color: Colors.grey.withValues(alpha: 0.1),
      blurRadius: 6,
      offset: Offset(-value, -value),
    ),
  ];

  static double spentPercentage(double whole, double parts) {
    if (whole == 0.0 || parts == 0.0) return 0;
    double value = ((parts / whole) * 100).toDouble();
    return value > 100 ? 100 : value;
  }

  static double toDouble(value) {
    try {
      if (value == null) return 0.0;
      if (value == "") return 0.0;
      if (value is String) return double.tryParse(value) ?? 0.0;
      if (value is int) return value.toDouble();
      if (value is double) return value;
    } catch (e) {
      return 0.0;
    }
    return 0.0;
  }

  static int toInt(value) {
    try {
      if (value == null) return 0;
      if (value == "") return 0;
      if (value is String) return int.tryParse(value) ?? 0;
      if (value is int) return value;
      if (value is double) return value.ceilToDouble().toInt();
    } catch (e) {
      return 0;
    }
    return 0;
  }

  static double perMonthCalculation(
    double amount,
    String type,
    String startDate,
    String endDate,
  ) {
    double value = 0.0;
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    var difference = end.difference(start).inDays;
    difference = difference < 1 ? 1 : difference;
    if (type.toLowerCase().contains("week")) {
      value =
          double.tryParse(
            (amount / (difference / 7).ceilToDouble()).toStringAsFixed(2),
          ) ??
          0;
    } else if (type.toLowerCase().contains("month")) {
      value =
          double.tryParse(
            (amount / (difference / 30).ceilToDouble()).toStringAsFixed(2),
          ) ??
          0.0;
    } else if (type.toLowerCase().contains("year")) {
      value =
          double.tryParse(
            (amount / (difference / 365).ceilToDouble()).toStringAsFixed(2),
          ) ??
          0.0;
    }
    return value;
  }

  static String getNumberPlace(int index) {
    int value = index + 1;
    if (value == 1) return "1st";
    if (value == 2) return "2nd";
    if (value == 3) return "3rd";
    return "${value}th";
  }

  String getOrdinal(int number) {
    if (number % 100 >= 11 && number % 100 <= 13) {
      return '${number}th';
    }
    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  static String shortenFileName(String filePath, id) {
    String fileName = filePath.split('/').last;
    fileName = fileName.replaceAll('image_picker', '$id');
    String fileNameWithoutExtension = fileName.split('.').first;
    String extension = fileName.split('.').last;

    int maxLength = 30;

    if (fileName.length <= maxLength) {
      return fileName;
    }

    int fileNameWithoutExtensionLength = fileNameWithoutExtension.length;
    int extensionLength = extension.length;

    int removeCount =
        fileNameWithoutExtensionLength + extensionLength - maxLength + 3;
    int startIndex = (fileNameWithoutExtensionLength - removeCount) ~/ 2;

    String shortenedName =
        "${fileNameWithoutExtension.replaceRange(startIndex, startIndex + removeCount, '')}.$extension";

    return shortenedName;
  }

  static bool isImageUrl(String url) {
    final imageExtensions = ['.jpg', '.jpeg', '.png'];
    // final imageExtensions = [".jpg", ".png", ".jpeg", ".jfif", ".pjpeg", ".pjp", ".webp"];

    final uri = Uri.parse(url);
    final fileExtension = uri.pathSegments.last.split('.').last.toLowerCase();

    return imageExtensions.contains('.$fileExtension');
  }

  static Future showSuccessDialog(
    BuildContext context, {
    required String content,
    String? title,
    Function()? onTap,
    bool barrierDismissible = false,
    int delay = 400,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: delay),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const Align(alignment: Alignment.center, child: Text("")),
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ).animate(animation),
            child: Center(
              child: Material(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 25),
                      const SvgAssetImage(image: AppIcons.successIcon),
                      const SizedBox(height: 25),
                      Text(
                        title ?? "Success",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.blue2nd,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        content,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomButton(
                        title: "Continue",
                        onTap:
                            onTap ??
                            () {
                              // Get.back();
                            },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }

  static String getShortFormOfBalance(double amount) {
    if (amount > 999999.00) {
      return "${(amount / 1000000).toStringAsFixed(0)}M";
    } else if (amount > 999) {
      return "${(amount / 1000).toStringAsFixed(0)}K";
    } else {
      return "${(amount).toStringAsFixed(0)} ${Constants.currencySymbol}";
    }
  }

  static String getTransactionType(int type) {
    if (type == 1) return "Cash In";
    if (type == 2) return "Saved";
    if (type == 3) return "Cash Out";
    return "Cash In";
  }

  static String getAmount(int type, double amount) {
    if (type == 3) {
      return "-${Constants.currencySymbol}${amount.toStringAsFixed(2)}";
    } else {
      return "+${Constants.currencySymbol}${amount.toStringAsFixed(2)}";
    }
  }

  static LinearGradient transactionGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.themeColor,
      AppColors.themeColor1,
      AppColors.themeColor2,
    ],
  );

  static String getDayName(String date, {bool isToday = false}) {
    String day = DateFormat("EEEE").format(DateTime.parse(date));
    return day;
  }

  static final _initialTime = TimeOfDay.now();
  static Future<TimeOfDay?> selectTimeCupernito(
    BuildContext context, {
    TimeOfDay? initialTime,
  }) async {
    initialTime = initialTime ?? _initialTime;
    int initialHour = initialTime.hourOfPeriod;
    int initialMinute = initialTime.minute;
    int initialPeriod = (initialTime.period == DayPeriod.pm) ? 1 : 0;

    int selectedHour = initialHour == 0 ? 12 : initialHour;
    int selectedMinute = initialMinute;
    String selectedPeriod = initialPeriod == 0 ? 'AM' : 'PM';

    return showModalBottomSheet<TimeOfDay>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Hour Picker (1–12)
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 40,
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedHour - 1,
                        ),
                        onSelectedItemChanged: (index) {
                          selectedHour = index + 1;
                        },
                        children: List.generate(12, (index) {
                          final hour = index + 1;
                          return Center(
                            child: Text(hour.toString().padLeft(2, '0')),
                          );
                        }),
                      ),
                    ),
                    // Minute Picker (0–59)
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 40,
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedMinute,
                        ),
                        onSelectedItemChanged: (index) {
                          selectedMinute = index;
                        },
                        children: List.generate(60, (index) {
                          return Center(
                            child: Text(index.toString().padLeft(2, '0')),
                          );
                        }),
                      ),
                    ),
                    // AM/PM Picker
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 40,
                        scrollController: FixedExtentScrollController(
                          initialItem: initialPeriod,
                        ),
                        onSelectedItemChanged: (index) {
                          selectedPeriod = index == 0 ? 'AM' : 'PM';
                        },
                        children: const [
                          Center(child: Text('AM')),
                          Center(child: Text('PM')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                child: CustomText(text: "Continue", fontSize: 14),
                onPressed: () {
                  int hour24 = selectedHour % 12;
                  if (selectedPeriod == 'PM') hour24 += 12;
                  if (selectedPeriod == 'AM' && selectedHour == 12) hour24 = 0;
                  Navigator.pop(
                    context,
                    TimeOfDay(hour: hour24, minute: selectedMinute),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // static Future<TimeOfDay?> selectTime(BuildContext context) async {
  //   TimeOfDay? selectedTime;
  //   Duration initialDuration = Duration(
  //     hours: _initialTime.hour,
  //     minutes: _initialTime.minute,
  //   );
  //
  //   await showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       Duration tempDuration = initialDuration;
  //
  //       return Container(
  //         height: getWidth(300),
  //         padding: EdgeInsets.all(getWidth(5)),
  //         child: Column(
  //           children: [
  //             SizedBox(
  //               height: getWidth(180),
  //               child: CupertinoTimerPicker(
  //                 mode: CupertinoTimerPickerMode.hm,
  //                 initialTimerDuration: initialDuration,
  //                 onTimerDurationChanged: (Duration newDuration) {
  //                   tempDuration = newDuration;
  //                 },
  //               ),
  //             ),
  //             SizedBox(height: getWidth(8)),
  //             CupertinoButton(
  //               color: AppColors.light5,
  //               child: CustomText(text: AppText().continueText, fontSize: getWidth(14)),
  //               onPressed: () {
  //                 selectedTime = TimeOfDay(
  //                   hour: tempDuration.inHours,
  //                   minute: tempDuration.inMinutes % 60,
  //                 );
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //
  //   return selectedTime;
  // }

  static Future<TimeOfDay?> selectTime(BuildContext context) => showTimePicker(
    context: context,
    initialTime: _initialTime,
    initialEntryMode: TimePickerEntryMode.inputOnly,
    builder: (context, child) => Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
      child: child,
    ),
  );

  // for calling sdp..
  static String compressString(String input) {
    List<int> inputBytes = utf8.encode(input);
    // Compress the bytes using zlib
    List<int> compressedBytes = zlib.encode(inputBytes);
    // Return the compressed data as a Base64 string for safe storage or transmission
    return base64Encode(compressedBytes);
  }

  // decompress string for calling
  static String decompressString(String compressedString) {
    // Decode the Base64 string to get the compressed bytes
    List<int> compressedBytes = base64Decode(compressedString);
    // Decompress the bytes using zlib
    List<int> decompressedBytes = zlib.decode(compressedBytes);
    // Convert the decompressed bytes back to a string
    return utf8.decode(decompressedBytes);
  }

  static Map<String, dynamic> makeSdpOffer(String sdp) {
    String sdpOffer = decompressString(sdp);
    return {"sdp": sdpOffer, "type": "offer"};
  }

  static int getUnique6DigitCode() {
    int code = 0;
    code = 100000 + Random().nextInt(900000);
    return code;
  }

  static DateTime convertToTodayDate(String time) {
    // Parse the time string (e.g., "08:30 AM")
    DateFormat timeFormat = DateFormat('hh:mm a');
    DateTime parsedTime = timeFormat.parse(time);

    DateTime now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }

  static String getReminderTime(String value) {
    if (value == "Morning") {
      return "08:30 AM";
    } else if (value == "Afternoon") {
      return "02:00 PM";
    } else if (value == "Night") {
      return "09:00 PM";
    }
    return "";
  }

  //todo: apply dynamic url
  static void initSignallingService(String userId) async {
    SignallingService.instance.init(
      websocketUrl: BaseUrl.callingSocketUrl,
      selfCallerID: userId,
    );
  }

  /// get dates from date range.
  static List<DateTime> getDateListFromDayName(String dayName, {int days = 7}) {
    List<DateTime> dateList = [];
    for (int i = 0; i < days; i++) {
      String day = DateFormat(
        "EEEE",
      ).format(DateTime.now().add(Duration(days: i)));
      if (day == dayName) {
        dateList.add(DateTime.now().add(Duration(days: i)));
      }
    }
    return dateList;
  }

  /// Check Internet Connection
  static Future<bool> checkInternetConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.first == ConnectivityResult.mobile ||
        connectivityResult.first == ConnectivityResult.wifi) {
      return true;
    } else {
      showMiddleToast("No Internet Connection");
      return false;
    }
  }

  static bool isFlatMessage(String message) {
    if (message.startsWith("[") && message.endsWith("]")) {
      return false;
    }
    return true;
  }

  static List<String> getErrorMessages(String message) {
    try {
      List<String> errorList = [];
      // Step 1: Parse the custom format manually
      message = message.substring(
        1,
        message.length - 1,
      ); // Remove square brackets
      List<Map<String, String>> jsonList = [];

      var objectContent = message.substring(
        1,
        message.length - 1,
      ); // Remove curly braces

      Map<String, String> jsonObject = {};
      var entries = objectContent.split(
        RegExp(r',(?=\s*\w+:)'),
      ); // Split by commas between key-value pairs

      for (var entry in entries) {
        var keyValue = entry.split(':');
        var key = keyValue[0].trim();
        var value = keyValue.sublist(1).join(':').trim();

        // Clean up and ensure value is properly quoted
        if (!value.startsWith('"')) {
          value = '"$value"';
        }

        jsonObject[key] = value.replaceAll('"', '');
      }

      jsonList.add(jsonObject);

      // Step 2: Convert to JSON string and decode
      String jsonString = jsonEncode(jsonList);
      List<dynamic> parsedJson = json.decode(jsonString);

      // Step 3: Access the properties
      for (var item in parsedJson) {
        errorList.add(item["message"]);
      }
      return errorList;
    } catch (e) {
      return [];
    }
  }

  static Future<String?> encryptText(
    String plainText,
    String salt,
    String timeMillisecond,
    String serviceId,
  ) async {
    final headers = {'Accept': 'application/json', 'authorization': serviceId};
    String xyz = "";
    try {
      final response = await getIt.get<RemoteDataSourceInit>().getRequest(
        url: "${BaseUrl().baseUrl}girls-minds/read",
        customHeader: headers,
        body: {NORWAY: YES},
      );
      if (Utils.checkIsNull(response["success"]) != true &&
          response["success"] == true) {
        xyz = response["data"]["norway"];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
    final key = utf8.encode(xyz);
    final combined = '$plainText:$salt:$timeMillisecond';
    final bytes = utf8.encode(combined);
    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);
    return base64Encode(digest.bytes);
  }
}
