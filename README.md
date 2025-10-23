# 🧩 CliniCall Doctor Consulation SDK

A Flutter SDK for integrating **CliniCall Doctor Consultation and Package Purchase features** into any Flutter app.

This SDK provides:
- 🔐 **OTP**-based phone authentication
- 📱 Auto navigation to **MainScreen**
- 🧭 Global **navigator-key** integration
- 🚀 Simple one-line initialization
- ⚡  Real-time Communication using **socket.io**
- 💳 Supported Payment Gateways: **Card & MFS**



---

## 🧰 Features

✅ Phone authentication via OTP  
✅ Service token–based secure login  
✅ Auto redirect after authentication  
✅ Audio/Video Calling for Doctor Consultation 24/7  
✅ Package Purchase for Doctor Consultation  



---

## ⚙️ Installation

Add this SDK to your **host app**:

```yaml
dependencies:
  consultation_sdk:
    git:
    url: https://github.com/riyadzia/clinicall_sdk.git
    ref: main
```

Then run:

```bash
flutter pub get
```

---

### Privacy Permission 
#### Android

CliniCall Consulation SDK requires `Camera` and `Microphone` Others permission to start a video call.

```xml
<uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <!-- The Consulation SDK requires Bluetooth permissions in case users are using Bluetooth devices. -->
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <!-- For Android 12 and above devices, the following permission is also required. -->
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_CAMERA" />
```

Add this line in the `AndroidManifest.xml` file
To keep audio/video calls running in the background, add it to the `Application` block of the `AndroidManifest.xml` file.

`android:requestLegacyExternalStorage="true"
 android:usesCleartextTraffic="true"`

```xml

<service
        android:name="com.clinicall.consultation_sdk.CallForegroundService"
        android:foregroundServiceType="camera|microphone"
        android:exported="false"/>

```

#### iOS & macOS

Open the `Info.plist` and add:

```plist
<key>NSAppTransportSecurity</key>
    <dict>
    	<key>NSAllowsArbitraryLoadsInWebContent</key>
    	<true/>
    	<key>NSAllowsLocalNetworking</key>
    	<true/>
    </dict>
<key>NSAppleMusicUsageDescription</key>
<string>Allow access to microphone for Audio/video call during doctor consultation</string>
<key>NSCameraUsageDescription</key>
<string>Updating user profile and using app functionality and audio/video call for doctor consultation</string>
<key>NSDocumentDirectory</key>
<string>Allow access to document directory for caching some data for using app better performance</string>
<key>NSMicrophoneUsageDescription</key>
<string>Allow access to microphone for Audio/video call during doctor consultation</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Updating user profile and using app functionality</string>
<key>UIBackgroundModes</key>
<array>
	<string>fetch</string>
	<string>remote-notification</string>
	<string>voip</string>
</array>

```


## 🧩 Initialization

In your app’s `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:consultation_sdk/consultation_sdk.dart';

// Add this line
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SDK with the navigator key
  ConsultationSdk().initialize(serviceKey: "your_service_key_here",navigatorKey: navigatorKey);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Call same navigator key here
      navigatorKey: navigatorKey,
      home: HomeScreen(),
    );
  }
}
```

---

## 🔑 Authentication Flow

Use the `authenticate()` method to start the authentication process.

```dart
final sdk = ConsultationSdk.instance;

final token = await sdk.authenticate(
  countryLetterCode: "BD",
  dialCode: "880",
  phoneNumber: "1715000000",
  authToken: "auth_token_here",// Previous auth token for auto-login
);
```

### 📋 Parameters

| Parameter | Type | Required | Description                            |
|------------|------|-----------|----------------------------------------|
| `countryLetterCode` | `String` | ✅ | Two-letter ISO country code (e.g., BD) |
| `dialCode` | `String` | ✅ | Country dial code (e.g., 880)          |
| `phoneNumber` | `String` | ✅ | User’s phone number (e.g., 1715000000) |
| `authToken` | `String?` | ❌ | Previous auth token for auto-login     |

### 🧾 Returns
`Future<String>` — returns a valid authentication token on success.

---

## 🧭 Example Implementation

```dart
ElevatedButton(
  onPressed: () async {
    try {
      await ConsultationSdk.instance.authenticate(
        countryLetterCode: "BD",
        dialCode: "880",
        phoneNumber: "1712345678",
        authToken: "auth_token_here",
      ).then((token) {
        // Save the token for next time auto-login.
        print("Successfully Logged In: $token");
      });
    } catch (e) {
      // Handle errors
      print("❌ Error: $e");
    }
  },
  child: Text("Login with Phone"),
);
```

---

## 🧭 Navigation Flow

Once authentication succeeds:
- The SDK automatically pushes `MainScreen` from within the SDK.

---

## ⚠️ Error Handling

Use `try-catch` to safely handle SDK operations.

```dart
try {
  final token = await ConsultationSdk.instance.authenticate(...);
} catch (e) {
  print("Error: $e");
}
```


## 🧑‍💻 Developer Notes

- Initialize the SDK before calling any function.
- Always pass a valid `navigatorKey`.
- Do **not** manually register dependencies already handled by SDK.
- Always update with the latest SDK version using the command - 
  ```flutter pub upgrade --major-versions```.


---

## 🧾 License

```
Copyright © 2025 CliniCall Limited.
All rights reserved to the CliniCall Limited.
Unauthorized distribution or modification is prohibited.
```


---

## 💬 Support

For technical support or integration help, contact CliniCall Limited.  
Pull requests and feature suggestions are always welcome!

---

✨ **Made with ❤️ in Flutter**
