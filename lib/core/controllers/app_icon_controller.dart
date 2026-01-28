import 'package:get/get.dart';

import '../storage/hive_service.dart';

class AppIconController extends GetxController {
  final RxString _currentIcon = 'default'.obs;

  String get currentIcon => _currentIcon.value;

  // Predefined app icons for UI customization
  final List<AppIconOption> availableIcons = [
    AppIconOption('default', 'Default', 'Default healthcare icon'),
    AppIconOption('dark', 'Dark Mode', 'Dark theme icon'),
    AppIconOption('minimal', 'Minimal', 'Clean minimal design'),
    AppIconOption('classic', 'Classic', 'Traditional medical icon'),
  ];

  @override
  void onInit() {
    super.onInit();
    _loadCurrentIcon();
  }

  void _loadCurrentIcon() {
    final savedIcon = HiveService.getSetting<String>('app_icon');
    _currentIcon.value = savedIcon ?? 'default';
  }

  Future<bool> changeAppIcon(String iconName) async {
    try {
      // Save preference for UI customization
      _currentIcon.value = iconName;
      await HiveService.saveSetting('app_icon', iconName);

      // Show success message
      Get.snackbar(
        'Icon Updated',
        'App icon preference saved. Restart app to see changes.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}

class AppIconOption {
  AppIconOption(this.id, this.name, this.description);
  final String id;
  final String name;
  final String description;
}
