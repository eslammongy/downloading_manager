import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectivityChecker {
  static final InternetConnection _internetConnection = InternetConnection();
  static bool _hasConnection = false;
  static StreamSubscription<InternetStatus>? _subscription;

  /// Whether there is an active internet connection
  static bool get hasConnection => _hasConnection;

  /// Initialize the connectivity checker with optional callbacks
  static Future<void> initialize({
    VoidCallback? onConnectionRestored,
    VoidCallback? onConnectionLost,
  }) async {
    // Check initial connection status
    _hasConnection =
        await _internetConnection.internetStatus == InternetStatus.connected;
    debugPrint("Connectivity Status: $_hasConnection");
    // Listen for connection status changes
    _subscription?.cancel(); // Prevent duplicate subscriptions
    _subscription = _internetConnection.onStatusChange.listen((status) {
      _hasConnection = status == InternetStatus.connected;
      if (_hasConnection) {
        onConnectionRestored?.call();
      } else {
        onConnectionLost?.call();
      }
    });

    // Register as a lifecycle observer
    WidgetsBinding.instance.addObserver(_LifecycleObserver());
  }

  /// Clean up resources when no longer needed
  static void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}

class _LifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        InternetConnectivityChecker._subscription?.resume();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        InternetConnectivityChecker._subscription?.pause();
        break;
      default:
        break;
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
