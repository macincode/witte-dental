import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/storage_keys.dart';
import '../storage/hive_service.dart';

enum AppThemeMode { light, dark, system }

class ThemeController extends GetxController {
  final Rx<AppThemeMode> _themeMode = AppThemeMode.system.obs;

  AppThemeMode get currentThemeMode => _themeMode.value;

  ThemeMode get themeMode {
    switch (_themeMode.value) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() {
    final savedTheme = HiveService.getSetting<String>(StorageKeys.theme);
    if (savedTheme != null) {
      _themeMode.value = AppThemeMode.values.firstWhere(
        (mode) => mode.name == savedTheme,
        orElse: () => AppThemeMode.system,
      );
    }
  }

  void setThemeMode(AppThemeMode mode) {
    _themeMode.value = mode;
    HiveService.saveSetting(StorageKeys.theme, mode.name);
    Get.changeThemeMode(themeMode);
  }

  void toggleTheme() {
    switch (_themeMode.value) {
      case AppThemeMode.light:
        setThemeMode(AppThemeMode.dark);
        break;
      case AppThemeMode.dark:
        setThemeMode(AppThemeMode.system);
        break;
      case AppThemeMode.system:
        setThemeMode(AppThemeMode.light);
        break;
    }
  }
}
