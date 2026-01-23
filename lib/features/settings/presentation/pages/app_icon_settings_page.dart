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
        appBar: ThemeAwareAppBar(
          title: 'app_icon_settings'.tr,
          showThemeToggle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'choose_app_icon'.tr,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'icon_selection_desc'.tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: iconController.availableIcons.length,
                  itemBuilder: (context, index) {
                    final icon = iconController.availableIcons[index];
                    
                    return Obx(() {
                      final isSelected = iconController.currentIcon == icon.id;
                      
                      return Card(
                        elevation: isSelected ? 8 : 2,
                        child: InkWell(
                          onTap: () => _changeIcon(context, iconController, icon.id),
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isSelected 
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.surfaceVariant,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.local_hospital,
                                    size: 24,
                                    color: isSelected 
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Flexible(
                                  child: Text(
                                    icon.name,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'active'.tr,
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
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
        'note'.tr,
        'icon_change_note'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        colorText: Theme.of(context).colorScheme.onSurfaceVariant,
      );
    }
  }
}