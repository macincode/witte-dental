import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/controllers/app_icon_controller.dart';
import '../../../shared/widgets/theme_aware_app_bar.dart';
import '../../../shared/widgets/network_aware_widget.dart';

class AppIconSettingsPage extends StatelessWidget {
  const AppIconSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final iconController = Get.put(AppIconController());
    
    return NetworkAwareWidget(
      child: Scaffold(
        appBar: const ThemeAwareAppBar(
          title: 'App Icon Settings',
          showThemeToggle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose App Icon',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select from predefined healthcare-themed icons',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Obx(() => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: iconController.availableIcons.length,
                  itemBuilder: (context, index) {
                    final icon = iconController.availableIcons[index];
                    final isSelected = iconController.currentIcon == icon.id;
                    
                    return Card(
                      elevation: isSelected ? 8 : 2,
                      child: InkWell(
                        onTap: () => _changeIcon(context, iconController, icon.id),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: isSelected 
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.surfaceVariant,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.local_hospital,
                                  size: 32,
                                  color: isSelected 
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                icon.name,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                icon.description,
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (isSelected)
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Active',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeIcon(BuildContext context, AppIconController controller, String iconId) async {
    final success = await controller.changeAppIcon(iconId);
    
    if (!success) {
      Get.snackbar(
        'Note',
        'Icon preference saved. Dynamic icon changing requires additional native setup.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        colorText: Theme.of(context).colorScheme.onSurfaceVariant,
      );
    }
  }
}