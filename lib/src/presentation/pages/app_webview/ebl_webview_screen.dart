import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/global_widget/app_pinky_circle_gradient.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/global_widget/page_back__border_button.dart';
import 'package:consultation_sdk/src/screen/main_screen.dart';

class EblPaymentScreen extends StatefulWidget {
  final Map<String, String> paymentData; // Payment data passed to this screen
  final String signature; // Signature for the payment

  const EblPaymentScreen({
    super.key,
    required this.paymentData,
    required this.signature,
  });

  @override
  State<EblPaymentScreen> createState() => _EblPaymentScreenState();
}

class _EblPaymentScreenState extends State<EblPaymentScreen> {
  bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isSuccess) {
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (_) => MainScreen()),
          //   (Route<dynamic> route) => false,
          // );
          return Future.value(true);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(text: "Payment", fontSize: getWidth(16)),
          toolbarHeight: 70,
          flexibleSpace: const AppPinkyCircleGradient(),
          leading: PageBackBorderButton(
            onPressed: () {
              // print("$isSuccess");
              // return;
              if (isSuccess) {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (_) => MainScreen()),
                //   (Route<dynamic> route) => false,
                // );
              } else {
                Navigator.pop(context, isSuccess);
              }
            },
          ),
        ),
        body: InAppWebView(
          initialData: InAppWebViewInitialData(
            data: _generateHtmlForm(),
            mimeType: "text/html",
            encoding: "utf-8",
            baseUrl: WebUri(BaseUrl().eblPaymentLive),
          ),
          onWebViewCreated: (controller) {
            // Automatically submit the form when the web view loads
            controller.evaluateJavascript(
              source: "document.forms[0].submit();",
            );
          },
          onLoadStart: (controller, url) {
            if (url != null) {
              if (url.toString().contains(
                "${BaseUrl().webSiteUrl}ebl-receipt-mobile",
              )) {
                isSuccess = true;
              }
            }
            if (kDebugMode) {
              print("(((((((((((((($url))))))))))))))");
            }
          },
          onLoadStop: (controller, url) {
            if (url != null) {
              if (url.toString().contains(
                "${BaseUrl().webSiteUrl}ebl-receipt-mobile",
              )) {
                isSuccess = true;
              }
            }
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            if (url != null) {
              if (url.toString().contains(
                "${BaseUrl().webSiteUrl}ebl-receipt-mobile",
              )) {
                isSuccess = true;
              }
            }
          },
        ),
      ),
    );
  }

  String _generateHtmlForm() {
    final formInputs = widget.paymentData.entries.map((entry) {
      return '<input type="hidden" name="${entry.key}" value="${entry.value}">';
    }).join();
    var form =
        '''
      <html>
        <body onload="document.forms[0].submit()">
          <form method="POST" action="${BaseUrl().eblPaymentLive}">
            $formInputs
          </form>
        </body>
      </html>
    ''';

    log(form);
    // print(form);

    return form;
  }
}
