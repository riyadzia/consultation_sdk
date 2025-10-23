import 'package:consultation_sdk/consultation_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _testSdkPlugin = ConsultationSdk();
  @override
  void initState() {
    super.initState();
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
          ElevatedButton(
            onPressed: () {
              try {
                _testSdkPlugin
                    .authenticate(
                      countryLetterCode: "BD",
                      dialCode: "880",
                      phoneNumber: "1860141942",
                      authToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZSI6IjE4NjAxNDE5NDIiLCJpYXQiOjE3NjAyNDk4MjMsImV4cCI6MjM2NTA0OTgyM30.My3KdBKlKiVw1AQlDokxXgrRwNAAttrtm3x8DevIooI",
                      // authToken: "",
                    )
                    .then((value) {
                      if (kDebugMode) {
                        //save it for next time auto login
                        print("User Token Auth Token: $value");
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
