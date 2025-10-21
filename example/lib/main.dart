import 'package:consultation_sdk/consultation_sdk.dart';
import 'package:consultation_sdk_example/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  ConsultationSdk().initialize(serviceKey: "DJ4AZ25ZGYMOA5K3PDP6MGIRIWC9IEIHGZ5XRTT2WI0798TO80OJT7FT5D54G34Z",navigatorKey: navigatorKey);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: HomeScreen(),
    );
  }
}
