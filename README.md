# 🧩 CliniCall Doctor Consulation SDK

A Flutter SDK for integrating **CliniCall Doctor Consultation and Package Purchase features** into any Flutter app.

This SDK provides:
- 🔐 OTP-based phone authentication
- 📱 Auto navigation to a customizable main screen
- 🧭 Global navigator key integration
- 🚀 Simple one-line initialization
- ⚡ Real-time Communication using **socket.io**
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
    path: ../consultation_sdk
```

Then run:

```bash
flutter pub get
```

---

## 🧩 Initialization

In your host app’s `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:consultation_sdk/consultation_sdk.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SDK with the navigator key
  ConsultationSdk.instance.initialize(navigatorKey);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  phoneNumber: "1712345678",
  serviceToken: "your_service_token_here",
);
```

### 📋 Parameters

| Parameter | Type | Required | Description |
|------------|------|-----------|-------------|
| `countryLetterCode` | `String` | ✅ | Two-letter ISO country code (e.g., BD) |
| `dialCode` | `String` | ✅ | Country dial code (e.g., 880) |
| `phoneNumber` | `String` | ✅ | User’s phone number |
| `serviceToken` | `String` | ✅ | Token from your backend |
| `authToken` | `String?` | ❌ | Previous auth token for auto-login |

### 🧾 Returns
`Future<String>` — returns a valid authentication token on success.

---

## 🧭 Example Implementation

```dart
ElevatedButton(
  onPressed: () async {
    try {
      final token = await ConsultationSdk.instance.authenticate(
        countryLetterCode: "BD",
        dialCode: "880",
        phoneNumber: "1712345678",
        serviceToken: "my_service_token",
      );
      print("✅ Authenticated Token: $token");
    } catch (e) {
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

### Common Errors

| Error Type | Cause |
|-------------|--------|
| `NetworkError` | No internet connection |
| `InvalidTokenError` | Invalid service token |
| `OtpError` | OTP sending or verification failed |
| `UnknownError` | Any unexpected runtime error |


---

## 🧑‍💻 Developer Notes

- Initialize the SDK before calling any function.
- Always pass a valid `navigatorKey`.
- Do **not** manually register dependencies already handled by SDK.
- Supports **Flutter 3.19+** and **Dart 3.2+**.

---

## 🧾 License

```
Copyright © 2025
All rights reserved to the CliniCall Limited.
Unauthorized distribution or modification is prohibited.
```

---

## 💬 Support

For technical support or integration help, contact CliniCall Limited.  
Pull requests and feature suggestions are always welcome!

---

✨ **Made with ❤️ in Flutter**
