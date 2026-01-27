import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controllers/theme_controller.dart';

class ThemeAwareAppBar extends StatelessWidget implements PreferredSizeWidget {

  const ThemeAwareAppBar({
    required this.title, super.key,
    this.actions,
    this.showThemeToggle = true,
  });
  final String title;
  final List<Widget>? actions;
  final bool showThemeToggle;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return AppBar(
      title: Text(title),
      actions: [
        if (showThemeToggle)
          Obx(() => PopupMenuButton<AppThemeMode>(
            icon: Icon(_getThemeIcon(themeController.currentThemeMode)),
            tooltip: 'Theme Settings',
            onSelected: themeController.setThemeMode,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: AppThemeMode.light,
                child: Row(
                  children: [
                    const Icon(Icons.light_mode),
                    const SizedBox(width: 8),
                    const Text('Light'),
                    if (themeController.currentThemeMode == AppThemeMode.light)
                      const Spacer(),
                    if (themeController.currentThemeMode == AppThemeMode.light)
                      const Icon(Icons.check),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AppThemeMode.dark,
                child: Row(
                  children: [
                    const Icon(Icons.dark_mode),
                    const SizedBox(width: 8),
                    const Text('Dark'),
                    if (themeController.currentThemeMode == AppThemeMode.dark)
                      const Spacer(),
                    if (themeController.currentThemeMode == AppThemeMode.dark)
                      const Icon(Icons.check),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AppThemeMode.system,
                child: Row(
                  children: [
                    const Icon(Icons.settings_suggest),
                    const SizedBox(width: 8),
                    const Text('System'),
                    if (themeController.currentThemeMode == AppThemeMode.system)
                      const Spacer(),
                    if (themeController.currentThemeMode == AppThemeMode.system)
                      const Icon(Icons.check),
                  ],
                ),
              ),
            ],
          ),),
        ...?actions,
      ],
    );
  }

  IconData _getThemeIcon(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
        return Icons.settings_suggest;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}