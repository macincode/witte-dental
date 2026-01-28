import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'firebase_service.dart';

class AppConfig {
  static late PackageInfo _packageInfo;
  static late DeviceInfoPlugin _deviceInfo;
  static Map<String, dynamic>? _deviceData;

  // App Information
  static String get appName => _packageInfo.appName;
  static String get packageName => _packageInfo.packageName;
  static String get version => _packageInfo.version;
  static String get buildNumber => _packageInfo.buildNumber;
  static String get fullVersion => '$version+$buildNumber';

  // Environment Configuration
  static bool get isDebug => kDebugMode;
  static bool get isRelease => kReleaseMode;
  static bool get isProfile => kProfileMode;

  // API Configuration
  static String get baseUrl => FirebaseService.getRemoteConfigValue(
    'api_base_url', 
    isDebug ? 'http://localhost:8000/api' : 'https://witte.macincode.com/api'
  );

  // Feature Flags
  static bool get isChatEnabled => FirebaseService.getRemoteConfigValue('feature_chat_enabled', true);
  static bool get isTelemedicineEnabled => FirebaseService.getRemoteConfigValue('feature_telemedicine_enabled', false);
  static bool get isMaintenanceMode => FirebaseService.getRemoteConfigValue('app_maintenance_mode', false);

  // App Constants
  static const String supportEmail = 'support@witte.macincode.com';
  static const String privacyPolicyUrl = 'https://witte.macincode.com/privacy';
  static const String termsOfServiceUrl = 'https://witte.macincode.com/terms';
  static const String helpUrl = 'https://help.witte.macincode.com';

  // Timeouts and Limits
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration cacheTimeout = Duration(hours: 24);
  static const int maxRetryAttempts = 3;
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB

  // Database Configuration
  static const String databaseName = 'witte_dental.db';
  static const int databaseVersion = 1;

  // Security Configuration
  static const Duration sessionTimeout = Duration(hours: 8);
  static const int maxLoginAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 15);

  /// Initialize app configuration
  static Future<void> initialize() async {
    try {
      // Get package info
      _packageInfo = await PackageInfo.fromPlatform();
      
      // Get device info
      _deviceInfo = DeviceInfoPlugin();
      _deviceData = await _getDeviceData();
      
      print('✅ App Config initialized');
      print('📱 App: $appName v$fullVersion');
      print('🔧 Environment: ${isDebug ? 'Debug' : isRelease ? 'Release' : 'Profile'}');
      print('🌐 API Base URL: $baseUrl');
    } catch (e) {
      print('❌ App Config initialization failed: $e');
    }
  }

  /// Get device information
  static Future<Map<String, dynamic>> _getDeviceData() async {
    Map<String, dynamic> deviceData = {};

    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        deviceData = {
          'platform': 'Android',
          'model': androidInfo.model,
          'manufacturer': androidInfo.manufacturer,
          'version': androidInfo.version.release,
          'sdkInt': androidInfo.version.sdkInt,
          'brand': androidInfo.brand,
          'device': androidInfo.device,
          'id': androidInfo.id,
        };
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        deviceData = {
          'platform': 'iOS',
          'model': iosInfo.model,
          'name': iosInfo.name,
          'systemName': iosInfo.systemName,
          'systemVersion': iosInfo.systemVersion,
          'identifierForVendor': iosInfo.identifierForVendor,
        };
      }
    } catch (e) {
      print('❌ Device info retrieval failed: $e');
    }

    return deviceData;
  }

  /// Get device information
  static Map<String, dynamic>? get deviceInfo => _deviceData;

  /// Get platform name
  static String get platformName => _deviceData?['platform'] ?? 'Unknown';

  /// Get device model
  static String get deviceModel => _deviceData?['model'] ?? 'Unknown';

  /// Check if app version is supported
  static bool isVersionSupported(String minVersion) {
    try {
      List<int> currentVersion = version.split('.').map(int.parse).toList();
      List<int> minimumVersion = minVersion.split('.').map(int.parse).toList();

      for (int i = 0; i < currentVersion.length && i < minimumVersion.length; i++) {
        if (currentVersion[i] > minimumVersion[i]) return true;
        if (currentVersion[i] < minimumVersion[i]) return false;
      }

      return currentVersion.length >= minimumVersion.length;
    } catch (e) {
      return true; // Default to supported if parsing fails
    }
  }

  /// Get app headers for API requests
  static Map<String, String> get apiHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': '$appName/$fullVersion ($platformName)',
    'X-App-Version': version,
    'X-Build-Number': buildNumber,
    'X-Platform': platformName,
    'X-Device-Model': deviceModel,
  };

  /// Environment-specific configurations
  static Map<String, dynamic> get environmentConfig => {
    'debug': {
      'enableLogging': true,
      'enableAnalytics': false,
      'enableCrashlytics': false,
      'apiTimeout': 60, // seconds
    },
    'release': {
      'enableLogging': false,
      'enableAnalytics': true,
      'enableCrashlytics': true,
      'apiTimeout': 30, // seconds
    },
  }[isDebug ? 'debug' : 'release'] ?? {};

  /// Check if feature is enabled
  static bool isFeatureEnabled(String feature) {
    switch (feature) {
      case 'chat':
        return isChatEnabled;
      case 'telemedicine':
        return isTelemedicineEnabled;
      case 'biometric_auth':
        return true; // Always enabled
      case 'offline_mode':
        return true; // Always enabled
      default:
        return false;
    }
  }

  /// Get configuration value with fallback
  static T getConfigValue<T>(String key, T defaultValue) {
    final config = environmentConfig;
    return config[key] ?? defaultValue;
  }
}