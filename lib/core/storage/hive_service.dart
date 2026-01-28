import '../config/hive_config.dart';
import '../constants/storage_keys.dart';

class HiveService {
  // User data operations
  static Future<void> saveUserData(String key, dynamic value) async {
    await HiveConfig.userBox.put(key, value);
  }

  static T? getUserData<T>(String key) {
    return HiveConfig.userBox.get(key);
  }

  static Future<void> clearUserData() async {
    await HiveConfig.userBox.clear();
  }

  // Settings operations
  static Future<void> saveSetting(String key, dynamic value) async {
    await HiveConfig.settingsBox.put(key, value);
  }

  static T? getSetting<T>(String key) {
    return HiveConfig.settingsBox.get(key);
  }

  // Cache operations with TTL
  static Future<void> cacheData(
    String key,
    dynamic value, {
    Duration? ttl,
  }) async {
    final cacheItem = {
      'data': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'ttl': ttl?.inMilliseconds,
    };
    await HiveConfig.cacheBox.put(key, cacheItem);
  }

  static T? getCachedData<T>(String key) {
    final cacheItem = HiveConfig.cacheBox.get(key);
    if (cacheItem == null) return null;

    final timestamp = cacheItem['timestamp'] as int;
    final ttl = cacheItem['ttl'] as int?;

    if (ttl != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - timestamp > ttl) {
        HiveConfig.cacheBox.delete(key);
        return null;
      }
    }

    return cacheItem['data'] as T;
  }

  // Secure data operations (for tokens, sensitive info)
  static Future<void> saveSecureData(String key, String value) async {
    await HiveConfig.secureBox.put(key, value);
  }

  static String? getSecureData(String key) {
    return HiveConfig.secureBox.get(key);
  }

  static Future<void> deleteSecureData(String key) async {
    await HiveConfig.secureBox.delete(key);
  }

  // Authentication helpers
  static Future<void> saveAuthData({
    required String userId,
    required String userRole,
    required String token,
    String? refreshToken,
  }) async {
    await saveUserData(StorageKeys.userId, userId);
    await saveUserData(StorageKeys.userRole, userRole);
    await saveUserData(StorageKeys.isLoggedIn, true);
    await saveSecureData(StorageKeys.userToken, token);
    if (refreshToken != null) {
      await saveSecureData(StorageKeys.refreshToken, refreshToken);
    }
  }

  static bool get isLoggedIn =>
      getUserData<bool>(StorageKeys.isLoggedIn) ?? false;
  static String? get userRole => getUserData<String>(StorageKeys.userRole);
  static String? get userToken => getSecureData(StorageKeys.userToken);

  static Future<void> logout() async {
    await clearUserData();
    await HiveConfig.secureBox.clear();
  }
}
