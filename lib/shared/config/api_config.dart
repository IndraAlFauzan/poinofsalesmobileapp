import 'dart:io';
import 'dart:developer';

class ApiConfig {
  // Base URLs for different environments
  static const String _localHost = "127.0.0.1"; // For iOS/iPad Simulator
  static const String _androidEmulator = "10.0.2.2"; // For Android Emulator
  static const String _localNetwork =
      "192.168.100.234"; // For physical devices on same network
  static const int _port = 8000;

  /// Get the appropriate base URL based on the platform and environment
  static String get baseUrl {
    final url = _determineBaseUrl();
    log(
      "🌐 ApiConfig: Platform=${Platform.operatingSystem}, isSimulator=${_isSimulator()}, URL=$url",
    );
    return url;
  }

  static String _determineBaseUrl() {
    if (Platform.isIOS) {
      // For iOS/iPad, check if running on simulator or physical device
      if (_isSimulator()) {
        return "http://$_localHost:$_port/api/"; // iPad Simulator uses localhost
      } else {
        // Physical iOS device - use local network IP
        // BUT: if localhost is reachable, prefer it (for cases where simulator detection fails)
        return "http://$_localNetwork:$_port/api/";
      }
    } else if (Platform.isAndroid) {
      // For Android, check if running on emulator or physical device
      if (_isEmulator()) {
        return "http://$_androidEmulator:$_port/api/";
      } else {
        // Physical Android device - use local network IP
        return "http://$_localNetwork:$_port/api/";
      }
    }

    // Fallback to localhost for other platforms (web, desktop)
    return "http://$_localHost:$_port/api/";
  }

  /// Force use localhost (for iPad Simulator when auto-detection fails)
  static void useLocalhost() {
    setManualBaseUrl("http://$_localHost:$_port/api/");
    log("🔧 Manually set to use localhost for iPad Simulator");
  }

  /// Check if running on iOS Simulator (including iPad Simulator)
  static bool _isSimulator() {
    // First check for common simulator environment variables
    bool hasSimulatorEnv =
        Platform.environment.containsKey('SIMULATOR_DEVICE_NAME') ||
        Platform.environment.containsKey('SIMULATOR_UDID') ||
        Platform.environment.containsKey('SIMULATOR_ROOT');

    // Alternative detection method for iOS Simulator
    // iOS Simulator typically has specific characteristics in the environment
    bool hasSimulatorPath =
        Platform.environment['HOME']?.contains('CoreSimulator') == true ||
        Platform.environment['TMPDIR']?.contains('CoreSimulator') == true;

    // Check if running on x86_64 architecture (common for simulators on Intel Macs)
    // or if we're in an iOS environment that's clearly a simulator
    bool isSimulatorArchitecture = false;
    try {
      // On iOS Simulator, we can detect by checking if we're running on a desktop-like environment
      // but with iOS platform reported
      isSimulatorArchitecture =
          Platform.isIOS &&
          (Platform.environment['SIMULATOR_MODEL_IDENTIFIER'] != null ||
              Platform.environment['SIMULATOR_CAPABILITIES'] != null);
    } catch (e) {
      // Ignore errors
    }

    final isSimulator =
        hasSimulatorEnv || hasSimulatorPath || isSimulatorArchitecture;

    log("🔍 Simulator check details:");
    log(
      "  - SIMULATOR_DEVICE_NAME: ${Platform.environment['SIMULATOR_DEVICE_NAME']}",
    );
    log("  - SIMULATOR_UDID: ${Platform.environment['SIMULATOR_UDID']}");
    log(
      "  - HOME contains CoreSimulator: ${Platform.environment['HOME']?.contains('CoreSimulator')}",
    );
    log(
      "  - TMPDIR contains CoreSimulator: ${Platform.environment['TMPDIR']?.contains('CoreSimulator')}",
    );
    log(
      "  - SIMULATOR_MODEL_IDENTIFIER: ${Platform.environment['SIMULATOR_MODEL_IDENTIFIER']}",
    );
    log("  - Final isSimulator: $isSimulator");

    return isSimulator;
  }

  /// Check if running on Android Emulator
  static bool _isEmulator() {
    return Platform.environment.containsKey('ANDROID_EMULATOR') ||
        Platform.environment['PATH']?.contains('emulator') == true;
  }

  /// Manual override for development - you can change this for testing
  static String? manualOverride;

  /// Get base URL with manual override support
  static String get effectiveBaseUrl {
    return manualOverride ?? baseUrl;
  }

  /// Set manual base URL for testing different environments
  static void setManualBaseUrl(String url) {
    manualOverride = url;
  }

  /// Clear manual override
  static void clearManualOverride() {
    manualOverride = null;
  }

  /// Available base URLs for easy switching
  static Map<String, String> get availableUrls => {
    'iPad/iOS Simulator': "http://$_localHost:$_port/api/",
    'Android Emulator': "http://$_androidEmulator:$_port/api/",
    'Local Network (Physical Device)': "http://$_localNetwork:$_port/api/",
    'Production':
        'https://your-production-api.com/api/', // Replace with actual production URL
  };
}
