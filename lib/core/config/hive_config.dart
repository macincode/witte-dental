import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:witte_dental_pms/features/auth/data/models/admin_login_response.dart';
import 'package:witte_dental_pms/features/auth/data/models/settings_access_model.dart';
import 'package:witte_dental_pms/features/auth/data/models/user_model.dart';

import '../constants/storage_keys.dart';

class HiveConfig {
  static late Box _userBox;
  static late Box _settingsBox;
  static late Box _cacheBox;
  static late Box<String> _secureBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    // Clear all existing data to resolve typeId conflicts
    await Hive.deleteBoxFromDisk(StorageKeys.userBox);
    await Hive.deleteBoxFromDisk(StorageKeys.settingsBox);
    await Hive.deleteBoxFromDisk(StorageKeys.cacheBox);
    await Hive.deleteBoxFromDisk(StorageKeys.secureBox);

    // Generate encryption key for sensitive data
    final encryptionKey = _generateEncryptionKey();

    // Register adapters
    Hive
      ..registerAdapter(AdminLoginResponseAdapter())
      ..registerAdapter(UserAdapter())
      ..registerAdapter(SettingsAccessAdapter());

    // Open boxes
    _userBox = await Hive.openBox(StorageKeys.userBox);
    _settingsBox = await Hive.openBox(StorageKeys.settingsBox);
    _cacheBox = await Hive.openBox(StorageKeys.cacheBox);
    _secureBox = await Hive.openBox<String>(
      StorageKeys.secureBox,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  static List<int> _generateEncryptionKey() {
    const keyString = 'healthcare_app_secure_key_2024';
    return sha256.convert(utf8.encode(keyString)).bytes;
  }

  // Getters for boxes
  static Box get userBox => _userBox;
  static Box get settingsBox => _settingsBox;
  static Box get cacheBox => _cacheBox;
  static Box<String> get secureBox => _secureBox;

  static Future<void> clearAllData() async {
    await _userBox.clear();
    await _settingsBox.clear();
    await _cacheBox.clear();
    await _secureBox.clear();
  }
}
