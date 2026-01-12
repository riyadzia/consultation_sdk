import 'package:consultation_sdk/consultation_sdk.dart';
import 'package:consultation_sdk_example/home_screen.dart';
import 'package:flutter/material.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  ConsultationSdk().initialize(serviceKey: "",navigatorKey: navigatorKey);
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
