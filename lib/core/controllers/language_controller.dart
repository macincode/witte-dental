import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../storage/hive_service.dart';

class LanguageController extends GetxController {
  final RxString _currentLanguage = 'en'.obs;
  String get currentLanguage => _currentLanguage.value;
  
  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }
  
  void _loadLanguage() {
    final savedLanguage = HiveService.getSetting<String>('language') ?? 'en';
    _currentLanguage.value = savedLanguage;
    Get.updateLocale(Locale(savedLanguage));
  }
  
  void changeLanguage(String languageCode) {
    _currentLanguage.value = languageCode;
    HiveService.saveSetting('language', languageCode);
    Get.updateLocale(Locale(languageCode));
  }
  
  void showLanguageDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('select_language'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇺🇸'),
              title: const Text('English'),
              trailing: currentLanguage == 'en' ? const Icon(Icons.check) : null,
              onTap: () {
                changeLanguage('en');
                Get.back();
              },
            ),
            ListTile(
              leading: const Text('🇮🇳'),
              title: const Text('தமிழ்'),
              trailing: currentLanguage == 'ta' ? const Icon(Icons.check) : null,
              onTap: () {
                changeLanguage('ta');
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}