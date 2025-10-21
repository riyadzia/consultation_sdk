import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/app_url.dart';
import 'package:consultation_sdk/src/global_widget/app_pinky_circle_gradient.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';
import 'package:consultation_sdk/src/global_widget/page_back__border_button.dart';
import 'package:consultation_sdk/src/screen/main_screen.dart';

class CliniCallWebView extends StatefulWidget {
  final String url; // Payment data passed to this screen
  final String title; // Signature for the payment
  final bool isBackHome;

  const CliniCallWebView({
    super.key,
    required this.url,
    this.isBackHome = false,
    required this.title,
  });

  @override
  State<CliniCallWebView> createState() => CliniCallWebViewState();
}

class CliniCallWebViewState extends State<CliniCallWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
  );

  bool isPaymentComplete = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isPaymentComplete && widget.isBackHome) {
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (_) => MainScreen()),
          //   (Route<dynamic> route) => false,
          // );
          return Future.value(false);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(text: widget.title, fontSize: getWidth(16)),
          toolbarHeight: 70,
          flexibleSpace: const AppPinkyCircleGradient(),
          leading: PageBackBorderButton(
            onPressed: () {
              if (isPaymentComplete) {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (_) => MainScreen()),
                //       (Route<dynamic> route) => false,
                // );
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: InAppWebView(
          key: webViewKey,
          // webViewEnvironment: webViewEnvironment,
          initialUrlRequest: URLRequest(url: WebUri(widget.url)),
          initialSettings: settings,
          // pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onLoadStart: (controller, url) {
            if (url != null) {
              if (url.toString().contains(
                "${BaseUrl().webSiteUrl}mobilereceipt",
              )) {
                isPaymentComplete = true;
              }
            }
            // setState(() {
            //   this.url = url.toString();
            //   urlController.text = this.url;
            // });
          },
          onPermissionRequest: (controller, request) async {
            return PermissionResponse(
              resources: request.resources,
              action: PermissionResponseAction.GRANT,
            );
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

            if (![
              "http",
              "https",
              "file",
              "chrome",
              "data",
              "javascript",
              "about",
            ].contains(uri.scheme)) {
              return NavigationActionPolicy.CANCEL;
              // if (await canLaunchUrl(uri)) {
              //   // Launch the App
              //   await launchUrl(uri);
              //   // and cancel the request
              //   return NavigationActionPolicy.CANCEL;
              // }
            }

            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            // pullToRefreshController?.endRefreshing();
            // setState(() {
            //   this.url = url.toString();
            //   urlController.text = this.url;
            // });
          },
          onReceivedError: (controller, request, error) {
            // pullToRefreshController?.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            // if (progress == 100) {
            // pullToRefreshController?.endRefreshing();
            // }
            // setState(() {
            //   this.progress = progress / 100;
            //   urlController.text = url;
            // });
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            // setState(() {
            //   this.url = url.toString();
            //   urlController.text = this.url;
            // });
          },
          onConsoleMessage: (controller, consoleMessage) {
            if (kDebugMode) {
              print(consoleMessage);
            }
          },
        ),
        // body: InAppWebView(
        //   initialData: InAppWebViewInitialData(
        //     data: "",
        //     mimeType: "text/html",
        //     encoding: "utf-8",
        //     baseUrl: WebUri(widget.url),
        //   ),
        //   onWebViewCreated: (controller) {
        //     // Automatically submit the form when the web view loads
        //     // controller.evaluateJavascript(source: "document.forms[0].submit();");
        //   },
        //   onLoadStart: (controller,uri){
        //     Uri? value = uri?.data?.uri;
        //     if (kDebugMode) {
        //       print("((((((((((((((${uri?.data?.uri}))))))))))))))");
        //     }
        //   },
        // ),
      ),
    );
  }
}
