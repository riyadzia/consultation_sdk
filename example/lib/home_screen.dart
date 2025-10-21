import 'package:consultation_sdk/consultation_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _platformVersion = 'Unknown';

  final _testSdkPlugin = ConsultationSdk();

  @override
  void initState() {
    // TestSdk.init(navigatorKey: navigatorKey);
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _testSdkPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CliniCall Doctor Call'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),

          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (_) => const CallScreen(callerId: "Doctor123"),
          //       ),
          //     );
          //   },
          //   child: const Text('Start Call'),
          // ),
          ElevatedButton(
            onPressed: () {
              try {
                _testSdkPlugin
                    .authenticate(
                      countryLetterCode: "BD",
                      dialCode: "880",
                      phoneNumber: "1860141942",
                      // serviceToken: "wwwwww",
                      authToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZSI6IjE4NjAxNDE5NDIiLCJpYXQiOjE3NjAyNDk4MjMsImV4cCI6MjM2NTA0OTgyM30.My3KdBKlKiVw1AQlDokxXgrRwNAAttrtm3x8DevIooI",
                      // authToken: "",
                    )
                    .then((value) {
                      if (kDebugMode) {
                        print("Token received from Host APP: $value");
                      }
                    });
              } catch (e) {
                if (kDebugMode) {
                  print("error: ${e.toString()}");
                }
              }
            },
            child: const Text('Start Call from SDK'),
          ),
        ],
      ),
    );
  }
}
