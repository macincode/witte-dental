import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';

class FirebaseService {
  static FirebaseAnalytics? _analytics;
  static FirebaseCrashlytics? _crashlytics;
  static FirebasePerformance? _performance;
  static FirebaseMessaging? _messaging;
  static FirebaseRemoteConfig? _remoteConfig;

  static FirebaseAnalytics get analytics => _analytics!;
  static FirebaseCrashlytics get crashlytics => _crashlytics!;
  static FirebasePerformance get performance => _performance!;
  static FirebaseMessaging get messaging => _messaging!;
  static FirebaseRemoteConfig get remoteConfig => _remoteConfig!;

  /// Initialize Firebase services
  static Future<void> initialize() async {
    try {
      // Initialize Firebase
      await Firebase.initializeApp();

      // Initialize Analytics
      _analytics = FirebaseAnalytics.instance;
      await _analytics!.setAnalyticsCollectionEnabled(!kDebugMode);

      // Initialize Crashlytics
      _crashlytics = FirebaseCrashlytics.instance;
      await _crashlytics!.setCrashlyticsCollectionEnabled(!kDebugMode);

      // Set up Crashlytics error handling
      FlutterError.onError = _crashlytics!.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        _crashlytics!.recordError(error, stack, fatal: true);
        return true;
      };

      // Initialize Performance Monitoring
      _performance = FirebasePerformance.instance;
      await _performance!.setPerformanceCollectionEnabled(!kDebugMode);

      // Initialize Messaging
      _messaging = FirebaseMessaging.instance;
      await _setupMessaging();

      // Initialize Remote Config
      _remoteConfig = FirebaseRemoteConfig.instance;
      await _setupRemoteConfig();

      dPrint('✅ Firebase services initialized successfully');
    } catch (e, stackTrace) {
      dPrint('❌ Firebase initialization failed: $e');
      if (_crashlytics != null) {
        await _crashlytics!.recordError(e, stackTrace);
      }
    }
  }

  /// Setup Firebase Messaging
  static Future<void> _setupMessaging() async {
    try {
      // Request permission for iOS
      final settings = await _messaging!.requestPermission();

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        dPrint('✅ User granted permission for notifications');
      } else {
        dPrint(
          '⚠️ User declined or has not accepted permission for notifications',
        );
      }

      // Get FCM token
      final token = await _messaging!.getToken();
      dPrint('📱 FCM Token: $token');

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        dPrint('📨 Received foreground message: ${message.messageId}');
        _handleMessage(message);
      });

      // Handle message when app is opened from notification
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        dPrint('📱 App opened from notification: ${message.messageId}');
        _handleMessage(message);
      });
    } catch (e) {
      dPrint('❌ Messaging setup failed: $e');
    }
  }

  /// Setup Remote Config
  static Future<void> _setupRemoteConfig() async {
    try {
      await _remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: kDebugMode
              ? const Duration(minutes: 1)
              : const Duration(hours: 1),
        ),
      );

      // Set default values
      await _remoteConfig!.setDefaults({
        'app_maintenance_mode': false,
        'min_app_version': '1.0.0',
        'feature_chat_enabled': true,
        'feature_telemedicine_enabled': false,
        'api_base_url': 'https://api.wittedental.com',
      });

      await _remoteConfig!.fetchAndActivate();
      dPrint('✅ Remote Config initialized');
    } catch (e) {
      dPrint('❌ Remote Config setup failed: $e');
    }
  }

  /// Handle incoming messages
  static void _handleMessage(RemoteMessage message) {
    final data = message.data;
    final notification = message.notification;

    // Log analytics event
    _analytics?.logEvent(
      name: 'notification_received',
      parameters: {
        'message_id': message.messageId ?? 'unknown',
        'type': data['type'] ?? 'general',
      },
    );

    // Handle different message types
    switch (data['type']) {
      case 'appointment_reminder':
        _handleAppointmentReminder(data);
        break;
      case 'payment_due':
        _handlePaymentDue(data);
        break;
      case 'system_update':
        _handleSystemUpdate(data);
        break;
      default:
        dPrint('📨 General notification: ${notification?.title}');
    }
  }

  static void _handleAppointmentReminder(Map<String, dynamic> data) {
    dPrint('📅 Appointment reminder: ${data['appointment_id']}');
    // Navigate to appointment details
  }

  static void _handlePaymentDue(Map<String, dynamic> data) {
    dPrint('💰 Payment due: ${data['invoice_id']}');
    // Navigate to payment screen
  }

  static void _handleSystemUpdate(Map<String, dynamic> data) {
    dPrint('🔄 System update: ${data['message']}');
    // Show system update dialog
  }

  /// Log custom analytics event
  static Future<void> logEvent(
    String name,
    Map<String, Object>? parameters,
  ) async {
    try {
      await _analytics?.logEvent(name: name, parameters: parameters);
    } catch (e) {
      dPrint('❌ Analytics event logging failed: $e');
    }
  }

  /// Log custom error
  static Future<void> logError(
    dynamic error,
    StackTrace? stackTrace, {
    String? reason,
  }) async {
    try {
      await _crashlytics?.recordError(error, stackTrace, reason: reason);
    } catch (e) {
      dPrint('❌ Error logging failed: $e');
    }
  }

  /// Set user properties for analytics
  static Future<void> setUserProperties({
    required String userId,
    String? userRole,
    String? hospitalId,
  }) async {
    try {
      await _analytics?.setUserId(id: userId);
      await _analytics?.setUserProperty(name: 'user_role', value: userRole);
      await _analytics?.setUserProperty(name: 'hospital_id', value: hospitalId);

      await _crashlytics?.setUserIdentifier(userId);
      await _crashlytics?.setCustomKey('user_role', userRole ?? 'unknown');
      await _crashlytics?.setCustomKey('hospital_id', hospitalId ?? 'unknown');
    } catch (e) {
      dPrint('❌ User properties setup failed: $e');
    }
  }

  /// Get Remote Config value
  static T getRemoteConfigValue<T>(String key, T defaultValue) {
    try {
      final value = _remoteConfig?.getValue(key);
      if (value == null) return defaultValue;

      if (T == bool) return value.asBool() as T;
      if (T == int) return value.asInt() as T;
      if (T == double) return value.asDouble() as T;
      if (T == String) return value.asString() as T;

      return defaultValue;
    } catch (e) {
      dPrint('❌ Remote Config value retrieval failed: $e');
      return defaultValue;
    }
  }

  /// Create performance trace
  static Trace createTrace(String name) {
    return _performance!.newTrace(name);
  }
}

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  dPrint('📨 Background message: ${message.messageId}');
}
