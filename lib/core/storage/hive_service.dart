import 'package:hive_flutter/hive_flutter.dart';
import 'package:witte_dental_pms/core/config/hive_config.dart';
import 'package:witte_dental_pms/core/constants/storage_keys.dart';
import 'package:witte_dental_pms/features/auth/data/models/admin_login_response.dart';

class HiveService {
  static const String authBoxName = 'authBox';

  Future<void> init() async {
    await Hive.initFlutter();
    // Register adapters here
    // Hive.registerAdapter(AdminLoginResponseAdapter());
    // ... other adapters

    // Check if box is already open
    if (!Hive.isBoxOpen(authBoxName)) {
      await Hive.openBox<AdminLoginResponse>(authBoxName);
    }
  }

  Future<void> saveAuthResponse(AdminLoginResponse response) async {
    final box = Hive.box<AdminLoginResponse>(authBoxName);
    await box.put('auth', response);
  }

  AdminLoginResponse? getAuthResponse() {
    final box = Hive.box<AdminLoginResponse>(authBoxName);
    return box.get('auth');
  }

  Future<void> clearAuthBox() async {
    final box = Hive.box<AdminLoginResponse>(authBoxName);
    await box.clear();
  }

  // Clear all app data on logout
  static Future<void> clearAllData() async {
    await HiveConfig.settingsBox.clear();
    // Keep onboarding_completed setting
    final onboardingCompleted =
        HiveConfig.settingsBox.get('onboarding_completed');
    if (onboardingCompleted != null) {
      await HiveConfig.settingsBox
          .put('onboarding_completed', onboardingCompleted);
    }
  }

  // Settings operations (kept for onboarding check)
  static T? getSetting<T>(String key) {
    return HiveConfig.settingsBox.get(key);
  }

  static Future<void> saveSetting(String key, dynamic value) async {
    await HiveConfig.settingsBox.put(key, value);
  }
}
