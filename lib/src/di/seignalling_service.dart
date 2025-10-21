
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SignallingService {
  // instance of Socket
  Socket? socket;

  SignallingService._();
  static final instance = SignallingService._();

  init({required String websocketUrl, required String selfCallerID}) {
    disconnect();
    // init Socket
    socket = io(websocketUrl, {
      "transports": ['websocket'],
      "path": '/socket.io',
      "query": {"callerID": selfCallerID}
    });

    // listen onConnect event
    socket!.onConnect((data) {
      socket!.emit("register",selfCallerID);
      log("Socket connected !!");
    });

    // listen onConnectError event
    socket!.onConnectError((data) {
      log("socket Connection Error: $data");
    });

    // connect socket
    socket!.connect();
  }


  Future<void> disconnect() async {
    if (kDebugMode) {
      print("xxxxxxxxxxxxxxxxxx entry for socket disconnection xxxxxxxxxxxxxxxx");
    }

    if (socket != null) {
      if (kDebugMode) {
        print("xxxxxxxxxxxxxxxxxx socket Disconnecting xxxxxxxxxxxxxxxx");
      }
      try {
        socket?.offAny();       // ✅ remove all listeners
        socket?.disconnect();   // ✅ close socket
        socket?.destroy();      // ✅ release all resources
        if (kDebugMode) {
          print("xxxxxxxxxxxxxxxxxx socket disconnected successfully xxxxxxxxxxxxxxxx");
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error disconnecting socket: $e");
        }
      } finally {
        socket = null;          // ✅ make sure reference cleared
      }
    } else {
      if (kDebugMode) {
        print("Socket already null, nothing to disconnect");
      }
    }
  }

}